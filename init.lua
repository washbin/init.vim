local load = function(mod)
	package.loaded[mod] = nil
	require(mod)
end

load("user.options")
require("user.plugins")
require("user.treesitter")
require("user.lsp")
require("user.completion")
load("user.keymaps")
require("user.commands")
require("user.autocommands")
require("user.legacy")
