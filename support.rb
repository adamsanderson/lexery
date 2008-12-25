# Ensure that classes are loaded on demand.
class Module
  def const_missing(sym)
    # puts "Searching for '#{sym}', #{sym.to_s.underscore}"
    require sym.to_s.underscore
    c = const_get(sym)
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
  
  def get(index)
    chars[index]
  end
  
  def chars
    self.split(//)
  end
end