class Player
	attr_reader :deck, :money, :hands, :game
	def initialize
		@money = 1000
		@deck = Deck.new
	end

	def new_game(bet)
		return false if @money < bet || bet <= 0
		@money -= bet
		#@deck = Deck.new if @deck.need_reshuffle
		@game = Game.new(bet, @deck)
	end

	def split(hand_index)
		hand = @game.hands[hand_index]
		return false if !cansplit?(hand)
		@money -= hand.bet
		@game.split(hand_index)
	end

	def doublebet(hand_index)
		hand = @game.hands[hand_index]
		return false if !candoublebet?(hand)
		@money -= hand.bet
		@game.doublebet(hand_index)
	end

	def cansplit?(hand)
		!hand.nil? && @money >= hand.bet && hand.canplay && hand.cansplit?
	end

	def candoublebet?(hand)
		!hand.nil? && @money >= hand.bet && hand.canplay
	end


	def stay(hand_index)
		@game.stay(hand_index)
		finish_game
	end

	def take_card(hand_index)
		@game.take_card(hand_index)
		finish_game
	end

	def finish_game
	   @money += @game.take_prizes if @game.finished
	end
end