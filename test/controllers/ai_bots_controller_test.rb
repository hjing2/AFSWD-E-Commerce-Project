require "test_helper"

class AiBotsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get ai_bots_new_url
    assert_response :success
  end

  test "should get create" do
    get ai_bots_create_url
    assert_response :success
  end
end
