local load = function(mod)
  package.loaded[mod] = nil
  require(mod)
end

load('user.options')
load('user.keymaps')
load('user.commands')
load('user.autocommands')
load('user.legacy')
require('user.plugins')
