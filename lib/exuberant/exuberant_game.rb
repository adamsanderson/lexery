class ExuberantGame
  class << self
    attr_accessor :window
    attr_accessor :options_set
    attr_accessor :default_font
    
    def state
      window.state
    end
    
    def load_image(name, options=[])
      @images ||= {}
      @images[name] ||= Gosu::Image.new window, File.join(GAME_ROOT,'images', name), *options
    end
    
    def load_sound(name)
      @sounds ||= {}
      @sounds[name] ||= Gosu::Sample.new window, File.join(GAME_ROOT,'sounds', name)
    end
    
    def load_font(name, size)
      @fonts ||= {}
      name = (Game.default_font || Gosu.default_font_name) if name == :default
      @fonts[[name,size]] ||= Gosu::Font.new window, name, size
    end
    
  end
end