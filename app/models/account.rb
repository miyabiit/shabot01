class Account < ActiveRecord::Base
  
	validates :name, length: { maximum: 30 }
	validates :bank, length: { maximum: 30 }
	validates :bank_branch, length: { maximum: 30 }
	validates :category, length: { maximum: 10 }
	validates :ac_no, length: { maximum: 20 }

	def self.search(search)
		if search
			Account.where(['name LIKE ?', "%#{search}%"])
		else
			Account.all
		end
	end
end
