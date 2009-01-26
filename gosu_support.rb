module Gosu
  class Color
    def argb_components
      [self.alpha, self.red, self.green, self.blue]
    end
  end
end