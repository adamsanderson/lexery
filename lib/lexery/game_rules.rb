class GameRules
  def valid_transition?(old_word, new_word)
    d = distance(old_word, new_word)
    case d
    when 1 then true
    when 2 then 
      old_word.chars.sort == new_word.chars.sort
    else
      false
    end
  end
  
  private
  # From:
  #   http://rubyforge.org/projects/text
  def distance(str1, str2)
    if $KCODE =~ /^U/i
      unpack_rule = 'U*'
    else
      unpack_rule = 'C*'
    end
    s = str1.unpack(unpack_rule)
    t = str2.unpack(unpack_rule)
    n = s.length
    m = t.length
    return m if (0 == n)
    return n if (0 == m)

    d = (0..m).to_a
    x = nil

    (0...n).each do |i|
      e = i+1
      (0...m).each do |j|
        cost = (s[i] == t[j]) ? 0 : 1
        x = [
          d[j+1] + 1, # insertion
          e + 1,      # deletion
          d[j] + cost # substitution
        ].min
        d[j] = e
        e = x
      end
      d[m] = x
    end

    return x
  end
  
  
end