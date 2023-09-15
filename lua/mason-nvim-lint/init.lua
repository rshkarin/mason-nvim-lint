local platform = require "mason-core.platform"
local settings = require "mason-nvim-lint.settings"

local M = {}

local function check_and_notify_bad_setup_order()
    local mason_ok, mason = pcall(require, "mason")
    local nvim_lint_ok, nvim_lint = pcall(require, "lint")
    local is_bad_order = not mason_ok or mason.has_setup == false or not nvim_lint_ok
    local impacts_functionality = not mason_ok or #settings.current.ensure_installed > 0
    if is_bad_order and impacts_functionality then
        vim.notify(
            "mason.nvim has not been set up. Make sure to set up 'mason' and 'nvim-lint' before 'mason-nvim-lint'. :h mason-nvim-lint-quickstart",
            vim.log.levels.WARN
        )
    end
end

---@param config MasonNvimLintSettings | nil
function M.setup(config)
    if config then
        settings.set(config)
    end

    check_and_notify_bad_setup_order()

    if not platform.is_headless and #settings.current.ensure_installed > 0 then
        require "mason-nvim-lint.ensure_installed" ()
    end

    if settings.current.automatic_installation then
        require "mason-nvim-lint.auto_install" ()
    end
end

return M
