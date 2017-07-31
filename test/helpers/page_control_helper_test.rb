require 'test_helper'
require 'number_pager'

include ActionView::Helpers::AssetTagHelper

class PageControlHelperTest < ActionView::TestCase
  test "should show Previous link when not on page one" do
    pager = NumberPager.new(1000,2)
    output = page_control pager, self
    assert_match /prev/, output
  end

  test "should show Next link when not on last page" do
    pager = NumberPager.new(1000,100)
    output = page_control pager, self
    assert_match /next/, output
  end

  test "should not show Previous link when on page one" do
    pager = NumberPager.new(1000,1)
    output = page_control pager, self
    assert_no_match /prev/, output
  end

  test "should not show Next link when on last page" do
    pager = NumberPager.new(1000,1000)
    output = page_control pager, self
    assert_no_match /next/, output
  end

  test "should show current page number as non-link" do
    pager = NumberPager.new(1000,9)
    output = page_control pager, self
    assert_match /9/, output
    assert_no_match /<a.*>9<\/a>/, output
  end

  test "should show previous 3 page numbers as links" do
    pager = NumberPager.new(1000,9)
    output = page_control pager, self
    assert_match /<a.*>6<\/a>/, output
    assert_match /<a.*>7<\/a>/, output
    assert_match /<a.*>8<\/a>/, output
  end

  test "should show next 3 page numbers as links" do
    pager = NumberPager.new(1000,9)
    output = page_control pager, self
    assert_match /<a.*>10<\/a>/, output
    assert_match /<a.*>11<\/a>/, output
    assert_match /<a.*>12<\/a>/, output
  end

end
