class Account < ActiveRecord::Base
  
	def self.search(search)
		if search
			Account.where(['name LIKE ?', "%#{search}%"])
		else
			Account.all
		end
	end
end
