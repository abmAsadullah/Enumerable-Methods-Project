module Enumerable

    #Create #my_each, a method that is identical to #each but (obviously) does not use #each. 
    #You'll need to remember the yield statement. Make sure it returns the same thing as #each as well.

    def my_each
        for value in self do
            yield value
        end
    end

    

    #["Jeph", "Anna", "Jack", "Eva"].each { |friend| puts "Hello, " + friend }
    ["Jeph", "Anna", "Jack", "Eva"].my_each { |friend| puts "Helloo, " + friend }
end

