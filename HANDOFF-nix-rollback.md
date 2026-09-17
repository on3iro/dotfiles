# Handoff: reverting the mise migration back to nix-darwin

Written 2026-09-17, at the end of Phases 1-4 of a nix-darwin -> mise migration,
immediately before Phase 5 (nix-darwin/Nix removal). **Phase 5 was NOT executed.**
nix-darwin and the Nix installation are fully intact and untouched as of this
writing. That's what makes this rollback comparatively easy - if you're reading
this after Phase 5 *has* since run, this document is insufficient; you'd be
looking at a from-scratch Nix reinstall instead, which is out of scope here.

## Context for the next session

The user (Theo) has a nix-darwin flake at `nix/` in this repo (`dotfiles`)
managing macOS system packages, macOS defaults, and (formerly, already disabled
before this migration) Homebrew via `nix-homebrew` - see `nix/config/darwin.nix`,
`nix/config/pkgs.common.nix`, `nix/flake.nix`, and the dead `nix/config/homebrew.nix.bak`
(confirmed unreferenced by the live flake; Homebrew was already standalone before
this migration started).

Across Phases 1-4 we moved most of that to mise (`~/.config/mise/config.toml`,
NOT git-tracked/dotbot-managed - it's a standalone file) plus a few direct
Homebrew installs, without ever touching nix-darwin itself. This doc undoes the
mise/Homebrew/fish-config side so nix-darwin becomes authoritative again.

## What actually changed this session

1. **`~/.config/mise/config.toml`** - added a `[tools]` block (22 pinned CLI
   tools), a `[bootstrap.packages]` block (7 brew formulae + 2 brew casks), and a
   `[bootstrap.macos.defaults]` block (dock/finder/screencapture/NSGlobalDomain).
   Two untouched backups exist from before any of this:
   - `~/.config/mise/config.toml.bak-20260917-111733` (before Phase 1 - this is
     the one to restore from for a full revert)
   - `~/.config/mise/config.toml.bak-20260917-112511-phase3` (after Phase 1, before Phase 3)
2. **mise itself** was upgraded from nix-provided `2026.8.3` to a standalone
   install at `~/.local/bin/mise` (`2026.9.10`, self-update capable), installed via
   `curl -fsSL https://mise.run | sh`.
3. **`config/fish/config.fish`** - removed the line
   `set PATH $PATH /Users/theo/.local/bin` (previously the last line of the file,
   under a comment `# Created by \`pipx\` on 2025-09-26 16:02:55`). It was moved
   into `00-nix-init.fish` instead (see below), so this file now ends without
   that line/comment at all.
4. **`config/fish/conf.d/00-nix-init.fish`** - reordered PATH setup so
   Homebrew wins over nix, and added a new prepend of `~/.local/bin` at the very
   end (highest priority). Original order was: nix-profile symlink check ->
   Homebrew (Apple Silicon) prepend -> Homebrew (Intel) prepend -> nix-profile/bin
   prepend -> `/run/current-system/sw/bin` prepend -> nix-daemon.fish source ->
   nix vendor completions source. It's now: nix-profile symlink check ->
   nix-profile/bin prepend -> `/run/current-system/sw/bin` prepend -> Homebrew
   (Intel) prepend -> Homebrew (Apple Silicon) prepend -> nix-daemon.fish source
   -> nix vendor completions source -> `~/.local/bin` prepend (new).
5. **Homebrew installs** (all via `mise bootstrap packages apply`, plus one
   manual): `ack`, `rusty-ferris-club/tap/shellclear`, `httpie`, `nmap`,
   `universal-ctags`, `imagemagick`, `clipboard`, `pika` (cask),
   `android-commandlinetools` (cask), and manually `brew install --cask
   nikitabobko/tap/aerospace` (mise's cask DSL evaluator couldn't handle this
   tap's `staged_path` postflight step). `chromium` cask was skipped entirely
   (Homebrew had it disabled, `fails_gatekeeper_check`, as of 2026-09-01).
6. **macOS defaults applied for real** via `mise bootstrap macos defaults apply`
   - in practice 27 of 28 values already matched what nix-darwin had set (nix's
     declared config and the live system agreed), the one actual change was
     flipping `com.apple.dock autohide` from `false` (drifted manually at some
     point) back to `true` to match the nix-darwin declaration.
7. Deleted an unrelated stray file, `/usr/local/bin/shellclear` (owned by a
   nonexistent uid 1001, unconnected to nix or this migration - not part of the
   revert, just housekeeping).

nix-darwin's own files (`nix/flake.nix`, `nix/flake.lock`, `nix/config/darwin.nix`,
`nix/config/pkgs.common.nix`) were **never edited**. The Nix daemon, nix store,
and nix-darwin's system generation are untouched and should still work exactly
as before this migration started.

## Rollback steps

**1. Restore the mise config to its pre-migration state:**
```fish
cp ~/.config/mise/config.toml.bak-20260917-111733 ~/.config/mise/config.toml
```
This removes all of Phases 1-3's `[tools]`/`[bootstrap.*]` additions in one
step, restoring the original small config (flutter, ain, golangci-lint, gum,
htmlq, lnav, node, httpyac, python, ruby, superhtml, yarn, yq, plus the
`klaus` task).

**2. Revert the two fish files.** First check what's actually changed - the
sandbox this migration ran in couldn't read `.git` directly, so these edits
were never diffed against git; do that now:
```fish
git status --short
git diff -- config/fish/config.fish config/fish/conf.d/00-nix-init.fish
```
If that diff matches what's described in section 3/4 above and nothing else
has touched these files since, the clean revert is:
```fish
git checkout -- config/fish/config.fish config/fish/conf.d/00-nix-init.fish
```
(Only safe if these changes were never committed - check `git log -p` on these
two files first if `git checkout` doesn't show the expected diff disappearing,
in case they were committed in the meantime and need `git revert` instead.)

**3. Restart the shell and confirm nix wins again:**
```fish
exec fish
which mise bat rg fd eza nvim
```
These should now resolve back under `/run/current-system/sw/bin/` or
`/nix/...` rather than `~/.local/bin`/`~/.local/share/mise/...`/`/opt/homebrew`.

**4. Re-assert nix-darwin's system state** (should be a no-op since its config
was never touched, but confirms the generation is still healthy after sitting
dormant):
```fish
darwin-rebuild switch --flake ~/dotfiles/nix
```

