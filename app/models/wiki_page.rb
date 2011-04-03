class WikiPage < ActiveRecord::Base
  belongs_to :game
  
  # acts_as_versioned

end
