require_relative 'linkedlist.rb'
require 'rspec'

context "linked list" do
  subject do
    LinkedList.new(1)
  end

  context "#append" do
    it "adds an element to the end of the list" do
      subject.append(2)
      expect(subject.head.pointer.value).to eq(2)
    end
  end

  def long_list
    subject.append(2)
      .append(3)
      .append(4)
  end

  context "#to_a" do
    it "converts the list to an array" do
      expect(subject.to_a).to eq([1])
    end

    it "can handle lists of any size" do
      expect(long_list.to_a).to eq([1, 2, 3, 4])
    end
  end

  context "#length" do
    it "returns the length of the list" do
      expect(subject.length).to eq(1)
    end

    it "can handle lists of any size" do
      expect(long_list.length).to eq(4)
    end
  end

  context "#[]" do
    it "retrieves the nth element" do
      expect(long_list[0].value).to eq(1)
    end

    it "can handle lists of any size" do
      expect(long_list[3].value).to eq(4)
    end

    it "returns if nill if the index is out of bounds" do
      expect(long_list[420]).to eq(nil)
    end

    it "raises an error if n is less than 0" do
      expect { long_list[-6] }.to raise_error(ArgumentError)
    end
  end

  context "#[]=" do
    it "sets the nth element" do
      i = long_list
      initial_length = i.length
      i[2] = "insertion"
      expect(i[2].value).to eq("insertion")
      expect(i.length).to eq(initial_length + 1)
      expect(i.to_a).to eq([1, 2, "insertion", 3, 4])
    end

    it "can set the last element" do
      i = long_list
      initial_length = i.length
      i[initial_length] = "insertion"
      expect(i[initial_length].value).to eq("insertion")
      expect(i.length).to eq(initial_length + 1)
      expect(i.to_a).to eq([1, 2, 3, 4, "insertion"])
    end

    it "can set the first element" do
      i = long_list
      initial_length = i.length
      i[0] = "insertion"
      expect(i[0].value).to eq("insertion")
      expect(i.length).to eq(initial_length + 1)
      expect(i.to_a).to eq(["insertion", 1, 2, 3, 4])
    end

    it "raises an error if n > length of list" do
      expect { long_list[6]="testing" }.to raise_error(ArgumentError)
    end

    it "raises an error if n is less than 0" do
      expect { long_list[-6]="testing" }.to raise_error(ArgumentError)
    end
  end

  context "#prepend" do
    it "adds the argument to the front of the list" do
      expect(subject.prepend(0).length).to eq(2)
      expect(subject[0].value).to eq(0)
    end
  end

  context "#last" do
    it "gets the final element of the list" do
      expect(subject.last.value).to eq(1)
      expect(long_list.last.value).to eq(4)
    end
  end

  context "#drop" do
    it "removes the final element of the list" do
      dropped_long_list = long_list.drop
      expect(dropped_long_list.length).to eq(3)
      expect(dropped_long_list.to_a).to eq([1, 2, 3])
    end

    it "removes the only element if there is only one" do
      expect(subject.drop.length).to eq(0)
      expect(subject.to_a).to eq([])
    end
  end

  context "#reverse" do
    it "returns the linkedlist in reverse as new object" do
      ll = long_list
      expect(ll.reverse.to_a).to eq([4, 3, 2, 1])
    end
  end

  context "#reverse_2" do
    it "reverses the linkedlist in place" do
      ll = long_list
      ll.reverse_2
      expect(ll.to_a).to eq([4, 3, 2, 1])
    end
  end
end
