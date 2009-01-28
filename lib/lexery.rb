GAME_ROOT = File.join(File.dirname(__FILE__),'..')

require 'rubygems'
require 'gosu'
require 'sequel'
require 'matrix'

$LOAD_PATH << File.join(GAME_ROOT,'lib','lexery')
require 'support'
require 'gosu_support'

if __FILE__ == $0
  Game.default_font = 'fonts/MuseoSans_500.otf'
  Game.db # Initialize the db... needed for the Sequel Models to work.
  GameWindow.new.show
end