require_relative '../app/src/romanToArabic.rb'

describe RomanToArabic do

	before(:each) do
		Rules.setRepeatableSymbolsCount
		Rules.setNonRepeatableSymbolsCount
	end

	describe '#romanToArabic' do
		it "should return a Numeric value" do        
	        expect(RomanToArabic.romanToArabic("X").class.to_s).to eq 'Fixnum'
	    end
	    it "should return an error when the roman number is not valid" do        
	        expect(RomanToArabic.romanToArabic("XXXX").class.to_s).to eq 'String'
	    end

	    it "should convert Roman number to Arabic" do        
	        expect(RomanToArabic.romanToArabic("XV")).to be 15
	    end
	end

	describe "#processRoman" do
		it "should return a Numeric value" do        
	        expect(RomanToArabic.processRoman("X", 1, 1).class.to_s).to eq 'Fixnum'
	    end
	    it "should return a 9 when Roman IX" do        
	        expect(RomanToArabic.processRoman("X", 1, 1)).to eq 9
	    end

	    it "should return a 11 when Roman XI" do        
	        expect(RomanToArabic.processRoman("I", 10, 10)).to eq 11
	    end
	end
end