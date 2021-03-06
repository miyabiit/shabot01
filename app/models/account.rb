class Account < ActiveRecord::Base
	has_many :payment_headers
  
	validates :name, uniqueness: true
	validates :name, length: { maximum: 30 }
	validates :bank, length: { maximum: 30 }
	validates :bank_branch, length: { maximum: 30 }
	validates :category, length: { maximum: 10 }
	validates :ac_no, length: { maximum: 20 }

	CAT_NAMES =%w(普通 当座 ー)

	def self.search(search)
		if search
			Account.where(['name LIKE ?', "%#{search}%"])
		else
			Account.all
		end
	end
end
