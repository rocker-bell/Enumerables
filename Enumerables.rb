module Enumerable
#my_each
  def my_each(array)
    i = 0
    while i < array.length
      yield array[i]
      i += 1
    end
  end

  my_each[1, 2, 3, 4, 5] { |i| puts i ** 2 }

  class Array
    def my_each
      i = 0
      while i < self.length
        yield self[i]
        i += 1
      end
    end
  end
end

[1, 2, 3, 4, 5].my_each { |i| puts i ** 2 }

#my_each_with_index

def my_each_with_index
  return to_enum(:my_each_with_index) unless block_given?
  i = 0
  my_each do |item|
    yield(item, i)
    i =+ 1
  end
end


def my_select(Array)
  return to_enum(:my_select) unless block_given?
  array = Array.new()
  my_each do |item|
    array.push(yield item)
  end
  array
end

def my_map(Array)
  return to_enum(:my_map) unless block_given?
  array = Array.new()
  my_each do |item|
    array.push(yield item)
  end
  array
end

def my_all(Array)
  self.my_each do |item|
    return true unless block_given?
    true_false yield(item)
    return false unless true_false
  end
  return true
end

def my_any(Array)
  self.my_each do |item|
    return true if yield |item|
  end
  false
end






