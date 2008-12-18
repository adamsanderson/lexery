module Colored
  def color=c
    if c.is_a? Bignum
      @color = Gosu::Color.new(c)
    else
      @color = c
    end
  end
  
  def color
    @color
  end
end