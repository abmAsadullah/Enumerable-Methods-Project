module Enumerable

    #Create #my_each, a method that is identical to #each but (obviously) does not use #each. 
    #You'll need to remember the yield statement. Make sure it returns the same thing as #each as well.

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




   # ["Jeph", "Anna", "Jack", "Eva"].my_each_with_index { |friend, index| puts "Helloo, " + friend + index }

    # ["Walmart", "Exxon Mobil", "Apple", "Berkshire Hathaway", "Amazon.com"].my_each_with_index do | company, index|
    #  puts "#{index}. #{company}"
    # end
    
  

end

