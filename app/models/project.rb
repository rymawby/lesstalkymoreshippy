class Project < ActiveRecord::Base

	belongs_to :validator, :class_name => 'User', :foreign_key => 'validator_id'
	belongs_to :creator, :class_name => 'User', :foreign_key => 'creator_id'
	has_many :targets, dependent: :destroy
	accepts_nested_attributes_for :targets, allow_destroy: true
	

end
