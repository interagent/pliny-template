require "test_helper"

describe Pliny::Generator do
  before do
    @gen = Pliny::Generator.new ["model", "resource_history"]
  end

  describe "#class_name" do
    it "builds a class name" do
      assert_equal "ResourceHistory", @gen.class_name
    end
  end

  describe "#table_name" do
    it "uses the plural form" do
      assert_equal "resource_histories", @gen.table_name
    end
  end
end
