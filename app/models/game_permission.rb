class GamePermission < ActiveRecord::Base
    belongs_to :game
    belongs_to :user
    
    before_create :generate_api_key
    before_destroy :cant_delete_game_owner
    
    validates_uniqueness_of :user_id, :scope => :game_id
  
  
    def make_admin
      self.admin = true
      self.save
      
    end
    
    def revoke_admin
      return false if self.game.game_permissions.find_all_by_admin(true).length == 1
      self.admin = false
      self.save
    end
    
    
    private  
    def cant_delete_game_owner
      return false if self.game.owner == self.user
      return true
    end
    
    def  generate_api_key
      self.api_key = Digest::SHA1.hexdigest([Time.now, (1..10).map{ rand.to_s }, "8i3,?"].flatten.join('--'))  
      return true
    end
    
  
  
end
