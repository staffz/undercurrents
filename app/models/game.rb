class Game < ActiveRecord::Base
  before_create :generate_api_key
  after_create :create_wiki_start_page, :create_admin_record # :create_admin_record
  
  belongs_to :owner, :class_name => 'User'
  has_many :wiki_pages
  has_many :game_permissions
  
  validates :domain, :presence => true, 
                      :length => {:minimum => 3, :maximum => 254},
                      :uniqueness => true,
                      :format => {:with => /^[^@\s]+$/i}

  validates :name, :presence => true,
                    :uniqueness => true



  def is_owner?(user)
    if self.owner == user
      return true
    end
    return false
  end
  

  def is_admin?(user)
    if self.game_permissions.find_by_user_id_and_admin(user.id, true) 
      return true
    end
    
    return false
  end

  
  def has_access?(user)
    if self.game_permissions.find_by_user_id(user.id) || self.owner == user
      return true
    end
    
    return false
  end
  
  
  private 
  
  def create_wiki_start_page
    WikiPage.create(:game => self, :url => 'index', :content => 'START PAGE FOR THE WIKKI')
    return true
  end
  
  def create_admin_record
    GamePermission.create(:game => self, :user => self.owner, :admin => true, :accepted => true)
    return true
  end
  
  def  generate_api_key
    self.api_key = Digest::SHA1.hexdigest([Time.now, (1..10).map{ rand.to_s }, "8i3,?"].flatten.join('--'))  
    
    return true
  end
  
  
  
end
