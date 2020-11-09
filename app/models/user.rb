class User < ApplicationRecord

  # Include default devise modules. Others available are:
  # :lockable, :confirmable, :timeoutable, :trackable and :omniauthable
  has_many :vinyls
  has_many :rentals
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
