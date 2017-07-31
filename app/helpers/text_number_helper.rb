module TextNumberHelper
  DIGITS = %W(one two three four five six seven eight nine ten eleven twelve thirteen fourteen fifteen sixteen seventeen eighteen nineteen)
  TENS = %W(ten twenty thirty forty fifty sixty seventy eighty ninety)

  def to_words number
    return number.to_s unless is_valid? number
    return 'zero' if number == 0

    padded_number = "%07d" % number

    digits = padded_number.scan(/\d/).collect{|char| char.to_i }
   
    # thousands = digits.pop(3)
    # thousands_string = to_words(thousands.join.to_i) + " "
    result = "" 
    result.concat get_three_digit_number digits
  end

  def get_three_digit_number digits
    tens = digits.pop(2)
    tens_string = get_two_digit_number(tens)

    hundreds = digits.pop
    hundreds_string = get_hundreds(hundreds)

    result = ""
    result.concat hundreds_string
    result.concat ' and ' unless hundreds_string.empty? or tens_string.empty?
    result.concat tens_string
  end

  def get_two_digit_number digit_array
    tens, units = digit_array
    if tens < 2
      get_number_of_units_as_word(tens*10 + units)
    else
      units_string = units == 0 ? '' : "-#{get_number_of_units_as_word(units)}"
      get_number_of_tens_as_word(tens) + units_string
    end
  end

  def get_hundreds digit
    if digit > 0
      get_number_of_units_as_word(digit) + ' hundred'
    else
      ''
    end
  end

  def get_number_of_units_as_word digit
    digit == 0 ? '' : DIGITS[digit-1]
  end

  def get_number_of_tens_as_word tens
    tens == 0 ? '' : TENS[tens-1]
  end

  def is_valid? number
    number.integer? and number >= 0 and number <= 1000000
  end
end
