module Enumerable

  # Create #my_each, a method that is identical to 
  # #each but (obviously) does not use #each. 
  # You'll need to remember the yield statement. 
  # Make sure it returns the same thing as #each as well.

  def my_each
    for value in self do
      yield value
    end
  end

  def my_each_with_index
    for i in 0..self.length-1 do
      yield self[i], i
    end
  end

  # Create #my_select in the same way, though you may use #my_each in your definition (but not #each).

  def my_select
    selected = Array.new
    self.my_each do |i|
      selected << i if yield i
    end
    selected
  end

  def my_all?
    self.my_each do |i|
      return false if !yield i
    end
    return true
  end

  def my_any?
    self.my_each do |i|
      return true if yield i
    end
    return false
  end

  def my_none?
    self.my_each do |i|
      return false if yield i
    end
    return true
  end

  def my_count(params = "")
    nbr = 0
    nbr_arg = 0
    self.my_each do |i|
      if i == params
        nbr_arg += 1
      else
        nbr += 1
      end
    end
    return nbr if params == ""
    return nbr_arg
  end

  def my_map
    map = Array.new
    self.my_each do |i|
      map.push(yield i) if yield i
    end
    map
  end

  def my_inject(times = nil)
    tot = times
    tot = 0 if times.nil?
    self.my_each do |a|
      tot = yield(a, tot) 
    end
    tot
  end

  #Test #my_inject by creating a method called #multiply_els which 
  #multiplies all the elements of the array together by using #my_inject, 
  #e.g. multiply_els([2,4,5]) #=> 40

  def self.multiply_els(times = nil)
    tot = 1
    return tot if times.nil?
    times.my_inject do |a|
      tot *= a
    end
    tot
  end

  # Modify your #my_map method to take a proc instead.

  def my_map_proc(proc)
    self.each do |name|
      proc.call(name)
    end
  end

  def my_map_block_proc(times=nil)
    map = Array.new
    if times.nil? and block_given?
      self.my_each do |i|
        map.push(times.call(i)) if times.call(i)
      end
    elsif times.nil? 
      self.my_each do |i|
        map.push(yield i) if yield i
      end
    else 
      self
    end
    map
  end
end
