require_relative "./romanToArabic"

class InputProcessor
	@galacticRomanMap = Hash.new
	@galacticIntVal = Hash.new
	@questionsAndReplies = Hash.new
	@missingSymbols = Array.new
	@symbolsValueList = Hash.new

	#Static getters for the class
	def self.getQuestionsAndReplies
		return @questionsAndReplies
	end

	def self.getGalacticRomanMap
		return @galacticRomanMap
	end

	def self.getSymbolsValueList
		return @symbolsValueList
	end
	# If file path is specified that is picked up else by default use test.txt.
	def self.processFile(path)
		if(path.nil?)
			abort("File not found")
		end
		file = File.readlines(path)
		file.each do |line|
			arr = line.split
			case 
				when arr.last=="?" then @questionsAndReplies[line] = ""
				when arr[1].downcase == "is" then @galacticRomanMap[arr.first] = arr.last
				when arr.last.downcase == "credits" || arr.last.downcase == "credit" then @missingSymbols.push line
			end
		end
	end

	def self.mapGalacticIntVal
		@galacticRomanMap.each do |key, symbol|
			value = RomanToArabic.romanToArabic(symbol)
			@galacticIntVal[key]=value
		end	
		mapMissingSymbols
	end

	#Find the value of elements that is not provided in the input
	def self.mapMissingSymbols
		@missingSymbols.each do |line|
			decodeMissingSymbols(line)
		end
	end

	#Calculates the values of various elements and appends the same to the map 
	def self.decodeMissingSymbols(line)
		romanNumber = ""
		arr = line.split
		credits = arr[-2].to_f
		splitIndex = arr.find_index("is")-1
		galacticSymbol = arr[splitIndex]
		symbols = line.split(" is ")[0].split
		symbols.pop
		symbols.each do |symbol|
			if (@galacticRomanMap.include? symbol)
				romanNumber << @galacticRomanMap[symbol]
			end
		end 
		arabicValue = RomanToArabic.romanToArabic(romanNumber)
		return @symbolsValueList[galacticSymbol]=credits/arabicValue
	end
end