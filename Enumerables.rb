# rubocop:disable Style/CaseEquality

module Enumerable
#my_each
  def my_each(array)
    i = 0
    while i < array.length
      yield array[i]
      i += 1
    end
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

def my_none?(arg = (no_arg = true))
  my_each do |item|
    case block_given?
    when false
      return false if item && no_arg
      return false if !no_arg && truethy_arg?(item, arg)
    else
      return false if yield(item)
    end
  end
  true
end

def my_count(*question)
  multiple_argument_error?(question)
  result = 0
  my_each do |item|
    if question.size == 1
      result += 1 if question[0] === item
    elsif block_given?
      result += 1 if yield(item)
    elsif question.size.zero?
      result += 1
    end
  end
  result
end

def my_inject(arg = (no_arg = true))
  accu = self[0]
  for e in 1...length do
    accu = yield(accu, self[e]) if no_arg
    accu = accu.send(arg, self[e]) unless no_arg
  end
  accu
end
