require_relative './src/outputProcessor.rb'

class Principal
	def self.run(path)
		RomanToArabic.setRepeatableSymbolsCount
		RomanToArabic.setNonRepeatableSymbolsCount
		InputProcessor.processFile(path)
		InputProcessor.mapGalacticIntVal
		OutputProcessor.processQueries(InputProcessor.getQuestionsAndReplies).each do |result|
			puts result
		end
	end
end

path= "test.txt"
if ARGV.size > 0
	path=ARGV[0]
end
if(File.exist? path)
	Principal.run(path)
else
	abort("ERROR: File not found")
end
