module TextNumberHelper
  DIGITS = %W(zero one two three four five six seven eight nine ten eleven twelve thirteen fourteen fifteen sixteen seventeen eighteen nineteen)
  TENS = %W(ten twenty thirty forty fifty sixty seventy eighty ninety)

  def to_words number
    return number.to_s unless is_valid? number
    
    get_tens(number)
  end

  def get_tens number
    DIGITS[number] if number < 20
  end

  def is_valid? number
    number.integer? and number >= 0 and number <= 1000000
  end
end
