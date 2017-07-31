require 'rails_helper'

describe TextNumberHelper, type: :helper do

  example_data = YAML.load_file('spec/fixtures/numeric_examples.yml')

  describe '.get_two_digit_number' do
    context 'zero digit' do
      subject { helper.get_two_digit_number([0,0]) }
      it { is_expected.to eq('') }
    end

    ['ones', 'teens', 'tens'].each do |section|
      data = example_data[section].reject{|i| i==0}
      context section do
        data.each_pair do |number, word|
          digit_array = ("%02d" % number).split("").collect{|ch| ch.to_i}
          context digit_array.to_s do
            subject { helper.get_two_digit_number(digit_array) }
            it { is_expected.to eq(word) }
          end
        end

      end
    end
  end

  describe '.get_hundreds' do
    context 'non-zero number of hundreds' do
      it "should return the word equivalent of digit with hundred postfix" do
        expect(helper.get_hundreds(1)).to eq('one hundred')
        expect(helper.get_hundreds(4)).to eq('four hundred')
        expect(helper.get_hundreds(9)).to eq('nine hundred')
      end
    end
    context 'zero hundreds' do
      subject { helper.get_hundreds(0) }
      it { is_expected.to eq('') }
    end
    context 'bug checking' do
      it "should not change when called multiple times" do
        expect(helper.get_hundreds(1)).to eq('one hundred')
        expect(helper.get_hundreds(1)).to eq('one hundred')
      end
    end
  end

  describe '.to_words' do
    context "with a number outside of the range zero to 1 million" do
      it "should return the original number as a string" do
        expect(helper.to_words(-1)).to eq("-1")
        expect(helper.to_words(1000001)).to eq("1000001")
      end
    end

    context "with a number that is not an integer" do
      it "should return the original number as a string" do
        expect(helper.to_words(567.9)).to eq("567.9")
      end
    end
    
    example_data.each_pair do |number_type, examples|
      context number_type do
        examples.each do |input, expectation|
          context input do
            subject { helper.to_words(input) }
            it { is_expected.to eq(expectation) }
          end
        end
      end
    end

  end

end
