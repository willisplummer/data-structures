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
  def initialize(node=nil)
    @head = node
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
    elsif n < 0
      raise ArgumentError.new "#{n} must be less than or equal to size of this linked list"
    else
      preceding = self[n-1]
      raise ArgumentError.new "#{n} must be less than or equal to size of this linked list" if preceding.nil?
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
    reduce{|last, node| last = node if node.pointer.nil?}
  end

  #O(n)
  def drop
    each do |node|
      if node.pointer.nil?
        self.head = nil
      elsif node.pointer.pointer.nil?
        node.pointer = nil
      end
    end
  end

  #O(n)
  def append(value)
    new_node = Node.new(nil, value)
    if head.nil?
      self.head = new_node
    else
      each do |node|
        if node.pointer.nil?
          node.pointer = new_node
          break
        end
      end
    end
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
    LinkedList.new(last_node)
  end
end
