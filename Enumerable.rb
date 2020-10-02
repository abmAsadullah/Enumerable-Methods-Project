module Enumerable

    # Create #my_each, a method that is identical to #each but (obviously) does not use #each. 
    # You'll need to remember the yield statement. Make sure it returns the same thing as #each as well.

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
            # print a
            tot *= a
        end
        tot
    end



    


    # puts multiply_els([2,4,5]) 

    #[1, 2, 3].my_each_inject { |n,i| puts "Current number is: #{i} - #{n} " }

    # puts [1, 2, 3, 4].inject(0) { |result, element| result + element } #10
    # puts (5..10).inject { |sum, n| sum + n }       #=> 45
    # puts (5..10).my_inject { |sum, n| sum + n }       #=> 45
    # # puts (5..10).inject(1) { |product, n| product * n } #=> 151200

    # puts [1, 2, 3, 4].my_inject2(0) { |result, element| result + element } #10
    # puts [1, 2, 3, 4].my_inject(0) { |result, element| result + element } #10
    # #puts (5..10).my_inject { |sum, n| sum + n }            #=> 45
    # puts (5..10).my_inject2(1) { |product, n| product * n } #=> 151200
    # puts (5..10).my_inject(1) { |product, n| product * n } #=> 151200


 




    #map 2  param.call(a) arr.push(yield(param.call(a)))

   #puts [1,2,3,4].my_map { |i| i+2 }  

# friends = ['Sharon', 'Leo', 'Leila', 'Brian', 'Arun']

# print friends.my_map { |friend| friend.upcase }
#print friends.my_map2 { |friend| friend.upcase }


#=> `['SHARON', 'LEO', 'LEILA', 'BRIAN', 'ARUN']`


    
    #["Jeph", "Anna", "Jack", "Eva"].my_each_with_index { |friend, index| puts "Helloo, " + friend + index }

    # ["Walmart", "Exxon Mobil", "Apple", "Berkshire Hathaway", "Amazon.com"].my_each_with_index do | company, index|
    #     puts "#{index}. #{company}"
    # end
    
   # puts ["Jeph", "Anna", "Jack", "Eva"].my_select { |friend| friend != 'Jeph' }

    #puts %w[ant bear cat].my_all? { |word| word.length >= 4 }

    # declaring array 3
    # a = ["abc", "nil", "dog"]
    # #a = [18, 22, 33, nil, 5, 6]
    
    # # # declaring array 
    # b = ["cow", nil, "dog"] 
    #  #b = [1, 4, 1, 1, 88, 9, 1]

    
    # # # declaring array 0
    # #c = ["cat", nil, nil] 
    # c = [18, 22, nil, nil, 50, 6] 

    
    # #counting total elements 
    # puts "counting a : #{a.count}\n\n"
    # puts "counting a : #{a.my_count}\n\n"
    
    # # counting 1 -  
    # puts "my counting b : #{b.my_count(1)}\n\n"
    # puts "counting b : #{b.count(1)}\n\n"
    
    
    # # # counting 'nil' 2
    # puts "counting c : #{c.my_count(nil)} \n\n"
    # puts "counting c : #{c.count(nil)}\n\n"
    

end

