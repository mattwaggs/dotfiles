local status, neotree = pcall(require, "neo-tree")
if not status then
  return
end

neotree.setup({
    source_selector = {
      winbar = true,
      statusline = false
    }
})

