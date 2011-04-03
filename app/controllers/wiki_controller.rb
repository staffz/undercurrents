class WikiController < ApplicationController
  before_filter :require_game
  
  def update
        @wikipage = @current_game.wiki_pages.find_by_url(params[:page_name])
        @wikipage.content = params[:wiki_page][:content]
        @wikipage.save
        
        redirect_to  "/wikis/" + @wikipage.url
  end
  
  
  def edit
    @wikipage = @current_game.wiki_pages.find_by_url(params[:page_name])
  end
  
  
  def find_or_create
    @wikipage = @current_game.wiki_pages.find_or_create_by_url(params[:page_name])
    if @wikipage.content.nil?
      if request.user_agent
        render :text => @wikipage.url, :status => 201 and return
      end
    end
    
    
    
  end
  
end
