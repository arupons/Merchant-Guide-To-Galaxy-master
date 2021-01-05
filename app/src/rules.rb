class Rules
	@@repeatableSymbols = ["I", "X", "C", "M"]
	@@nonRepeatableSymbols = ["D", "L", "V"]

	def self.setRepeatableSymbolsCount
		@@repeatableSymbolsCount= {I: 0, X: 0, C: 0, M: 0}
	end

	def self.setNonRepeatableSymbolsCount
		@@nonRepeatableSymbolsCount= {D: 0, L: 0, V: 0}
	end

	def self.getRepeatableSymbolsCount
		@@repeatableSymbolsCount
	end

	def self.getNonRepeatableSymbolsCount
		@@nonRepeatableSymbolsCount
	end

	def self.resetSymbolsCount
		setRepeatableSymbolsCount
		setNonRepeatableSymbolsCount
	end

	 #Applies the subtaction logic and checks if the element is subtractable by the other or not.
	 def self.romanSubtraction(currentSum, currentNumber, previousNumber)
	 	if (ROMAN_PRECEDENCE_MAP[previousNumber].include? currentNumber)
	 		resetSymbolsCount
	 		result = currentSum - previousNumber + (currentNumber - previousNumber)
	 	else
	 		result = currentNumberIsSmallerThanPrevious(currentNumber, previousNumber) if previousNumber!=0
	 		unless result.is_a? String
	 			result = currentSum + currentNumber
	 		end
	 	end
	 	return result
	 end

	#Method to check if current Symbol is smaller than the previous, for repeatable Symbols who occur 4 times
	def self.currentSymbolIsSmallerThanPrevious (currentSymbol, previousSymbolKey)
		if (ROMAN_TO_ARABIC_MAP[currentSymbol.to_sym]>ROMAN_TO_ARABIC_MAP[previousSymbolKey.to_sym])
			return "ERROR: There must be a lesser Roman symbol instead of #{currentSymbol}"
		end
	end

	#Method to check if current Number is smaller than the previous, for repeatable Numbers who occur 4 times
	def self.currentNumberIsSmallerThanPrevious (currentNumber, previousNumber)
		if (currentNumber>previousNumber && !canBeSubtracted(previousNumber))
			return "ERROR: There must be a lesser Roman symbol instead of #{ROMAN_TO_ARABIC_MAP.key(currentNumber)}"
		end
	end

	#Method to keep the count of all repeatable and non repeatable Symbols.
	def self.countSymbol(currentSymbol, previousSymbol)
		if (currentSymbol.upcase==previousSymbol.upcase)
			if @@nonRepeatableSymbols.include? currentSymbol
				@@nonRepeatableSymbolsCount[currentSymbol.to_sym]+=1
			else
				if @@repeatableSymbols.include? currentSymbol
					@@repeatableSymbolsCount[currentSymbol.to_sym]+=1
				end
			end
		end
	end

	#Method to check validity of repeated symbols
	def self.checkCountForSymbol(currentSymbol, previousSymbol)
		countSymbol(currentSymbol, previousSymbol)
		unless (@@nonRepeatableSymbolsCount[currentSymbol.to_sym].nil?)
			if (@@nonRepeatableSymbolsCount[currentSymbol.to_sym]>1)
				return "ERROR: Roman number #{currentSymbol} can not be repeated"
			end
		end
		unless (@@repeatableSymbolsCount[currentSymbol.to_sym].nil?)
			if (@@repeatableSymbolsCount[currentSymbol.to_sym]>2)
				return "ERROR: #{currentSymbol} can not be repeated more than 3 times in a row"
			end
		end
	end

	#Check if the number can be subtracted from others
	def self.canBeSubtracted(number)
		if(ROMAN_PRECEDENCE_MAP[number].empty?)
			result = false
		else
			result = true
		end
	end



	private
		#Hash of subtractable numbers, it's included key 0 for validate first value of previousNumber variable
		ROMAN_PRECEDENCE_MAP= {
			0 => [],
			1 => [5,10],
			5 => [],
			10 => [50,100],
			50 => [10],
			100 => [500, 1000],
			500 => [],
			1000 => []
		}

		ROMAN_TO_ARABIC_MAP= {
			I: 1,
			V: 5,
			X: 10,
			L: 50,
			C: 100,
			D: 500,
			M: 1000
		}
end