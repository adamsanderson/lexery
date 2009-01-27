require 'rubygems'
require 'gosu'
require 'sequel'
require 'support'
require 'gosu_support'
require 'matrix'

if __FILE__ == $0
  Game.default_font = 'fonts/MuseoSans_500.otf'
  Game.db # Initialize the db... needed for the Sequel Models to work.
  GameWindow.new.show
end