require 'test_helper'

class PostsControllerTest < ActionController::TestCase
	test "get index for authenticated users" do
		user1 = users(:user1)
		get :index, {}, { user_id: user1.id }
		assert_response :success
	end
end
