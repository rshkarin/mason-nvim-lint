local mapping = require "mason-nvim-lint.mapping"
local registry = require "mason-registry"
local settings = require "mason-nvim-lint.settings"

local function ensure_installed()
    for _, linter_name in ipairs(settings.current.ensure_installed) do
        local mason_linter_identifier = mapping.nvimlint_to_package[linter_name]
        require("mason-nvim-lint.install").try_install(mason_linter_identifier)
    end
end

if registry.refresh then
    return function()
        registry.refresh(vim.schedule_wrap(ensure_installed))
    end
else
    return ensure_installed
end
