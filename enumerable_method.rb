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

  def my_inject3(times = nil)
    tot = times
    tot = 0 if times.nil?
    arr = self
    arr.my_each do |a|
      tot = yield(a, tot)
    end
    tot
  end

  def my_inject_(*args)
    puts args
    return args
  end

  def my_inject4(*init)
    self.class == Range ? self_arr = self.to_a : self_arr = self # convert range into array if needed
    init.empty? ? (tot = self_arr[0] and i = 1) : (tot = init[0] and i = 0)
    while i < self_arr.length
    	tot = yield(tot, self_arr[i])
    	i += 1
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
  def my_inject(&blk)
    sum = self[0]
    self[1..-1].my_each{|item| sum = blk.call(sum, item) }
    sum
  end
  def my_inject5(*args)
    if block_given?
      if !args.empty? && args.length == 1
        arg = args[0]
        arr = self
        arr.my_each do |a|
          arg = yield(arg, a)
        end
        return arg
      elsif !args.empty? && args.length == 2
        init = args[0]
        symb = args[1]
        if symb.is_a?(Symbol)
          arr = self
          arr.my_each do |a|
            init = yield(init, a)
          end
          init = yield(init, symb)
          return init
        end
      end
    else
      if !args.empty? && args.length == 1
        arg = args[0].to_sym if args[0].is_a?(Symbol)
        arg = args[0].to_s if args[0].is_a?(String)
        arg = args[0].to_i if args[0].is_a?(Integer)
        tot=""
        tot = args[0].to_i if args[0].is_a?(Integer)

        
        #arg = args[0]
        arr = self
        arr.my_each do |a|
          # puts arg.to_sym
          # puts a
          puts call(arg.to_sym, a)
          tot = call(arg, a)
        end
        return tot
      elsif !args.empty? && args.length == 2
        init = args[0]
        symb = args[1]
        if symb.is_a?(Symbol)
          arr = self
          arr.my_each do |a|
            init = __send__(init, a)
          end
          init = __send__(init, symb)
          return init
        end
      end
    end
    # arr = to_a
    
    # symb = args[0] if args.empty?  args[0].is_a?(Symbol) || args[0].is_a?(String)
    # tot = args[0] if args[0].is_a?(Integer)

    # if args[0].is_a?(Integer)
    #   symb = second if second.is_a?(Symbol) || second.is_a?(String)
    # end

    # if symb
    #   arr.my_each { |x| tot = tot ? tot.__send__(symb, x) : x }
    # elsif block_given?
    #   arr.my_each { |x| tot = tot ? yield(tot, x) : x }
    # end
    # tot
  end
  

  def my_inject2(*args)
    # check if block is given
    if block_given?
      if args.empty?
        return "block and no args"
      else
        if args.length > 1
          tot = args[0]
          symb = args[1]
          #tot = 0 if times.nil?
          arr = self
          arr.my_each do |a|
            tot symb a
          end
          puts "block and there is args of two elements"
          return tot
        else
          tot = args[0]
          #tot = args[0] if tot.class == Symbol
          #symb = args[1]
          #tot = 0 if times.nil?
          arr = self
          arr.my_each do |a|
            tot = yield(tot, a)
          end
          puts "block and there is args of one element"
          return tot
        end
      end
    else
      if args.empty?
        return "no block and no args"
      else
        if args.length > 1
          return "no block and there is args of two elements"
        else
          self.my_each { |a| tot = tot ? tot.__send__(args[0], a) : a }

          #tot = args[0] if tot.class == Symbol
          #symb = args[1]
          #tot = 0 if times.nil?
          # arr = self
          # arr.my_each do |a|
          #   tot = __send__(args[0], a)
          # end
          puts "no block and there is args of one element"
          return tot
        end
      end
    end
    # tot = times
    # tot = 0 if times.nil?
    # arr = self
    # arr.my_each do |a|
    #   tot = yield(a, tot)
    # end
    # tot
    # if args.empty?
    #   return self
    # end
    # Check if self is an array
    # check if args exists
      # Check if args[0] is a symbol or a string or a int
      # Check if args[1] is a symbol or a string or a int
    # Iterrate through the self (array) within each loop and yield result
    # Proc ???

    return "self"
  end

  p (1..5).my_inject(&:*)                               # 5 factorial  =>  120
  # p (1..5).my_inject(2, :*)                            # 5 factorial doubled => 240
  # p %w(3 4 5).my_inject(:+)                            # string concatenation => "345"
  # p %w(3 4 5).my_inject("hello", :+)                   # concatenation w/ prefix => "hello345"
  # p %w(3 4 8).my_inject("howdy") { |memo, x| memo + x } # prefix and block => "howdy348"
  # #p %w(3 4 5).my_inject3("howdy") { |memo, x| memo + x } # prefix and block => "howdy345"
  # p (1..4).my_inject                             
  # p (1..5).my_inject(2, :*)
  # p (1..3).my_inject(:*)  #=> ["1", "2", "3"]
  # p (1..3).my_inject {|memo, x| memo + x } #=> ["1", "2", "3"]


  # # A variety of test cases    
  # p (1..4).my_inject(:*)                                # 4 factorial via Symbol =>  24
  # p (1..5).my_inject('*')                               # 5 factorial via String =>  120
  # p (1..6).my_inject(0) { |memo, x| memo * x }             # 6 factorial via block => 720
  # p (1..5).my_inject(2, &:*)                            # 5 factorial doubled via Proc => 240
  # p (1..5).my_inject(3, :*)                             # 5 factorial tripled via Symbol =>  360
  # p (1..5).my_inject(4, '*')                            # 5 factorial quadrupled via String =>  480
  # p %w(3 4 5).my_inject(&:+)                            # string concatenation via Proc => "345"
  # p %w(3 4 5).my_inject("hello", &:+)                   # prefix and Proc => "hello345"
  # p %w(3 4 5).my_inject("howdy") { |memo, x| memo + x } # prefix and block => "howdy345"
  # p %w(3 4 5).my_inject("yowza", :+)                    # prefix and Symbol => "yowza345"
  # p %w(3 4 5).my_inject("yoiks", '+')                   # prefix and String => "yoiks345"


  # p [true, true, true].my_inject(:&)

  # t = [1,2,3,4].inject do |running_total, number|
  #   running_total + number
  # end

  # t1 = [1,2,3,4].my_inject do |running_total, number|
  #   running_total + number
  # end

  # p t1

  #[1,2,3,4].my_inject(:+)
  #p [1,2,3,4].my_inject(:&)
  # => 10
end



# rubocop:enable Style/For
# rubocop:enable Metrics/ModuleLength
