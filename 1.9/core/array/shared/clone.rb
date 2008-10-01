describe :array_clone, :shared => true do
  it "returns an Array when cloning an Array" do
    [].send(@method).class.should == Array
  end

  it "returns an instance of the class when cloning an instance of a subclass of Array" do
    ArraySpecs::MyArray[1, 2].send(@method).class.should == ArraySpecs::MyArray
  end

  it "produces a shallow copy where the references are directly copied" do
    a = [mock('1'), mock('2')]
    b = a.send @method
    b.first.object_id.should == a.first.object_id
    b.last.object_id.should == a.last.object_id
  end

  it "creates a new array containing all elements or the original" do
    a = [1, 2, 3, 4]
    b = a.send @method
    b.should == a
    b.__id__.should_not == a.__id__
  end

  it "copies taint status from the original" do
    a = [1, 2, 3, 4]
    b = [1, 2, 3, 4]
    a.taint
    aa = a.send @method
    bb = b.send @method

    aa.tainted?.should == true
    bb.tainted?.should == false
  end

  it "copies untrusted status from the original" do
    a = [1, 2, 3, 4]
    b = [1, 2, 3, 4]
    a.untrust
    aa = a.send @method
    bb = b.send @method

    aa.untrusted?.should == true
    bb.untrusted?.should == false
  end
end
