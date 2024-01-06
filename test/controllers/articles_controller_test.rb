require "test_helper"

class ArticlesControllerTest < ActionDispatch::IntegrationTest
  URL = "http://127.0.0.1:3000"

  def setup
    @article = articles(:one)
  end

  test "article#show 成功" do
    get "#{URL}/api/articles/1"
    assert_response 200
  end

  test "article#create 成功" do
    post "#{URL}/api/articles", params: { article: { title: "How to train your dragon", description: "Ever wonder how?", body: "You have to believe", tagList: "['reactjs', 'angularjs', 'dragons']" } }, as: :json
    assert_response 200
  end

  test "article#update 成功" do
    patch "#{URL}/api/articles/1", params: { article: { title: "Did you train your dragon?" } }, as: :json
    assert_response 200
  end

  test "article#destroy 成功" do
    delete "#{URL}/api/articles/1"
    assert_response 200
  end
end
