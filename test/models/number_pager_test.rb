require 'test_helper'

class NumberPagerTest < ActiveSupport::TestCase

  test 'last_page should return the number of the last page when pagesize is a factor of 1 million' do
    unit = NumberPager.new(1000,1)
    assert_equal 1000, unit.last_page
  end

  test 'last_page should return the number of the last page when pagesize is not a factor of 1 million)' do
    unit = NumberPager.new(1001,1)
    assert_equal 1000, unit.last_page
  end

  test 'page should return last page if higher is requested' do
    unit = NumberPager.new(1000,1001)
    assert_equal 1000, unit.page
  end

  test 'page should return first page if lower is requested' do
    unit = NumberPager.new(1000,0)
    assert_equal 1, unit.page
  end

  test 'has_previous should return true if current page is greater than 1' do
    unit = NumberPager.new(1000,2)
    assert(unit.has_previous)
  end

  test 'has_previous should return false if current page is less than 2' do
    unit = NumberPager.new(1000,1)
    assert_equal(false, unit.has_previous)
  end

  test 'has_next should return true if current page is less than last page' do
    unit = NumberPager.new(1000,500)
    assert(unit.has_next)
  end

  test 'has_next should return false if current page is on last page' do
    unit = NumberPager.new(1000,1000)
    assert_equal false, unit.has_next
  end

  test 'has_page should return false if less than page 1' do
    unit = NumberPager.new(1000,1000)
    assert_equal false, unit.has_page(0)
  end

  test 'has_page should return false if greater than last page' do
    unit = NumberPager.new(1000,1000)
    assert_equal false, unit.has_page(1001)
  end
  
  test 'has_page should return true if asked about last page' do
    unit = NumberPager.new(1000,1000)
    assert(unit.has_page(1000))
  end

  test 'has_page should return true if asked about first page' do
    unit = NumberPager.new(1000,1000)
    assert(unit.has_page(1))
  end

  test 'has_page should return true if asked about other page' do
    unit = NumberPager.new(1000,1000)
    assert(unit.has_page(500))
  end

  test 'page should not return any numbers greater than 1 million' do
    unit = NumberPager.new(1500,667)
    assert_equal((999001..1000000), unit.this_page)
    assert(!unit.this_page.include?(1000001))
  end

  test 'page should not return any numbers lower than 1' do
    unit = NumberPager.new(1500,1)
    assert(!unit.this_page.include?(0))
  end

end
