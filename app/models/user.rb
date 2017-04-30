class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :eating_or_drinkings
  has_many :products
  has_many :reviews

  enum status: { normal: 0, admin: 1}
end
