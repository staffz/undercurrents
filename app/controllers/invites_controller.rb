class InvitesController < ApplicationController
  before_filter :login_required
  before_filter :require_game_and_access_to_game
  
  
  def new
    users   = User.find(:all)
    @users  = []
    
    # Should remove all usersr that currently is a part of the game
    users.each do |user| 
      @users.push(user.login) 
    end
    
  end
  
  def delete
    game_permission = GamePermission.find_by_id_and_game_id(params[:id], @current_game.id)
    
    if game_permission 
      game_permission.destroy   
    end
    
    redirect_to :action => :new
  end
  
  
  def make_admin
    
    if @current_game.is_admin?(@current_user)
      game_permission = GamePermission.find_by_id_and_game_id(params[:id], @current_game.id)
      game_permission.make_admin
    end    
    redirect_to :action => :new
  end

  
  def revoke_admin
    
    if @current_game.is_admin?(@current_user)
      game_permission = GamePermission.find_by_id_and_game_id(params[:id], @current_game.id)
      game_permission.revoke_admin
    end
    
    redirect_to :action => :new
  end

  
  def create 
    user = User.find_by_login(params[:invitee])
    
    @invite = GamePermission.create(:user => user, :game => @current_game, :admin => false, :accepted => false);
    
    redirect_to :action => :new
    
  end

  

end
