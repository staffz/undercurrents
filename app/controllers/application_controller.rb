class ApplicationController < ActionController::Base
  include AuthenticatedSystem
  include UrlHelper


  protect_from_forgery  
    
    
  protected
  def load_game
    return if request.subdomains.empty? || request.subdomains.first == 'www'
    require_game
  end
  
  def require_game_and_access_to_game
    require_game
    unless @current_game.has_access?(@current_user)
        redirect_to "http://www." +  configatron.base_url  + "/welcome" and return
    end
  end
  
  def require_game
    return if request.subdomains.empty? || request.subdomains.first == 'www'
    
    if Game.exists?(["domain = ?", request.subdomains.first])
      @current_game = Game.find_by_domain(request.subdomains.first)
    else
      redirect_to "http://www." +  configatron.base_url  + "/welcome" and return
    end    
  end

end
