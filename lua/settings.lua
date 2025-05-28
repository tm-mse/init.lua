local global = vim.g
local o = vim.opt

o.termguicolors = true
o.syntax = "on"

_G.PLUGINS = function ()
	for k, v in pairs(require('lazy').plugins()) do
		print("[" .. k .. "](" .. v.url .. ")")
	end
end

