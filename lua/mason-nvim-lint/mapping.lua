local _ = require "mason-core.functional"

local M = {}

M.nvimlint_to_package = {
    ["actionlint"] = "actionlint",
    ["ansible_lint"] = "ansible-lint",
    ["buf_lint"] = "buf",
    ["buildifier"] = "buildifier",
    ["cbfmt"] = "cbfmt",
    ["cfn_lint"] = "cfn-lint",
    ["checkstyle"] = "checkstyle",
    ["checkmake"] = "checkmake",
    ["clj_kondo"] = "clj-kondo",
    ["cmakelint"] = "cmakelint",
    ["codespell"] = "codespell",
    ["cpplint"] = "cpplint",
    ["cspell"] = "cspell",
    ["curlylint"] = "curlylint",
    ["djlint"] = "djlint",
    ["editorconfig-checker"] = "editorconfig-checker",
    ["erb_lint"] = "erb-lint",
    ["eslint_d"] = "eslint_d",
    ["flake8"] = "flake8",
    ["gdlint"] = "gdtoolkit",
    ["golangcilint"] = "golangci-lint",
    ["hadolint"] = "hadolint",
    ["jsonlint"] = "jsonlint",
    ["ktlint"] = "ktlint",
    ["luacheck"] = "luacheck",
    ["markdownlint"] = "markdownlint",
    ["mypy"] = "mypy",
    ["phpcs"] = "phpcs",
    ["phpmd"] = "phpmd",
    ["phpstan"] = "phpstan",
    ["proselint"] = "proselint",
    ["pydocstyle"] = "pydocstyle",
    ["pylint"] = "pylint",
    ["revive"] = "revive",
    ["rstcheck"] = "rstcheck",
    ["rubocop"] = "rubocop",
    ["ruff"] = "ruff",
    ["selene"] = "selene",
    ["shellcheck"] = "shellcheck",
    ["shellharden"] = "shellharden",
    ["solhint"] = "solhint",
    ["sqlfluff"] = "sqlfluff",
    ["standardrb"] = "standardrb",
    ["stylelint"] = "stylelint",
    ["tflint"] = "tflint",
    ["tfsec"] = "tfsec",
    ["trivy"] = "trivy",
    ["vale"] = "vale",
    ["vint"] = "vint",
    ["vulture"] = "vulture",
    ["write-good"] = "write-good",
    ["yamllint"] = "yamllint",
}

M.package_to_nvimlint = _.invert(M.nvimlint_to_package)

return M
