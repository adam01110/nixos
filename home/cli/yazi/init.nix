{
  config,
  lib,
  pkgs,
  ...
}:

let
  initFile = pkgs.writers.writeLuaBin "init" { } ''
    function Linemode:size_mtime()
        local mtime_num = math.floor(self._file.cha.mtime or 0)
        local mtime_str
        if mtime_num == 0 then
            mtime_str = ""
        else
            mtime_str = os.date("%Y-%m-%d %H:%M", mtime_num)
        end

        local size = self._file:size()

        return string.format("%s %s",
            size and ya.readable_size(size) or "-",
            mtime_str)
    end

    -- starship.yazi

    require("starship"):setup()

    -- wl-clipboard.yazi

    local selected_or_hovered = ya.sync(function()
        local tab, paths = cx.active, {}
        for _, u in pairs(cx.yanked) do
            paths[#paths + 1] = tostring(u)
        end
        if #paths == 0 and tab.current.hovered then
            paths[1] = tostring(tab.current.hovered.url)
        end
        return paths
    end)

    return {
        entry = function()
            ya.manager_emit("escape", { visual = true })

            local urls = selected_or_hovered()

            if #urls == 0 then
                return ya.notify({ title = "System Clipboard", content = "No file selected", level = "warn", timeout = 5 })
            end

            -- ya.notify({ title = #urls, content = table.concat(urls, " "), level = "info", timeout = 5 })

            -- Format the URLs for `text/uri-list` specification
            local function encode_uri(uri)
                return uri:gsub("([^%w%-%._~:/])", function(c)
                    return string.format("%%%02X", string.byte(c))
                end)
            end

            local file_list_formatted = ""
            for _, path in ipairs(urls) do
                -- Each file path must be URI-encoded and prefixed with "file://"
                file_list_formatted = file_list_formatted .. "file://" .. encode_uri(path) .. "\r\n"
            end

            local status, err =
                Command("wl-copy"):arg("--type"):arg("text/uri-list"):arg(file_list_formatted):spawn():wait()

            if status or status.succes then
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
                    content = string.format("Could not copy selected file(s) %s", status and status.code or err),
                    level = "error",
                    timeout = 5,
                })
            end
        end,
    }

  '';
in
{
  programs.yazi.initLua = initFile;
}
