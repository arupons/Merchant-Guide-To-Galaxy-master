require_relative '../app/src/inputProcessor.rb'

describe InputProcessor do

	before(:each) do
		Rules.setRepeatableSymbolsCount
		Rules.setNonRepeatableSymbolsCount
	end

	describe '#getQuestionsAndReplies' do
		it "should return a Hash" do        
	        expect(InputProcessor.getQuestionsAndReplies.class.to_s == 'Hash')
	    end
	end

	describe '#getGalacticRomanMap' do
		it "should return a Hash" do        
	        expect(InputProcessor.getGalacticRomanMap.class.to_s == 'Hash')
	    end
	end

	describe '#getSymbolsValueList' do
		it "should return a Hash" do        
	        expect(InputProcessor.getSymbolsValueList.class.to_s == 'Hash')
	    end
	end

end