require_relative '../app/src/outputProcessor.rb'

describe OutputProcessor do

	before(:each) do
		Rules.setRepeatableSymbolsCount
		Rules.setNonRepeatableSymbolsCount
		InputProcessor.processFile("test.txt")
		InputProcessor.mapGalacticIntVal
		@input = "how much wood could a woodchuck chuck if a woodchuck could chuck wood ?"
		@query = "how much is pish tegj glob glob ?"
		@output = ["pish", "tegj", "glob", "glob"]
	end

	describe '#processQueries' do
		it "should return an Array" do        
	        expect(OutputProcessor.processQueries(InputProcessor.getQuestionsAndReplies).class.to_s).to eq "Array"
	    end
	end

	describe '#splitQuery' do
		it 'should return an Array with 4 elements' do
			expect(OutputProcessor.splitQuery(@query).size).to eq 4
		end
		it 'should return an Array with elements to convert' do
			expect(OutputProcessor.splitQuery(@query)).to eq @output
		end
	end

	describe '#formatOutput' do
		it 'should return the conversion result formated to print' do
			expect(OutputProcessor.formatOutput(@output, 4)).to eq @output.join(" ") << " is 4 Credits"
		end
	end

end