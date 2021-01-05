require_relative './inputProcessor.rb'


class OutputProcessor < InputProcessor
	#Method to itertates over the questionAndReply map that contain all the valid queries as keys and process them.
	def self.processQueries(queries)
		results = Array.new
		queries.each do |query, result|
			if (query.downcase.start_with? "how much")
				result = findValueOfKnownGalacticNumber(query, InputProcessor.getGalacticRomanMap)
			else
				result = findValueOfUnknownGalacticNumber(query, InputProcessor.getGalacticRomanMap, InputProcessor.getSymbolsValueList)
			end
			#puts result
			results.push result
		end
		return results
	end

	#Method to process known galactic number
	def self.findValueOfKnownGalacticNumber(query, galacticRomanMap)
		galacticValue = splitQuery(query)
		romanValue = Array.new
		symbol = nil
		galacticValue.each do |key|
			if(galacticRomanMap.has_key? key)
				romanValue.push galacticRomanMap[key]
			else
				return "I have no idea what you are talking about"
			end
		end
		val = RomanToArabic.romanToArabic(romanValue.join)
		return formatOutput(galacticValue, val.to_i)
	end

	#Method to process unknown galactic number
	def self.findValueOfUnknownGalacticNumber(query, galacticRomanMap, symbolsValueList)
		galacticValue = splitQuery(query)
		romanValue = Array.new
		symbolValue = ""
		galacticValue.each do |key|
			unless (galacticRomanMap[key].nil?)
				romanValue.push galacticRomanMap[key]
			else
				unless symbolsValueList[key].nil?
				 	symbolValue = symbolsValueList[key]
				 else
				 	return "I have no idea what you are talking about"
				end
			end
		end
		val = RomanToArabic.romanToArabic(romanValue.join) * symbolValue.to_f
		return formatOutput(galacticValue, val.to_i)
	end	

	def self.formatOutput(query, result)
		output = query.join(" ") << " "
		#query.each do |val|
		#	output << val << " "
		#end
		return output << "is " << result.to_s << " Credits"
	end
	#Method to split the query and return an array with the galactic symbols
	def self.splitQuery(query)
		arr = query.split(" is ")
		result = arr.last.split
		result.pop
		return result
	end

end