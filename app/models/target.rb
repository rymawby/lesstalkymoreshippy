class Target < ActiveRecord::Base

	def validate(user)
		if user.has_role? :validator
			self.complete = true
		end
	end

end
