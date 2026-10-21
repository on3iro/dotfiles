# Updating mise-managed tools

```fish
mise self-update       # update mise itself
mise lock --bump       # re-resolve "latest"/range requests to newest versions, updates mise.lock only
mise install           # install the versions now pinned in mise.lock
```

Review the `mise.lock` diff before committing, then commit `config.toml` + `mise.lock` together.

Bump a single tool instead of everything:
```fish
mise lock --bump neovim
mise install
```
