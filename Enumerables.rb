module Enumerable
  
  # my_eachhh
  def my_each
    i = 0
    while i < self.length
      yield self[i]
      i += 1
    end
    self[0]
  end

  # my_each_with_index
  def my_each_with_index
    i  = 0
    while i < self.length
      yield (self[i], i)
      i += 1
    end
    self[i]
  end

  def my_select
    #returns an array for which the return value is true
    if block_given?
      new_arr = []
      for i in 0..self.length - 1
        if (yield(self[i]))
          new_arr.push(self[i])
        end
      end
      puts new_arr
    else
      puts "Please input a block"
    end
  end

  def my_all?
    if block_given?
      result = true
      for i in 0..self.length - 1
        if (yield(self[i]))
          next
        else
          result = false
        end
      end
    else
      "Please input a block"
    end

    puts result
  end

  def my_any?
    if block_given?
      result = true
      for i in 0..self.length - 1
        if (yield(self[i]))
        else
          next
        end
      end
    else
      "Please input a block"
    end
    puts result
  end

  def my_none?
    if block_given?
      result = true
      for i in 0..self.length - 1
        if (yield(self[i]))
          result = fasle
          next
        else
          result = true
        end
      end
    else
      "Please input a block"
    end
    puts result
  end

  def my_count(val = "NoNArG")
    count = 0
    if block_given?
      for i in 0..self.length - 1
        if (yield(self[i]))
          count += 1
        else
          next
        end
      end
    elsif (val != "NoNArG")
      for i in 0..self.length - 1
        if (self[i] == val)
          count += 1
        end
      end
    else
      count = self.length
    end

    return count
  end

  def my_map
    if block_given?
      result = []
      for i in 0..self.length - 1
        result.push(yield(self[i]))
      end
    else
      result = self
    end

    return result
  end

  def my_inject(startVal = nil, symbol = nil)
    #if a block is given
    if block_given?
      #startVal is given
      if startVal != nil
        result = startVal
        self.my_each do |element|
          result = yield(result, element)
        end
        return result
        #no startVal is given
      else
        result = self[0]
        self.shift
        self.my_each do |element|
          result = yield(result, element)
        end
        return result
      end
      #if there is no block
    else
      #both params are given
      if startVal != nil && symbol != nil
        result = startVal
        self.my_each do |element|
          result = result.send(symbol, element) #had to look the send method up, pretty neat, check out at ruby docs
        end
        return result
        #only startVal is given which will be a symbol referring to a proc
      elsif startVal != nil && symbol == nil
        result = self[0]
        self.shift
        self.my_each do |element|
          result = result.send(startVal, element)
        end
        return result
      else
        return "You didn't provide the correct parameters"
      end
    end
  end
end

# rubocop:enable
puts "---------"
puts "my_each"
arr = [1, 2, 3, 4, 5, 6]
arr.my_each do |num|
  puts num * num #prints out element squared
end

puts "---------"
puts "my_each_with_index"
arr = ["Billy", "Wild Bill", "Big Bill", "Coffdrop"]
arr.my_each_with_index do |nickname, val|
  puts "String: #{nickname}, Index: #{val}"
  #prints out each element with index
end

puts "---------"
puts "my_select"
arr = [12.2, 13.4, 15.5, 16.9, 10.2]
arr.my_select do |num|
  num.to_f > 13.3 #selects arr[1], arr[2], arr[3]
end

puts "---------"
puts "my_all"
arr = ["Johnny", "Jack", "Jim", "Jonesy"]
arr.my_all? do |name|
  name[0] == "J" #returns true for the given set
end

puts "---------"
puts "my_any"
arr = ["Billy", "Alex", "Brooke", "Andrea", "Willard"]
arr.my_any? do |name|
  name.match(/Bi/) #returns true for the given set
end

puts "---------"
puts "my_none"
arr = ["Billy", "Alex", "Brooke", "Andrea", "Willard"]
arr.my_none? do |name|
  name.match(/zzz/) #returns true for the given set
end

puts "---------"
puts "my_count"
arr = [1, 2, 3, 4, 5, 6, 7, 87, 33, 3]
run1 = arr.my_count do |val|
  val < 20 #returns 8 for the given set
end

run2 = arr.my_count(3) #returns 2 for the given set

run3 = arr.my_count #returns 10 for the given set
puts "Block: #{run1}, Param: #{run2}, No arg or param: #{run3}"

puts "---------"
puts "my_map"
arr = [1, 4, 16, 25, 36, 49]
run1 = arr.my_map do |val|
  val * 2 #doubles each value
end

run2 = arr.my_map

puts run1
puts run2

puts "---------"
puts "my_inject"
puts "calling multiply_els"

def multiply_els(arr)
  arr.my_inject(:*)
end

puts multiply_els([2, 4, 5])
puts "---------"
puts "startVal with symbol"
a = [2, 4, 5].my_inject(5, :*)
puts a
puts "---------"
puts "only block"
a = [5, 6, 7, 8, 9, 10].my_inject { |i, j| i + j }
puts a
puts "---------"
puts "startVal with block"
a = [5, 6, 7, 8, 9, 10].my_inject(5) { |i, j| i + j }
puts a
