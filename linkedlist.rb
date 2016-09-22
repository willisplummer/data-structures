class Node
  attr_accessor :pointer, :value
  def initialize(pointer, value)
    @pointer = pointer
    @value = value
  end
end

class LinkedList
  attr_accessor :head
  def initialize(value)
    @head = Node.new(nil, value)
  end

  def [](n)
    element = head
    n.times do
      element = element.pointer
      break if element.nil?
    end
    element
  end

  def []=(n, value)
    new_element = Node.new(self[n], value)
    self[n-1].pointer = new_element
  end

  def prepend(value)
    new_front = Node.new(head, value)
    self.head = new_front
  end

  def length
    count = 0
    pointer = head
    while !pointer.nil?
      count += 1
      pointer = pointer.pointer
    end
    count
  end

  def last
    self[length-1]
  end

  def drop
    self[length-2].pointer = nil
  end

  def append(value)
    self[length]=value
  end

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
