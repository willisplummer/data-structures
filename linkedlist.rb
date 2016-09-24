class Node
  attr_accessor :pointer, :value
  def initialize(pointer, value)
    @pointer = pointer
    @value = value
  end
end

class LinkedList
  attr_accessor :head
  #O(1)
  def initialize(value)
    @head = Node.new(nil, value)
  end

  #O(n)
  def reduce(accum=0, &block)
    ref = head
    while !ref.nil?
      accum = block.call(accum, ref)
      ref = ref.pointer
    end
    accum
  end

  #O(n)
  def length
    reduce do |count, node|
      count += 1
    end
  end

  #O(n)
  def to_a
    reduce([]) do |array, node|
      array += [node.value]
    end
  end

# O(n)
  def [](n)
    raise ArgumentError.new "#{n} can't be negative" if n < 0
    element = head
    n.times do
      element = element.pointer
      break if element.nil?
    end
    element
  end

# O(n)
  def []=(n, value)
    if n == 0
      prepend(value)
    elsif n > length || n < 0
      raise ArgumentError.new "#{n} must be less than or equal to size of this linked list"
    else
      new_element = Node.new(self[n], value)
      self[n-1].pointer = new_element
    end
  end

#O(1)
  def prepend(value)
    new_front = Node.new(head, value)
    self.head = new_front
    self
  end

# O(n)
  def last
    self[length-1]
  end

# O(n)
  def drop
    l = length
    if l == 1
      self.head = nil
    else
      self[l-2].pointer = nil
    end
    self
  end

# O(n)
  def append(value)
    self[length]=value
    self
  end

#maybe considered cheating because it uses array to do the heavy lifting
#O(n)

  def reverse_2
    a = to_a.reverse
    reduce do |count, node|
      node.value=a[count]
      count += 1
    end
    self
  end

# O(n)
  def reverse
    new_list = LinkedList.new(self.last.value)
    self.drop
    length.times do
      new_list.append(self.last.value)
      self.drop
    end
    new_list
  end
end
