class Game
  ROOT = File.join(File.dirname(__FILE__))
  
  class << self
    attr_accessor :window
    
    def state
      window.state
    end
    
    def load_image(name, options=[])
      @images ||= {}
      @images[name] ||= Gosu::Image.new window, File.join(ROOT,'images', name), *options
    end
    
    def load_sound(name)
      @sounds ||= {}
      @sounds[name] ||= Gosu::Sample.new window, File.join(ROOT, name)
    end
    
    def load_font(name, size)
      @fonts ||= {}
      #@fonts[name] ||= Gosu::Font.new window, File.join(ROOT, name), size
      #@fonts[name] ||= Gosu::Font.new window, Gosu::default_font_name, size

      @fonts[[name,size]] ||= Gosu::Font.new window, name, size
    end
    
    def options_set
      "default"
    end
    
    def options
      @options ||= YAML.load_file(File.join(ROOT, 'options.yml'))
      @options[options_set]
    end
    
    def db
      unless @db
        db_path = File.join(ROOT, 'game.db')
        new_db = !File.exists?(db_path)
        @db = Sequel.sqlite(db_path)
        if new_db
          puts "Initializing score table..."
          Round.create_table
          puts Round.table_exists?
        end
        
        wordlist = File.join(ROOT, 'wordlists', 'words.db')
        @db << "attach '#{wordlist}' as wordlist"
      end
      @db
      
    end
    
  end
end