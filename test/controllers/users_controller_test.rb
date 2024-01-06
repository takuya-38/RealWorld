require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  URL = "http://127.0.0.1:3000"
  test "users#create 必須フィールド不足" do
    post "#{URL}/api/users", params: { user: { username: "", email: "jake@jake.jake", password: "jakejake" } }, as: :json
    assert_response 422

    post "#{URL}/api/users", params: { user: { username: "Jacob", email: "", password: "jakejake" } }, as: :json
    assert_response 422

    post "#{URL}/api/users", params: { user: { username: "Jacob", email: "jake@jake.jake", password: "" } }, as: :json
    assert_response 422

    post "#{URL}/api/users", params: { user: { username: "", email: "", password: "" } }, as: :json
    assert_response 422
  end

  test "users#create 登録成功" do
    post "#{URL}/api/users", params: { user: { username: "Jacob", email: "jake@jake.jake", password: "jakejake" } }, as: :json
    assert_response 201
  end
end
