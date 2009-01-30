GAME_ROOT = File.join(File.dirname(__FILE__),'..')

require 'rubygems'
require 'gosu'
require 'sequel'
require 'matrix'

$LOAD_PATH << File.join(GAME_ROOT,'lib','lexery')
require 'support'
require 'gosu_support'