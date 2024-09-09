return {
  'nvim-lualine/lualine.nvim',
  config = function()
    require('lualine').setup {
      options = {
        icons_enabled = true,
        theme = "auto",
        globalstatus = true,
        component_separators = { left = '|', right = '|' },
        section_separators = { left = '', right = '' },
      },
      sections = {
        lualine_x = { 'encoding' },
        lualine_z = { 'location' }
      },
      tabline = {
        lualine_a = { 'buffers' },
      },
    }
  end
}
