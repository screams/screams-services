class AuthenticationToken < ActiveRecord::Base

  validates_uniqueness_of :token

  belongs_to :user
end