**5. Decide what to do with the Homebrew-side additions from step 5 above**
(`ack`, `shellclear`, `httpie`, `nmap`, `universal-ctags`, `imagemagick`,
`clipboard`, `pika`, `android-commandlinetools`, `aerospace`). These don't
conflict with nix-darwin - PATH will just prefer the nix-provided copies again
after step 2-3 - but if you want a fully clean Homebrew back to its
pre-migration state too:
```fish
brew uninstall ack "rusty-ferris-club/tap/shellclear" httpie nmap universal-ctags imagemagick clipboard
brew uninstall --cask pika android-commandlinetools "nikitabobko/tap/aerospace"
brew untap rusty-ferris-club/tap
brew untap nikitabobko/tap   # only if not used for anything else
```
This step is optional - leaving them installed is harmless, just redundant
with what nix now provides again.

## Known gotchas from this migration (useful if you retry mise-ward later)

- **mise itself cannot be one of its own `[tools]` entries** (chicken-and-egg).
  It must be installed standalone (`curl -fsSL https://mise.run | sh`) and given
  PATH priority manually, or it'll keep re-resolving to whatever provided it
  before (nix, in this case).
- **The fish function named `mise`** (from `conf.d/mise.fish` running
  `mise activate fish | source`) bakes in the *absolute path* of whatever `mise`
  resolved to at the moment it ran - not a dynamic PATH lookup. If `mise` itself
  moves, that conf.d file needs to re-run *after* PATH is corrected, which means
  PATH fixes need to happen in a `conf.d` file that loads before `mise.fish`
  alphabetically (a plain `config.fish` edit loads too late).
- **mise's `[tools]` registry doesn't cover everything** - things without an
  aqua/cargo-backed entry (this migration hit `lua`, `imagemagick`) either build
  from source (slow, sometimes fine, as with `lua`) or fail outright to resolve
  an exact version (as `imagemagick` did via conda) and need a `brew:` fallback
  instead.
- **Homebrew tap syntax**: a GitHub repo literally named `owner/homebrew-foo`
  is referred to as tap `owner/foo` (Homebrew adds the `homebrew-` prefix
  itself) - writing `owner/homebrew-foo` in a `brew:`/`brew-cask:` string
  double-prefixes and 404s.
- **mise's cask evaluator is incomplete** - it can't evaluate every valid Cask
  DSL method (hit `staged_path` in a postflight block for the `aerospace` cask);
  such casks need a plain manual `brew install --cask` instead.
- **Ansible's reported version and its pip package version are different
  numbers** - `ansible --version` reports the bundled `ansible-core` version,
  not the outer `ansible` package version mise's `pipx:ansible` backend
  actually pins against. Don't pin one against the other.
