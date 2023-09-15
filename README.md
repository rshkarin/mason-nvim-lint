# mason-nvim-lint

# Introduction

`mason-nvim-lint` is a Neovim plugin that closes a gap between `mason.nvim` and `nvim-lint`, it allows install linters configured in `nvim-lint`.

# Requirements

-   neovim `>= 0.7.0`
-   [`mason.nvim`](https://github.com/williamboman/mason.nvim)
-   [`nvim-lint`](https://github.com/mfussenegger/nvim-lint)

# Installation

## [Lazy](https://github.com/folke/lazy.nvim)

```lua
{
    "williamboman/mason.nvim",
    "mfussenegger/nvim-lint",
    "rshkarin/mason-nvim-lint",
}
```

## [Packer](https://github.com/wbthomason/packer.nvim)

```lua
use {
    "williamboman/mason.nvim",
    "mfussenegger/nvim-lint",
    "rshkarin/mason-nvim-lint",
}
```

# Setup

It's crucial to setup plugins in the following order:

1. `mason.nvim`
2. `nvim-lint`
3. `mason-nvim-lint`

Otherwise, `mason-nvim-lint` will not have enough information about configured linters and access to the mason's registry.

To learn about the available settings and configurations, please refer the [Configuration](#configuration) section.

# Configuration

You can configure the behavior of `mason-nvim-lint` by passing the configuration during the calling of the `setup()` function. 
All available settings are provided in [default configuration](#default-configuration) section.

Example:

```lua
require("mason-nvim-lint").setup()
```

## Default configuration

```lua
local DEFAULT_SETTINGS = {
    -- A list of linters to automatically install if they're not already installed. Example: { "eslint_d", "revive" }
    -- This setting has no relation with the `automatic_installation` setting.
    -- Names of linters should be taken from the mason's registry.
    ---@type string[]
    ensure_installed = {},

    -- Whether linters that are set up (via nvim-lint) should be automatically installed if they're not already installed.
    -- It tries to find the specified linters in the mason's registry to proceed with installation.
    -- This setting has no relation with the `ensure_installed` setting.
    ---@type boolean
    automatic_installation = true,
}
```

### Basic Customization

Using this configuration, only linters specified in `ensure_installed` will be installed, ones specified in `nvim-lint` will be ignored.
**NOTE:** The linters in `ensure_installed` should be written in the format of the mason's registry (https://mason-registry.dev/).

```lua
require ('mason-nvim-lint').setup({
    ensure_installed = {'eslint_d', 'revive'},
})
```
