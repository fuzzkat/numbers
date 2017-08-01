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

    thousands_words = thousands_as_words(thousands)
    lowest_three_digits_words = three_digit_number_as_words(lowest_three_digits, !thousands_words.empty?)

    result = thousands_words
    result.concat lowest_three_digits_words

    result.join(' ')
  end

  def get_padded_digits number
    padded_number = "%07d" % number
    digits = padded_number.split('').collect{|char| char.to_i }
  end

  def three_digit_number_as_words digits, has_thousands
    tens = digits.pop(2)
    hundreds = digits.pop

    tens_words = two_digit_number_as_words(tens)
    hundreds_words = hundreds_as_words(hundreds)

    has_tens = !tens_words.empty?
    has_hundreds = !hundreds_words.empty?

    result = hundreds_words
    if (has_thousands and !has_hundreds and has_tens) or (has_hundreds and has_tens)
      result << 'and'
    end
    result.concat(tens_words)
    result
  end

  def two_digit_number_as_words digits
    tens, units = digits
    words = []
    if tens < 2
      number = tens*10 + units
      word = less_than_20_as_word(number)
    else
      units_string = (units > 0) ? "-#{less_than_20_as_word(units)}" : ''
      word = multiple_of_ten_as_word(tens) + units_string
    end
    words << word unless word == ''
    words
  end

  def thousands_as_words thousands
    result = three_digit_number_as_words(thousands, false)
    result << 'thousand' unless result.empty?
    result
  end

  def hundreds_as_words hundreds
    hundreds > 0 ? [less_than_20_as_word(hundreds), 'hundred'] : []
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
