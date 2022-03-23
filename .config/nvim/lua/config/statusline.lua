local gl = require('galaxyline')
local gls = gl.section

-- source provider function
local diagnostic = require('galaxyline.provider_diagnostic')
local vcs = require('galaxyline.provider_vcs')
local fileinfo = require('galaxyline.provider_fileinfo')
local extension = require('galaxyline.provider_extensions')
local buffer = require('galaxyline.provider_buffer')
local whitespace = require('galaxyline.provider_whitespace')
local lspclient = require('galaxyline.provider_lsp')

-- todo move me
require('gitsigns').setup()

-- fill it with absolute colors
-- colors stolen from gruvbox
local colors = {
  ['dark0_hard']  = '#1d2021',
  ['dark0']       = '#282828',
  ['dark0_soft']  = '#32302f',
  ['dark1']       = '#3c3836',
  ['dark2']       = '#504945',
  ['dark3']       = '#665c54',
  ['dark4']       = '#7c6f64',
  ['dark4_256']   = '#7c6f64',

  ['gray_245']    = '#928374',
  ['gray_244']    = '#928374',

  ['light0_hard'] = '#f9f5d7',
  ['light0']      = '#fbf1c7',
  ['light0_soft'] = '#f2e5bc',
  ['light1']      = '#ebdbb2',
  ['light2']      = '#d5c4a1',
  ['light3']      = '#bdae93',
  ['light4']      = '#a89984',
  ['light4_256']  = '#a89984',

  ['bright_red']     = '#fb4934',
  ['bright_green']   = '#b8bb26',
  ['bright_yellow']  = '#fabd2f',
  ['bright_blue']    = '#83a598',
  ['bright_purple']  = '#d3869b',
  ['bright_aqua']    = '#8ec07c',
  ['bright_orange']  = '#fe8019',

  ['neutral_red']    = '#cc241d',
  ['neutral_green']  = '#98971a',
  ['neutral_yellow'] = '#d79921',
  ['neutral_blue']   = '#458588',
  ['neutral_purple'] = '#b16286',
  ['neutral_aqua']   = '#689d6a',
  ['neutral_orange'] = '#d65d0e',

  ['faded_red']      = '#9d0006',
  ['faded_green']    = '#79740e',
  ['faded_yellow']   = '#b57614',
  ['faded_blue']     = '#076678',
  ['faded_purple']   = '#8f3f71',
  ['faded_aqua']     = '#427b58',
  ['faded_orange']   = '#af3a03',
}

-- provider
BufferIcon = buffer.get_buffer_type_icon
BufferNumber = buffer.get_buffer_number
FileTypeName = buffer.get_buffer_filetype
LineEndings = buffer.get_line
-- Git Provider
GitBranch = vcs.get_git_branch
DiffAdd = vcs.DiffAdd             -- support vim-gitgutter vim-signify gitsigns
DiffModified = vcs.diff_modified   -- support vim-gitgutter vim-signify gitsigns
DiffRemove = vcs.diff_remove       -- support vim-gitgutter vim-signify gitsigns
-- File Provider
LineColumn = fileinfo.line_column
FileFormat = fileinfo.get_file_format
FileEncode = fileinfo.get_file_encode
FileSize = fileinfo.get_file_size
FileIcon = fileinfo.get_file_icon
FileName = fileinfo.get_current_file_name
LinePercent = fileinfo.current_line_percent
ScrollBar = extension.scrollbar_instance


-- Whitespace
Whitespace = whitespace.get_item

-- Diagnostic Provider
DiagnosticError = diagnostic.get_diagnostic_error
DiagnosticWarn = diagnostic.get_diagnostic_warn
DiagnosticHint = diagnostic.get_diagnostic_hint
DiagnosticInfo = diagnostic.get_diagnostic_info

-- LSP
GetLspClient = lspclient.get_lsp_client

local separators = {bLeft = '  ', bRight = ' ', uLeft = ' ', uTop = ' '}

