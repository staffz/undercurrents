class WikiPage < ActiveRecord::Base
  belongs_to :game
  
  # acts_as_versioned

  def content_with_links
    
    return "" unless self.content 
    self.content.gsub(/\[\[(\w+?)\]\]/) do |m|
      "<a href='http://#{self.game.domain}.#{configatron.base_url}/wikis/#{$~[1]}'>#{$~[1]}</a>" 
    end
    
  end
  
  
  def content_with_links_for_ipad
    return "" unless self.content 
    self.content.gsub(/\[\[(\w+?)\]\]/) do |m|
      "<a href='wiki://#{self.game.domain}.#{configatron.base_url}/wikis/#{$~[1]}'>#{$~[1]}</a>" 
    end
    
  end

end
