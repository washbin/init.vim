local load = function(mod)
	package.loaded[mod] = nil
	require(mod)
end

require("user.options")
require("user.plugins")
require("user.few-liners")
require("user.lsp-config")
require("user.nvim-cmp-config")
load("user.keymaps")
require("user.commands")
require("user.legacy")
