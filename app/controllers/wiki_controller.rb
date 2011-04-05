class WikiController < ApplicationController
  before_filter :require_game, :login_required 

  def update
        @wikipage = @current_game.wiki_pages.find_by_url(params[:page_name])
        @wikipage.content = params[:wiki_page][:content]
        @wikipage.save
        
        if params[:native]
          render :nothing => true, :status => 200
        else 
          redirect_to  "/wikis/" + @wikipage.url
        end
  end
  
  def edit
    @wikipage = @current_game.wiki_pages.find_by_url(params[:page_name])
  end
  
  def text
    @wikipage = @current_game.wiki_pages.find_or_create_by_url(params[:page_name])
    if params[:native]
      render :text => @wikipage.content_with_links_for_ipad, :status => 200
    else 
      redirect_to  "/wikis/" + @wikipage.url
    end
    
  end
  
  def find_or_create
    @wikipage = @current_game.wiki_pages.find_or_create_by_url(params[:page_name])
        
    if params[:native]
        render :text => @wikipage.url, :status => 201 and return
    else 
      if @wikipage.content.nil?  
        redirect_to  "/wikis/" + @wikipage.url + "/edit"

      end
    end
    
  end
  
end
