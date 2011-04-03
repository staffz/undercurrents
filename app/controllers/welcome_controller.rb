class WelcomeController < ApplicationController
  
  before_filter :load_game, :redirect_if_game
  
  
  private 
  
  def redirect_if_game
    redirect_to '/games' unless @current_game.nil?
  end
end
