require 'rails_helper'

describe TextNumberHelper, type: :helper do

  example_data = YAML.load_file('spec/fixtures/numeric_examples.yml')

  describe '.two_digit_number_as_word' do
    context 'zero digit' do
      subject { helper.two_digit_number_as_word([0,0]) }
      it { is_expected.to eq('') }
    end

    ['ones', 'teens', 'tens'].each do |section|
      data = example_data[section].reject{|i| i==0}
      context section do
        data.each_pair do |number, word|
          digit_array = ("%02d" % number).split("").collect{|ch| ch.to_i}
          context digit_array.to_s do
            subject { helper.two_digit_number_as_word(digit_array) }
            it { is_expected.to eq(word) }
          end
        end

      end
    end
  end

  describe '.hundreds_as_words' do
    context 'non-zero number of hundreds' do
      it "should return the word equivalent of digit with hundred postfix" do
        expect(helper.hundreds_as_words(1)).to eq('one hundred')
        expect(helper.hundreds_as_words(4)).to eq('four hundred')
        expect(helper.hundreds_as_words(9)).to eq('nine hundred')
      end
    end
    context 'zero hundreds' do
      subject { helper.hundreds_as_words(0) }
      it { is_expected.to eq('') }
    end
    context 'called multiple times' do
      it "should not change" do
        expect(helper.hundreds_as_words(1)).to eq('one hundred')
        expect(helper.hundreds_as_words(1)).to eq('one hundred')
      end
    end
  end

  describe '.thousands_as_words' do
    context 'non-zero number of thousands' do
      it "should return the word equivalent of digit with thousands postfix" do
        expect(helper.thousands_as_words([1,2,3])).to eq('one hundred and twenty-three thousand')
        expect(helper.thousands_as_words([0,0,4])).to eq('four thousand')
        expect(helper.thousands_as_words([0,0,9])).to eq('nine thousand')
      end
    end
    context 'zero thousands' do
      subject { helper.thousands_as_words([0,0,0]) }
      it { is_expected.to eq('') }
    end
    context 'called multiple times' do
      it "should not change" do
        expect(helper.thousands_as_words([0,0,1])).to eq('one thousand')
        expect(helper.thousands_as_words([0,0,1])).to eq('one thousand')
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
