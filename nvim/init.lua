vim.loader.enable()

_G.ssuarezs = require("ssuarezs.utils")

require("ssuarezs.config.options")
require("ssuarezs.config.keymaps")
require("ssuarezs.config.autocmds")
require("ssuarezs.config.commands")
require("ssuarezs.config.workarounds")

require("ssuarezs.plugins")
