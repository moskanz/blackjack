class Hand
	attr_reader :status, :cards, :bet

	def initialize(bet)
		@bet = bet
		@status = :ingame
		@cards = []
	end

	def take(card)
		@cards.push(card)
		check_busting
	end

	def doublebet
		@bet += @bet
	end

	def stay
		@status = :stand if canplay
	end

	def canplay
		@status == :ingame
	end

	def check_busting
		@status = :busted if calc_value.select{|cards_sum| cards_sum <= 21}.count == 0
	end

	def cansplit?
		@cards.count == 2 and @cards.first.symbol == @cards.last.symbol and canplay
	end

	def busted?
		status == :busted
	end

	def max_value
		calc_value.select{|cards_sum| cards_sum <= 21}.max
	end

	def calc_value
		variants = []
		values = @cards.map(&:value)
		variants.push values.sum
		aces = values.select{|v| v == 11}.count
		aces.times do |i| 
		  variants.push values.sum - 10*(i+1)
		end
		variants
	end
end