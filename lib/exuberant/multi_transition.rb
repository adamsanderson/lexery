# Operates on multiple attributes at once
class MultiTransition < Transition
  # Initialize with multiple start and end values, store them as a vector
  def initialize(duration, start_values, end_values, options={}, &action)
    super(duration, Vector[*start_values], Vector[*end_values], options, &action)
  end
  
  # Compute the change for each value
  def compute_change(start_values, end_values)
    (end_values - start_values).map{|v| v.to_f}
  end
  
  # Same as the normal apply, but unpack the vector
  def apply(t)
    @action.call(* tweening_function[t, @start_value, @change, @duration])
  end
end