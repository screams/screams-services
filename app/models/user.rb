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

  has_many :screams
  has_many :authentication_tokens

  def self.find_by_encrytped_authentication_token(encrypted_token)
    raw_token = Devise.token_generator.digest(AuthenticationToken, :token, encrypted_token)
    authentication_token = AuthenticationToken.find_by_token(raw_token)
    authentication_token.try(:user)
  end

  def generate_authentication_token
    # We are using a devise method for generating unique token.
    #   Refer to devise source code to understand more.
    raw, enc = Devise.token_generator.generate(AuthenticationToken, :token)
    authentication_token = AuthenticationToken.create({
      :token => enc,
      :generated_at => Time.now.utc,
      :user_id => id
    })
    raw
  end

  def encrypted_authentication_token
    generate_authentication_token
  end

end
