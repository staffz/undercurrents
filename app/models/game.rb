class Game < ActiveRecord::Base
  belongs_to :owner, :class_name => 'User'
  after_create :create_wiki_start_page
  
  has_many :wiki_pages
  
  validates_uniqueness_of :name
  
  
  
  private 
  def create_wiki_start_page
    WikiPage.create(:game => self, :url => 'index', :content => 'START PAGE FOR THE WIKKI')
  end
  
end