gls.left[1] = {
  CustomViMode = {
    provider = function()
      local mode_names = {
        ['n'] = {'NORMAL', colors.bright_aqua},
        ['v'] = {'VISUAL', colors.bright_blue},
        ['V'] = {'VISUAL', colors.bright_blue},
        [''] = {'VISUAL BLOCK', colors.bright_blue},
        ['s'] = {'SELECT', colors.bright_aqua},
        ['S'] = {'SELECT', colors.bright_aqua},
        [''] = {'SELECT BLOCK', colors.bright_aqua},
        ['i'] = {'INSERT', colors.bright_purple},
        ['ic'] = {'INSERT', colors.bright_purple},
        ['ix'] = {'INSERT', colors.bright_purple},
        ['R'] = {'REPLACE', colors.bright_orange},
        ['Rc'] = {'REPLACE', colors.bright_orange},
        ['Rv'] = {'REPLACE', colors.bright_orange},
        ['Rx'] = {'REPLACE', colors.bright_orange},
        ['c'] = {'COMMAND', colors.bright_red},
        ['cv'] = {'VIM EX', colors.bright_red},
        ['ce'] = {'NORMAL EX', colors.bright_red},
        ['r'] = {'HIT-ENTER', colors.neutral_yellow},
        ['rm'] = {'-- MORE', colors.neutral_yellow},
        ['r?'] = {'CONFIRM', colors.neutral_yellow},
        ['!'] = {'SHELL', colors.neutral_green},
        ['t'] = {'TERMINAL', colors.neutral_green}
      }

      local vim_mode = mode_names[vim.fn.mode()]
      if vim_mode ~= nil then
        return '  ' .. vim_mode[1] .. ' '
      else
        return '   UNKNOWN MODE  '
      end
    end,
    highlight = { colors.light4, colors.dark2 },
    separator = ' ',
    -- separator = separators.bLeft,
    separator_highlight  = { colors.dark1, colors.dark1 },
  },
}
gls.left[2] ={
    FileName = {
        provider = { FileName },
        highlight = {colors.light4, colors.dark1},
        -- separator = separators.bLeft,
        -- separator_highlight = {colors.dark2,colors.dark1},
    },
}
gls.left[3] ={
    Space = {
        provider = function()
            return ' '
        end,
        highlight = { colors.light4, colors.dark1 },
    },
}


gls.right = {
  {
    RightLspError = {
      provider = function()
        if #vim.tbl_keys(vim.lsp.buf_get_clients()) <= 0 then
          return
        end

        local error_count = #vim.diagnostic.get(0, {severity=vim.diagnostic.severity.Error})
        if (error_count == 0) then
          vim.cmd('highlight link GalaxyRightLspError GalaxyLeftLspInactive')
        else
          vim.cmd('highlight link GalaxyRightLspError GalaxyRightLspErrorActive')
        end

        return ' ' .. error_count .. ' '
      end,
      highlight = { colors.light4, colors.dark1 },
    }
  },
  {
    RightLspWarning = {
      provider = function()
        if #vim.tbl_keys(vim.lsp.buf_get_clients()) <= 0 then
          return
        end

        local warning_count = #vim.diagnostic.get(0, {severity=vim.diagnostic.severity.Warning})
        if (warning_count == 0) then
          vim.cmd('highlight link GalaxyRightLspWarning GalaxyLeftLspInactive')
        else
          vim.cmd('highlight link GalaxyRightLspWarning GalaxyRightLspWarningActive')
        end

        return ' ' .. warning_count .. ' '
      end,
      highlight = { colors.light4, colors.dark1 },
    }
  },
  {
    RightLspHint = {
      provider = function()
        if #vim.tbl_keys(vim.lsp.buf_get_clients()) <= 0 then
          return
        end

        local hint_count = #vim.diagnostic.get(0, {severity=vim.diagnostic.severity.Hint})
        if hint_count == 0 then
          vim.cmd('highlight link GalaxyRightLspHint GalaxyLeftLspInactive')
        else
          vim.cmd('highlight link GalaxyRightLspHint GalaxyRightLspHintActive')
        end

        return ' ' .. hint_count .. ' '
      end,
      highlight = { colors.light4, colors.dark1 },
    }
  },
  {
    LspPulse = {
      highlight = { colors.light4, colors.dark1 },
      provider = function()
        if #vim.tbl_keys(vim.lsp.buf_get_clients()) >= 1 then
          local lsp_client_name_first = vim.lsp.get_client_by_id(tonumber(vim.inspect(vim.tbl_keys(vim.lsp.buf_get_clients())):match('%d+'))).name:match('%l+')

          if lsp_client_name_first == nil then
            return ' ' .. #vim.tbl_keys(vim.lsp.buf_get_clients()) .. ':   '
          else
            return ' ' .. #vim.tbl_keys(vim.lsp.buf_get_clients()) .. ':' .. lsp_client_name_first .. '  '
          end
        else
          return '   '
        end
      end,
      separator = ' ',
      separator_highlight  = { colors.light4, colors.dark1 },
    }
  },
  {
    FileInfo = {
      provider = FileEncode,
      highlight = { colors.light4, colors.dark2 },
      separator = ' ',
      separator_highlight  = { colors.dark2, colors.dark1 },
    },
  },
  {
    EndSpace = {
      provider =function() return '  ' end,
      highlight   = { colors.light4, colors.dark2 },
    },
  }
}

