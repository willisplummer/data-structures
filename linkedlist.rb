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
  def each(&block)
    ref = head
    while !ref.nil?
      block.call(ref)
      ref = ref.pointer
    end
    self
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

  #O(n)
  def [](n)
    raise ArgumentError.new "#{n} can't be negative" if n < 0
    element = head
    n.times do
      element = element.pointer
      break if element.nil?
    end
    element
  end

  #O(n)
  def []=(n, value)
    if n == 0
      prepend(value)
    elsif n > length || n < 0
      raise ArgumentError.new "#{n} must be less than or equal to size of this linked list"
    else
      preceding = self[n-1]
      new_node = Node.new(preceding.pointer, value)
      preceding.pointer = new_node
    end
  end

  #O(1)
  def prepend(value)
    new_front = Node.new(head, value)
    self.head = new_front
    self
  end

  #O(n)
  def last
    self[length-1]
  end

  #O(n)
  def drop
    l = length
    if l == 1
      self.head = nil
    else
      self[l-2].pointer = nil
    end
    self
  end

  #O(n)
  def append(value)
    self[length]=value
    self
  end

  #O(n)
  def reverse_in_place
    prev = nil
    ref = head
    while !ref.nil?
      current_node = ref
      next_node = current_node.pointer
      last_node = current_node if ref.pointer.nil?
      ref.pointer = prev
      prev = current_node
      ref = next_node
    end
    self.head = last_node
  end

  #O(n)
  def reverse
    prev = nil
    ref = head
    while !ref.nil?
      current_node_copy = Node.new(prev, ref.value)
      last_node = current_node_copy if ref.pointer.nil?
      prev = current_node_copy
      ref = ref.pointer
    end
    list = LinkedList.new(0)
    list.head = last_node
    list
  end
end
