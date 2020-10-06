# rubocop:disable Style/For
# rubocop:disable Metrics/ModuleLength
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
    arr = self
    arr.my_each do |i|
      selected << i if yield i
    end
    selected
  end

  def my_all?(args = nil)
    return true unless block_given? && args.nil?

    arr = self
    arr.my_each do |i|
      return false unless yield i
    end
    true
  end

  def my_any?(args = nil)
    return true unless block_given? && args.nil?

    ar = self
    ar.my_each do |i|
      return true if yield i
    end
    false
  end

  def my_none?(args = nil)
    return true unless block_given? && args.nil?

    arr = self
    arr.my_each do |i|
      return false if yield i
    end
    true
  end

  def my_count(params = '')
    nbr = 0
    nbr_arg = 0
    arr = self
    arr.my_each do |i|
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
      arr = self
      arr.my_each do |a|
        array.push(yield(a))
      end
    elsif proc
      arr = self
      arr.my_each do |a|
        array.push(proc.call(a))
      end
    else
      return self
    end
    array
  end

  def my_inject(times = nil)
    tot = times
    tot = 0 if times.nil?
    arr = self
    arr.my_each do |a|
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
      arr = self
      arr.my_each do |i|
        map.push(times.call(i)) if times.call(i)
      end
    elsif times.nil?
      arr = self
      arr.my_each do |i|
        map.push(yield i) if yield i
      end
    else
      self
    end
    map
  end
end

# rubocop:enable Style/For
# rubocop:enable Metrics/ModuleLength