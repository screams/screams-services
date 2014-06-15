class User < ActiveRecord::Base

  validates :email,
            :format => { :with => /\A[a-zA-Z0-9][A-Z0-9._+a-z\+\-]*@(?:[A-Z0-9a-z\-]+\.)+[A-Za-z]{2,4}\z/ },
            :presence => true,
            :uniqueness => true
end
