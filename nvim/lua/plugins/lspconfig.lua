local function clangd_cfg()
  local esp_idf_path = os.getenv("IDF_PATH")
  if esp_idf_path then
    return {
      cmd = {
        os.getenv("HOME") .. "/.espressif/tools/esp-clang/esp-19.1.2_20250312/esp-clang/bin/clangd",
        "--compile-commands-dir=./build",
        "--background-index",
        "--enable-config",
        "--query-driver=**",
      },
      root_markers = { "sdkconfig", "CMakeLists.txt", ".git" },
    }
  else
    return {}
  end
end

return {
  "neovim/nvim-lspconfig",
  ---@class PluginLspOpts
  opts = {
    ---@type lspconfig.options
    servers = {
      -- pyright will be automatically installed with mason and loaded with lspconfig
      pyright = {},
      clangd = clangd_cfg(),
    },
  },
}
