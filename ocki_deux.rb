require 'rubygems'
require 'gosu'

# Ensure that classes are loaded on demand.
class Module
  def const_missing(sym)
    require sym.to_s.underscore
    const_get(sym)
  end
end

# String Helper, from ActiveSupport
class String
  def underscore
    self.gsub(/([A-Z]+)([A-Z][a-z])/,'\1_\2').
    gsub(/([a-z\d])([A-Z])/,'\1_\2').
    tr("-", "_").
    downcase
  end
end

GameWindow.new.show