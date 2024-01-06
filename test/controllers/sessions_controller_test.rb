require "test_helper"

class SessionsControllerTest < ActionDispatch::IntegrationTest
  URL = "http://127.0.0.1:3000"
  test "sessions#create 必須フィールド不足" do
    post "#{URL}/api/users/login", params: { user: { email: "", password: "jakejake" } }, as: :json
    assert_response 422

    post "#{URL}/api/users/login", params: { user: { email: "jake@jake.jake", password: "" } }, as: :json
    assert_response 422

    post "#{URL}/api/users/login", params: { user: { email: "", password: "" } }, as: :json
    assert_response 422
  end

  test "sessions#create 登録成功" do
    post "#{URL}/api/users/login", params: { user: { email: "jake@jake.jake", password: "jakejake" } }, as: :json
    assert_response 200
  end
end
