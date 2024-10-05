local registry = require "mason-registry"
local nvim_lint = require "lint"
local mapping = require "mason-nvim-lint.mapping"
local settings = require "mason-nvim-lint.settings"

local function linters_to_install(linters_by_ft)
    local kept_linters = {}

    for _, linter_names in pairs(linters_by_ft) do
        for _, linter_name in ipairs(linter_names) do
            if not vim.tbl_contains(settings.current.ignore_install, linter_name) then
                table.insert(kept_linters, linter_name)
            end
        end
    end

    return ipairs(kept_linters)
end

--@return unknown_linters string[]
local function auto_install()
    local unknown_linters = {}
    local installing_linters = {}

    for _, linter_name in linters_to_install(nvim_lint.linters_by_ft) do
        local mason_linter_identifier = mapping.nvimlint_to_package[linter_name]
        if mason_linter_identifier then
            if not vim.tbl_contains(installing_linters, mason_linter_identifier) then
                table.insert(installing_linters, mason_linter_identifier)
                require "mason-nvim-lint.install".try_install(mason_linter_identifier)
            end
        else
            if not vim.tbl_contains(unknown_linters, linter_name) then
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
