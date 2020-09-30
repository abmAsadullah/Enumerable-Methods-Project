module Enumerable
    def self.my_each(array)
        for value in array do
            puts "Hello, " + value
        end
    end

    # Print #my_each
    my_each(["Jeph", "Anna", "Jack", "Eva"])
end