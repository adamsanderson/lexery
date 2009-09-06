GAME_ROOT = File.join(File.dirname(__FILE__),'..')

require 'rubygems'
require 'gosu'
require 'matrix'

$LOAD_PATH << File.join(GAME_ROOT,'lib','lexery')
$LOAD_PATH << File.join(GAME_ROOT,'lib','exuberant')
require 'support'
require 'gosu_support'