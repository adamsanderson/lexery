require 'round'

class ScoreBoard
  def initialize(path)
    @path = path
    if path and File.exist?(path)
      @games = Marshal.load(File.read(path))
    else
      @games = {}
    end
  end
  
  def rounds(type)
    @games[type] ||= []
  end
  
  def record(type, round)
    raise ArgumentError unless round.is_a? Round
    
    rounds(type) << round
    save!
  end
  
  def save!
    return unless @path
    
    File.open(@path,'w') do |io|
      Marshal.dump(@games,io)
    end
  end
end