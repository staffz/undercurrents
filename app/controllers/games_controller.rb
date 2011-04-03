class GamesController < ApplicationController
  before_filter :require_game, :except => [:create]
  before_filter :login_required
  
  def index
    # logger.error("TEST" + config.domain )
  end
  
  
  def create 
    game = Game.new(:name => params[:game][:name], :owner => @current_user)
    if(game.save)
      redirect_to "http://" + game.name + "." + configatron.base_url  + "/games/"
    else 
      flash[:error] = game.errors.to_s 
      redirect_to :controller => :welcome
    end
  end

end
