module Enumerable
  # Create #my_each, a method that is identical to
  # #each but (obviously) does not use #each.
  # You'll need to remember the yield statement.
  # Make sure it returns the same thing as #each as well.

  def my_each
    return self unless block_given?
    for value in self do
      yield value
    end
  end

  def my_each_with_index
    return self unless block_given?
    index = 0
    for i in self do
      yield i, index
      index += 1
    end
  end

  # Create #my_select in the same way, though you may use #my_each in your definition (but not #each).

  def my_select
    return self unless block_given?
    selected = []
    self.my_each do |i|
      selected << i if yield i
    end
    selected
  end

  def my_all?(args=nil)
    return true unless block_given? && args.nil?
    self.my_each do |i|
      return false unless yield i
    end
    true
  end

  def my_any?(args=nil)
    return true unless block_given? && args.nil?
    self.my_each do |i|
      return true if yield i
    end
    false
  end

  def my_none?(args=nil)
    return true unless block_given? && args.nil?
    self.my_each do |i|
      return false if yield i
    end
    true
  end

  def my_count(params = '')
    nbr = 0
    nbr_arg = 0
    self.my_each do |i|
      if i == params
        nbr_arg += 1
      else
        nbr += 1
      end
    end
    return nbr if params == ''
    nbr_arg
  end

  def my_map(proc = nil)
    array = []
    if block_given?
      self.my_each do |a|
        array.push(yield(a))
      end
    elsif proc
      self.my_each do |a|
        array.push(proc.call(a))
      end
    else
      return self
    end
    return array
  end

  def my_inject(times = nil)
    tot = times
    tot = 0 if times.nil?
    self.my_each do |a|
      tot = yield(a, tot)
    end
    tot
  end

  # Test #my_inject by creating a method called #multiply_els which
  # multiplies all the elements of the array together by using #my_inject,
  # e.g. multiply_els([2,4,5]) #=> 40

  def self.multiply_els(times = nil)
    tot = 1
    tot if times.nil?
    times.my_inject do |a|
      tot *= a
    end
    tot
  end

  def my_map_block_proc(times = nil)
    map = []
    if times.nil? && block_given?
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

  #["Jeph", "Anna", "Jack", "Eva"].my_each { |friend| puts "Helloo, " + friend  }
  #["Jeph", "Anna", "Jack", "Eva"].my_each_with_index { |friend, index| puts "Helloo, " + friend + index.to_s }
  #["Jeph", "Anna", "Jack", "Eva"].my_each_with_index { |friend, index| puts "Helloo, " + friend + index.to_s }
  #["Jeph", "Anna", "Jack", "Eva"].my_each_with_index 
  #(5..50).my_each_with_index { |num| num }
  # (5..50).my_each_with_index { |num, i| num.to_s + i.to_s  }
  # (5..50).each_with_index { |num, i| num.to_s + i.to_s  }
  #puts %w[ant bear cat].my_all?("6") { |word| word.length >= 4 }
  #puts ["ant", "bear", "cat", /like/].all? { |word| word.length >= 3 }
  #puts ["ant", "bear", "cat", /like/].my_all? { |word| word.length >= 3}

  # # declaring array 3
  #   a = ["abc", "nil", "dog"]
  #   #a = [18, 22, 33, nil, 5, 6]
    
  #   # # declaring array 
  #   b = ["cow", nil, "dog"] 
  #    #b = [1, 4, 1, 1, 88, 9, 1]

    
  #   # # declaring array 0
  #   #c = ["cat", nil, nil] 
  #   c = [18, 22, nil, nil, 50, 6] 

    
  #   #counting total elements 
  #   puts "my counting a : #{a.my_count}\n\n"
  #   puts "counting a : #{a.count}\n\n"
    
  #   # counting 1 -  
  #   puts "my counting b : #{b.my_count(1)}\n\n"
  #   puts "counting b : #{b.count(1)}\n\n"
    
    
  #   # # counting 'nil' 2
  #   puts "my counting c : #{c.my_count(nil)} \n\n"
  #   puts "counting c : #{c.count(nil)}\n\n"

#   p [1, 2, 3, 4].map { |num| num > 0 }
#   p [1, 2, 3, 4].my_map { |num| num > 0 }

#   p = Proc.new { |i| puts i+2 }
#   [1,2,3,4].my_map(p)



# friends = ['Sharon', 'Leo', 'Leila', 'Brian', 'Arun']

#   p friends.map { |friend| friend.upcase }
#   p friends.my_map { |friend| friend.upcase }

end
