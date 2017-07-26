require 'test_helper'

class NumbersControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get numbers_path
    assert_response :success
  end

  test "should display a title that includes the word form of your requested count" do
    get numbers_path count: 500
    assert_match "You're Five Hundred in a Million", @response.body
  end

  test "should display the first number and last number of the correct page" do
    get numbers_path count: 10, page: 2
    assert_match "eleven", @response.body
    assert_match "twenty", @response.body
  end

  test "should not display the numbers outside of the correct page" do
    get numbers_path count: 10, page: 3
    assert_no_match "twenty ", @response.body
    assert_no_match "thirty-one", @response.body
  end

  test "should display the pager without the current page linked" do
    get numbers_path count: 10, page: 2
    assert_match ">1<", @response.body
    assert_no_match ">2<", @response.body
    assert_match ">3<", @response.body
  end
end
