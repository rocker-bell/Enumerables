module Enumerable

def my_each (array)
  i = 0
  while i < array.length
    yield array[i]
    i += 1
  end
end


my_each[1, 2, 3, 4, 5] { |i| puts i ** 2 }


class   Array 
    def my_each
        i = 0
        while i < self.length
            yield self[i]
            i +=1
        end
    end
end


[1, 2, 3, 4, 5].my_each { |i| puts i ** 2 }

