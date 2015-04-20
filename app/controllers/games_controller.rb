class GamesController < ApplicationController

  before_filter :restore_player
  after_filter :store_player

  def index

  end

  def new
  	@player.new_game(params[:bet].to_i)
  	redirect_to :root
  end

  def doublebet
  	@player.doublebet(params[:index].to_i)
  	redirect_to :root
  end

  def split
  	@player.split(params[:index].to_i)
  	redirect_to :root
  end

  def stay
  	@player.stay(params[:index].to_i)
  	redirect_to :root
  end

  def onemore
  	@player.take_card(params[:index].to_i)
  	redirect_to :root
  end

  def reset_player
  	@player = Player.new
  	redirect_to :root
  end


  def restore_player  	
  	if session[:player]
  		begin
  			@player = Marshal::load(session[:player])
  		rescue
  			@player = Player.new
  		end
  	else
  		@player = Player.new
  	end
  end

  def store_player
  	session[:player] = Marshal::dump(@player)
  end

end