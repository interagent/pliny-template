require "test_helper"

describe App::Endpoints::Apps do
  def app
    App::Endpoints::Apps
  end

  describe "GET /" do
    it "succeeds" do
      get "/apps"
      assert_equal 200, last_response.status
      assert_equal "[]", last_response.body
    end
  end
end
