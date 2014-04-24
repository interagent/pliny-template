require "spec_helper"

describe Artist do
  it "should be 0" do
    Artist.count.should eq(0)
  end
end
