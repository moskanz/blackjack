class Deck
	attr_reader :cards

	def initialize
		@cards = []
		Card.suits.each do |suit|
			Card.symbols.each do |symbol|
				@cards.push Card.new(symbol, suit)
			end
		end
		@random_card = 26 + rand(10) # random card from second part of a deck to reshuffle Deck
		@cards.shuffle!
	end

	def need_reshuffle
		@cards.count < (52 - @random_card) 
	end

	def next
		raise "Deck is empty" if @cards.count == 0
        @cards.pop
	end
end