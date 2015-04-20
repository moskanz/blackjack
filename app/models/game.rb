class Game
	attr_reader :bet, :dealer, :hands, :finished
	def initialize(bet, deck)
		@finished = false
		@bet = bet
		@deck = deck
		@dealer = Hand.new(bet)
		@dealer.take deck.next
		@dealer.take deck.next
		hand = Hand.new(bet)
		hand.take deck.next
		hand.take deck.next
		@hands = [hand]
		@prizes_taken = false
	end

	def take_card(hand = 0)
		return false if @hands[hand].nil? || !@hands[hand].canplay
		@hands[hand].take @deck.next
		@hands[hand].check_busting
		finish?
	end

	def stay(hand = 0)
		return false if @hands[hand].nil? || !@hands[hand].canplay		
		@hands[hand].stay
		finish?
	end

	def doublebet(hand = 0)
		return false if @hands[hand].nil? || !@hands[hand].canplay
		@hands[hand].doublebet
		@hands[hand].take @deck.next
		@hands[hand].stay
		finish?
	end

	def split(hand = 0)
		return false if @hands[hand].nil? || !@hands[hand].canplay
		temp = @hands[hand]
		@hands.delete_at(hand)
		hand = Hand.new(temp.bet)
		hand.take temp.cards.first
		hand.take @deck.next
		@hands.push hand
		hand = Hand.new(temp.bet)
		hand.take temp.cards.last
		hand.take @deck.next
		@hands.push hand
	end

	def dealer_take_cards
		until @dealer.busted? || @dealer.max_value >=17 do
			@dealer.take @deck.next
		end
	end

	def prizes
		prizes = 0
		@hands.each do |hand|
			if hand.status == :stand
				if @dealer.busted?
					prizes += hand.bet * 2
				else
					if hand.max_value > @dealer.max_value
						prizes += hand.bet * 2
					end
				end
			end
		end
		prizes
	end

	def take_prizes
		return 0 if @prizes_taken		
		@prizes_taken = true
		prizes
	end

	def finish?
		@finished = true if @hands.map(&:status).index(:ingame).nil?
		dealer_take_cards if !@hands.map(&:status).index(:stand).nil?
	end

end