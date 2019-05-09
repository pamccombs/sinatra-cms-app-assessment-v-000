class User < ActiveRecord::Base
  
  #validates_presence_of :username, :email
	  #validates :username, uniqueness:  { message: "Sorry, that username is already taken" }
	  #validates :email, uniqueness: { message: "That email already has an account, did you mean to login?" }
	
  has_many :lipsticks
  
  has_secure_password
  
  

  def slug
    self.username.gsub(" ", "-")
  end

  def self.find_by_slug(slug)
    User.all.find{|user| user.slug == slug}
  end
  

end