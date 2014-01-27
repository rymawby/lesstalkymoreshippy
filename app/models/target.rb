class Target < ActiveRecord::Base

	belongs_to :project

	def validate(user)
		if user.has_role? :validator
			self.complete = true
		end
	end
end
