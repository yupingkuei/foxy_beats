class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :lockable, :confirmable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :vinyls
  has_many :rentals
  has_many :rentals_as_owner, through: :vinyls, source: :rentals
end
