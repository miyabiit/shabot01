class Item < ActiveRecord::Base

	def self.search(search)
		if search
			Item.where(['name LIKE ?', "%#{search}%"])
		else
			Item.all
		end
	end
  
end
