class Target < ActiveRecord::Base

	def validate
		if self.has_role? :validator
			self.complete = true
		end
	end

end
