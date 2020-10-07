# rubocop:disable Style/For
# rubocop:disable Metrics/ModuleLength
# rubocop:disable Metrics/MethodLength
# rubocop:disable Metrics/CyclomaticComplexity)
# rubocop:disable Metrics/PerceivedComplexity
module Enumerable
  # Create #my_each, a method that is identical to
  # #each but (obviously) does not use #each.
  # You'll need to remember the yield statement.
  # Make sure it returns the same thing as #each as well.

  def my_each
    return to_enum unless block_given?

    for value in self do
      yield value
    end
  end

  def my_each_with_index
    return to_enum unless block_given?

    index = 0
    for i in self do
      yield i, index
      index += 1
    end
  end

  # Create #my_select in the same way, though you may use #my_each in your definition (but not #each).

  def my_select
    return to_enum unless block_given?

    selected = []
    arr = self
    arr.my_each do |i|
      selected << i if yield i
    end
    selected
  end

  def my_all?(args = nil)
    arr = to_a
    if !block_given? && args.nil?
      arr.my_each do |i|
        return false unless i
      end
    elsif args.is_a? Regexp
      arr.my_each do |i|
        return true if args.match(i)
      end
    elsif args.is_a? Class
      arr.my_each do |i|
        return false unless i.is_a? args
      end
    elsif args
      arr.my_each do |i|
        return false unless i == args
      end
    else
      arr.my_each do |i|
        return false unless yield i
      end
    end
    true
  end

  def my_any?(args = nil)
    arr = to_a
    if !block_given? && args.nil?
      arr.my_each do |i|
        return true if i
      end
    elsif args.is_a? Regexp
      arr.my_each do |i|
        return true if args.match(i)
      end
    elsif args.is_a? Class
      arr.my_each do |i|
        return true if i.is_a? args
      end
    elsif args
      arr.my_each do |i|
        return true if i == args
      end
    else
      arr.my_each do |i|
        return true if yield i
      end
    end
    false
  end

  def my_none?(args = nil)
    arr = to_a
    if !block_given? && args.nil?
      arr.my_each do |i|
        return false if i
      end
    elsif args.is_a? Regexp
      arr.my_each do |i|
        return false if args.match(i)
      end
    elsif args.is_a? Class
      arr.my_each do |i|
        return false if i.is_a? args
      end
    elsif args
      arr.my_each do |i|
        return false if i == args
      end
    else
      arr.my_each do |i|
        return false if yield i
      end
    end
    true
  end

  def my_count(params = '')
    nbr_arg = 0
    arr = self
    if !params.empty?
      arr.my_each do |i|
        nbr_arg += 1 if i == params
      end
    elsif block_given?
      arr.my_each do |i|
        nbr_arg += 1 if yield(i)
      end
    else
      nbr_arg += 1
    end
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

  def my_inject(*args)
    arr = to_a
    if block_given?
      res = args[0].nil? ? arr[0] : args[0]
      return arr if args[0].nil?

      arr.my_each do |a|
        res = yield(res, a)
      end
      return res
    else
      symb = nil
      if args[1].nil?
        symb = args[0]
        res = args[0]
      end
      unless args[1].nil?
        symb = args[1]
        res = args[0]
      end

      arr.my_each do |a|
        res = res.send(symb, a)
      end
    end
    res
  end
end

# rubocop:enable Style/For
# rubocop:enable Metrics/ModuleLength
# rubocop:enable Metrics/MethodLength
# rubocop:enable Metrics/CyclomaticComplexity)
# rubocop:enable Metrics/PerceivedComplexity
