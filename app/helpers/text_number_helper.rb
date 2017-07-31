module TextNumberHelper
  DIGITS = %W(one two three four five six seven eight nine ten eleven twelve thirteen fourteen fifteen sixteen seventeen eighteen nineteen)
  TENS = %W(ten twenty thirty forty fifty sixty seventy eighty ninety)

  def to_words number
    return number.to_s unless is_valid? number
    return 'zero' if number == 0
    return 'one million' if number == 1000000

    padded_number = "%07d" % number

    digits = padded_number.scan(/\d/).collect{|char| char.to_i }
  
    lowest_three_digits = digits.pop(3)
    thousands = digits.pop(3)

    lowest_three_digits_string = three_digit_number_as_words(lowest_three_digits)
    thousands_string = thousands_as_words(thousands)

    result = thousands_string
    result.concat ' ' unless thousands_string.empty? or lowest_three_digits_string.empty?
    result.concat lowest_three_digits_string
  end

  def three_digit_number_as_words digits
    tens = digits.pop(2)
    tens_string = two_digit_number_as_word(tens)

    hundreds = digits.pop
    hundreds_string = hundreds_as_words(hundreds)

    result = hundreds_string
    result.concat ' and ' unless hundreds_string.empty? or tens_string.empty?
    result.concat tens_string
  end

  def two_digit_number_as_word digit_array
    tens, units = digit_array
    if tens < 2
      less_than_20_as_word(tens*10 + units)
    else
      units_string = (units > 0) ? "-#{less_than_20_as_word(units)}" : ''
      multiple_of_ten_as_word(tens) + units_string
    end
  end

  def thousands_as_words thousands
    thousands_string = three_digit_number_as_words(thousands)
    thousands_string.concat(' thousand') unless thousands_string.empty?
    thousands_string
  end

  def hundreds_as_words hundreds
    hundreds > 0 ? less_than_20_as_word(hundreds) + ' hundred' : ''
  end

  def less_than_20_as_word digit
    digit == 0 ? '' : DIGITS[digit-1]
  end

  def multiple_of_ten_as_word tens
    tens == 0 ? '' : TENS[tens-1]
  end

  def is_valid? number
    number.integer? and number >= 0 and number <= 1000000
  end
end
