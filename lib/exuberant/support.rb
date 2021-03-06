# Ensure that classes are loaded on demand.
class Module
  def const_missing(sym)
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

class Range
  def [] index
    raise ArgumentError.new("Index #{index} must be between 0 and 1") if (index > 1 || index < 0)
    (self.end - self.begin) * index + self.begin
  end
end

class Proc
  def compose(g)
    return self if g.nil?
    lambda { |*args| self[g[*args]] }
  end
  def *(g)
    compose(self, g)
  end
end