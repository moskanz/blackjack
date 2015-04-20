class Card
	@@suits = [:diams,:clubs,:hearts,:spades]
	@@symbols = [2,3,4,5,6,7,8,9,10,:J,:Q,:K,:A]

	attr_reader :symbol, :suit

	def initialize(symbol, suit)
	    if @@symbols.include?(symbol) and @@suits.include?(suit)
	      @symbol = symbol
	      @suit = suit
	    else
	      raise "Wrong card type"
	    end
	end

	def self.suits
       	@@suits
	end

	def self.symbols
		@@symbols
	end

	def value
		value = nil
		if @symbol.is_a? Integer
			value = @symbol
		else
			value = 10
			if @symbol == :A
				value = 11
			end
		end
		value
	end

end