require 'rails_helper'

describe TextNumberHelper, type: :helper do

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

  context "with the unit and teen integers" do
    it "should return the string equivalent" do
      expect(helper.to_words(0)).to eq("zero")
      expect(helper.to_words(1)).to eq("one")
      expect(helper.to_words(2)).to eq("two")
      expect(helper.to_words(3)).to eq("three")
      expect(helper.to_words(4)).to eq("four")
      expect(helper.to_words(5)).to eq("five")
      expect(helper.to_words(6)).to eq("six")
      expect(helper.to_words(7)).to eq("seven")
      expect(helper.to_words(8)).to eq("eight")
      expect(helper.to_words(9)).to eq("nine")
      expect(helper.to_words(10)).to eq("ten")
      expect(helper.to_words(11)).to eq("eleven")
      expect(helper.to_words(12)).to eq("twelve")
      expect(helper.to_words(13)).to eq("thirteen")
      expect(helper.to_words(14)).to eq("fourteen")
      expect(helper.to_words(15)).to eq("fifteen")
      expect(helper.to_words(16)).to eq("sixteen")
      expect(helper.to_words(17)).to eq("seventeen")
      expect(helper.to_words(18)).to eq("eighteen")
      expect(helper.to_words(19)).to eq("nineteen")
    end
  end

end
