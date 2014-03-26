require "test_helper"

describe Endpoints::Apps do
  def app
    Endpoints::Apps
  end

  describe "GET /" do
    it "succeeds" do
      get "/apps"
      assert_equal 200, last_response.status
      assert_equal "[]", last_response.body
    end
  end
end
