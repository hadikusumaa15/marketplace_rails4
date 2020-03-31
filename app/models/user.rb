class User < ActiveRecord::Base
  before_create :generate_authentication_token!
  has_many :products, dependent: :destroy
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  validates :auth_token, uniqueness: true
  # validates_confirmation_of :password
  # validates :email, uniqueness: true
  # validates :email, uniqueness: true, on: :create

  # auth token digenerate sebelum create user
  def generate_authentication_token!
    begin
      self.auth_token = Devise.friendly_token
    end while self.class.exists?(auth_token: auth_token)
  end
end
