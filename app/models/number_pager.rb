class NumberPager

  FIRST_NUMBER = 1
  FIRST_PAGE = 1
  LAST_NUMBER = 1000000

  def initialize(count="1000", page="1")
    @count = count ? count.to_i : 1000
    @requested_page = page.to_i
  end

  def this_page
    first_index = (page-1) * @count + 1 
    last_index = [page * @count, LAST_NUMBER].min
    Range.new(first_index, last_index)
  end

  def count
    @count
  end

  def page
    [[@requested_page, last_page].min, FIRST_PAGE].max
  end

  def has_previous
    page > FIRST_PAGE
  end

  def has_next
    page < last_page
  end

  def has_page test_page
    test_page <= last_page && test_page >= FIRST_PAGE
  end

  def last_page
    (LAST_NUMBER.to_f / @count).ceil
  end
end
