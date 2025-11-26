local load = function(mod)
  package.loaded[mod] = nil
  require(mod)
end

load('washbin.plugins')
