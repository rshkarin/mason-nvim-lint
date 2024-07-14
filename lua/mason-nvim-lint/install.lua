local registry = require "mason-registry"
local settings = require "mason-nvim-lint.settings"

local M = {}

---@param mason_linter_name string
local function resolve_package(mason_linter_name)
    local Optional = require "mason-core.optional"

    local ok, pkg = pcall(registry.get_package, mason_linter_name)
    if ok then
        return Optional.of_nilable(pkg)
    end
end

---@param pkg Package
---@param version string?
---@return InstallHandle
local function install_package(pkg, version)
    local linter_name = pkg.name

    vim.notify(("[mason-nvim-lint] installing %s"):format(linter_name))

    return pkg:install({ version = version }):once(
        "closed",
        vim.schedule_wrap(function()
            if pkg:is_installed() then
                vim.notify(("[mason-nvim-lint] %s was successfully installed"):format(linter_name))
            else
                vim.notify(
                    ("[mason-nvim-lint] failed to install %s. Installation logs are available in :Mason and :MasonLog")
                    :format(
                        linter_name
                    ),
                    vim.log.levels.ERROR
                )
            end
        end)
    )
end

function M.try_install(mason_linter_identifier)
    local Package = require "mason-core.package"
    local package_name, version = Package.Parse(mason_linter_identifier)

    local resolved_package = resolve_package(package_name)

    if resolved_package == nil then
        if not settings.current.quiet_mode then
            vim.notify(
                ("[mason-nvim-lint] Linter %q cannot be resolved into a Mason package. Make sure to only provide valid linter names.")
                :format(
                    package_name
                ),
                vim.log.levels.WARN
            )
            return
        end
    end

    resolved_package
        :if_present(
        ---@param pkg Package
            function(pkg)
                if not pkg:is_installed() then
                    install_package(pkg, version)
                end
            end
        )
        :if_not_present(function()
            if not settings.current.quiet_mode then
                vim.notify(
                    ("[mason-nvim-lint] Linter %q is not a valid entry in ensure_installed. Make sure to only provide valid linter names.")
                    :format(
                        package_name
                    ),
                    vim.log.levels.WARN
                )
            end
        end)
end

return M
