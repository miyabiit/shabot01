class Project < ActiveRecord::Base

	def name_and_category
		self.name + ' - ' + self.category
	end
  
end
