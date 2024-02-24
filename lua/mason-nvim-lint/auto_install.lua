local registry = require "mason-registry"
local nvim_lint = require "lint"
local mapping = require "mason-nvim-lint.mapping"
local settings = require "mason-nvim-lint.settings"

--@return unknown_linters string[]
local function auto_install()
    local unknown_linters = {}

    for _, linter_names in pairs(nvim_lint.linters_by_ft) do
        for _, linter_name in ipairs(linter_names) do
            local mason_linter_identifier = mapping.nvimlint_to_package[linter_name]
            if mason_linter_identifier then
                require "mason-nvim-lint.install".try_install(mason_linter_identifier)
            else
                table.insert(unknown_linters, linter_name)
            end
        end
    end

    if #unknown_linters > 0 and not settings.current.quiet_mode then
        vim.notify(
            ("Linters [%s] are absent in the mason's registry. Please, install them manually and remove from configuration.")
            :format(table.concat(unknown_linters, ", ")), vim.log.levels.WARN)
    end
end

if registry.refresh then
    return function()
        registry.refresh(vim.schedule_wrap(auto_install))
    end
else
    return auto_install
end
