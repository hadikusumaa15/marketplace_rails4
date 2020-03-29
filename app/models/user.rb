class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  # validates_confirmation_of :password
  # validates :email, uniqueness: true
  # validates :email, uniqueness: true, on: :create
end
