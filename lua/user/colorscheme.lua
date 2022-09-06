vim.cmd [[
try
  colorscheme darcula-solid
  set termguicolors
catch /^Vim\%((\a\+)\)\=:E185/
  colorscheme tokyonight-night
endtry
]]
