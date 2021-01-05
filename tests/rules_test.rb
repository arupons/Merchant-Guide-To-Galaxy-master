require_relative '../app/src/rules.rb'

describe Rules do

	before(:each) do
		Rules.setRepeatableSymbolsCount
		Rules.setNonRepeatableSymbolsCount
	end

	describe '#getRepeatableSymbolsCount' do
		it "should return a Hash" do        
	        expect(Rules.getRepeatableSymbolsCount.class.to_s == 'Hash')
	    end
	end

	describe '#romanSubtaction' do
		it 'Should return an Integer' do
			expect(Rules.romanSubtraction(0, 1, 0).class.to_s == 'Numeric')
		end
		it 'Should subtract the previous number from the current number and from the collection if is subtractable' do
			expect(Rules.romanSubtraction(10, 5, 1)).to be 13
			expect(Rules.romanSubtraction(0, 10, 1)).to be 8
		end
		it 'Should add the current to collection if previous number is not subtractable' do
			expect(Rules.romanSubtraction(5, 10, 5).split(":").first).to eq "ERROR"
		end
	end

	describe "#canBeSubtracted" do
		it "Should return false if can't be subtracted" do
			expect(Rules.canBeSubtracted(5)).to be false
		end
		it "Should return true if can be subtracted" do
			expect(Rules.canBeSubtracted(10)).to be true
		end
	end
end