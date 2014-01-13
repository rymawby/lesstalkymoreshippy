class User < ActiveRecord::Base
  
  has_many :projects, foreign_key: 'creator_id'
  has_many :projects, foreign_key: 'validator_id'
  has_many :targets, through: :projects

  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end
