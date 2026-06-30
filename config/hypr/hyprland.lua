-- Get hostname from envvars or something
local handle = io.popen("hostname")
Hostname = "unknown" -- Default fallback

-- If there is a hostname at all
if handle then
	local result = handle:read("*l") -- Read the first line
	handle:close()
	if result then
		Hostname = result:gsub("%s+", "") -- Remove whitespace/newlines
	end
end

-- Import everything else
local modules = os.getenv("HOME") .. "/nixos-dotfiles/config/hypr/modules"
local p = io.popen('find -L "' .. modules .. '" -name "*.lua" -type f | sort')
if p then
    for file in p:lines() do
        local module = file:match("([^/]+)%.[^%.]+$")
        if module then
            require("modules." .. module)
        end
    end
    p:close()
end
