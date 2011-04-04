class InvitesController < ApplicationController

  def index
    users   = Users.find(:all)
    @users  = []
    
    users.each { |user| @users.push(user.login) }
    
  end
  
  

  

end
