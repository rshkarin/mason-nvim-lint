local registry = require "mason-registry"
local settings = require "mason-nvim-lint.settings"

local function ensure_installed()
    for _, mason_linter_identifier in ipairs(settings.current.ensure_installed) do
        require "mason-nvim-lint.install".try_install(mason_linter_identifier)
    end
end

if registry.refresh then
    return function()
        registry.refresh(vim.schedule_wrap(ensure_installed))
    end
else
    return ensure_installed
end
