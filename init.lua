local load = function(mod)
  package.loaded[mod] = nil
  require(mod)
end

load('washbin.options')
load('washbin.keymaps')
load('washbin.commands')
load('washbin.autocommands')
load('washbin.legacy')
load('washbin.plugins')
