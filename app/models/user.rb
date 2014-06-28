class User < ActiveRecord::Base
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :email,
            :format => { 
              :with => /\A[a-zA-Z0-9][A-Z0-9._+a-z\+\-]*@(?:[A-Z0-9a-z\-]+\.)+[A-Za-z]{2,4}\z/
            },
            :presence => true,
            :uniqueness => true


  def authentication_token
    "12323342543252435425"  
  end

end
