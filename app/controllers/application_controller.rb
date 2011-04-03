class ApplicationController < ActionController::Base
  include AuthenticatedSystem
  include UrlHelper


  protect_from_forgery  
    
    
  protected
  
  def load_game
    return if request.subdomains.empty? || request.subdomains.first == 'www'
    require_game
  end
  
  def require_game
    return if request.subdomains.empty? || request.subdomains.first == 'www'
    
    if Game.exists?(["name = ?", request.subdomains.first])
      @current_game = Game.find_by_name(request.subdomains.first)
    else
      redirect_to "http://www." +  configatron.base_url  + "/welcome"
    end    
  end

end
