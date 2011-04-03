class WikiController < ApplicationController
  before_filter :require_game
  
  
  def index
    
  end
  
  
  def find_or_create
    logger.info(params)
  end
  
end
