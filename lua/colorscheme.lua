vim.o.background = "dark"
vim.g.tokyonight_style = "storm" -- day / night
-- transparent
vim.g.tokyonight_transparent = true
-- vim.g.tokyonight_transparent_sidebar = true
local colorscheme = "tokyonight"
-- tokyonight
-- OceanicNext
-- nord
-- onedark
-- nightfox
local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
  error("can't find colorscheme: " .. colorscheme .. " ！")
end
