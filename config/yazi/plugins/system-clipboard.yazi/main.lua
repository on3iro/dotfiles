-- Meant to run at async context. (yazi system-clipboard)

local selected_or_hovered = ya.sync(function()
  local tab, paths = cx.active, {}
  for _, u in pairs(tab.selected) do
    paths[#paths + 1] = tostring(u)
  end
  if #paths == 0 and tab.current.hovered then
    paths[1] = tostring(tab.current.hovered.url)
  end
  return paths
end)

return {
  entry = function()
    ya.err("system-clipboard: entry invoked")

    ya.emit("escape", { visual = true })
    ya.err("system-clipboard: after escape emit")

    local urls = selected_or_hovered()
    ya.err("system-clipboard: got " .. #urls .. " url(s)")

    if #urls == 0 then
      return ya.notify({ title = "System Clipboard", content = "No file selected", level = "warn", timeout = 5 })
    end

    ya.err("system-clipboard: before spawn, urls=" .. table.concat(urls, " "))
    local output, err =
        Command("/run/current-system/sw/bin/cb")
        :arg("copy")
        :arg(urls[1])
        :stdin(Command.NULL)
        :stdout(Command.PIPED)
        :stderr(Command.PIPED)
        :output()
    local status = output and output.status
    ya.err(
      "system-clipboard: after output, status="
        .. tostring(status)
        .. " err="
        .. tostring(err)
        .. " stdout="
        .. tostring(output and output.stdout)
        .. " stderr="
        .. tostring(output and output.stderr)
    )

    if status and status.success then
      ya.notify({
        title = "System Clipboard",
        content = "Succesfully copied the file(s) to system clipboard",
        level = "info",
        timeout = 5,
      })
    end

    if not status or not status.success then
      ya.notify({
        title = "System Clipboard",
        content = string.format(
          "Could not copy selected file(s) %s",
          status and status.code or err
        ),
        level = "error",
        timeout = 5,
      })
    end
  end,
}
