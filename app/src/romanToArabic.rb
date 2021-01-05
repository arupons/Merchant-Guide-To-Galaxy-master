require_relative './rules'

class RomanToArabic < Rules
	def self.romanToArabic(romanNumber)
		collector = 0
		previousNumber = 0
		romanSymbols = romanNumber.upcase.split("")
		romanSymbols.each do |romanSymbol|
			tmpResult = processRoman(romanSymbol, previousNumber, collector)
			unless tmpResult.is_a? String
				collector = tmpResult
				previousNumber = ROMAN_TO_ARABIC_MAP[romanSymbol.to_sym]
			else
				return tmpResult
			end
		end
		resetSymbolsCount
		return collector
	end

	def self.processRoman(romanNumber, previousNumber, currentSum)
		result= checkCountForSymbol(romanNumber, ROMAN_TO_ARABIC_MAP.key(previousNumber).to_s)
		unless (result.is_a? String)
			result = processArabic(ROMAN_TO_ARABIC_MAP[romanNumber.to_sym], previousNumber, currentSum)
		end
		return result
	end

	def self.processArabic(currentNumber, previousNumber, currentSum)
		if (previousNumber < currentNumber && canBeSubtracted(previousNumber))
			result = romanSubtraction(currentSum, currentNumber, previousNumber)
		else
			result = currentSum + currentNumber
		end
		return result
	end
end