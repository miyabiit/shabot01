class Project < ActiveRecord::Base
  
	def self.search(search)
		if search
			Project.where(['name LIKE ?', "%#{search}%"])
		else
			Project.all
		end
	end

	def name_and_category
		self.name + ' - ' + self.category
	end
end
