module TextNumberHelper
  DIGITS = %W(one two three four five six seven eight nine ten eleven twelve thirteen fourteen fifteen sixteen seventeen eighteen nineteen)
  TENS = %W(ten twenty thirty forty fifty sixty seventy eighty ninety)

  def to_words number
    return number.to_s unless is_valid? number

    case number
    when 0
      'zero'
    when 1000000
      'one million'
    else
      positive_integer_less_than_1_million_as_words number
    end
  end

  def positive_integer_less_than_1_million_as_words number
    digits = get_padded_digits(number) 

    lowest_three_digits = digits.pop(3)
    thousands = digits.pop(3)

    lowest_three_digits_string = three_digit_number_as_words(lowest_three_digits)
    thousands_string = thousands_as_words(thousands)

    concatenate_with thousands_string, ' ', lowest_three_digits_string
  end

  def get_padded_digits number
    padded_number = "%07d" % number
    digits = padded_number.split('').collect{|char| char.to_i }
  end

  def three_digit_number_as_words digits
    tens = digits.pop(2)
    hundreds = digits.pop

    tens_string = two_digit_number_as_word(tens)
    hundreds_string = hundreds_as_words(hundreds)

    concatenate_with hundreds_string, ' and ', tens_string
  end

  def two_digit_number_as_word digits
    tens, units = digits
    if tens < 2
      less_than_20_as_word(tens*10 + units)
    else
      units_string = (units > 0) ? "-#{less_than_20_as_word(units)}" : ''
      multiple_of_ten_as_word(tens) + units_string
    end
  end

  def thousands_as_words thousands
    result = three_digit_number_as_words(thousands)
    result.concat(' thousand') unless result.empty?
    result
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

  def concatenate_with first, concatenator, last
    result = first
    result.concat concatenator unless first.empty? or last.empty?
    result.concat last
  end

  def is_valid? number
    number.integer? and number >= 0 and number <= 1000000
  end
end
