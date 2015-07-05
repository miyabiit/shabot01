class PaymentHeader < ActiveRecord::Base
	has_many :payment_parts
	belongs_to :account
  
	MAX_PARTS_LENGTH = 5
	WHO_PAY = ["先方負担", "自社負担"]
	ORG_NAMES = %w(シャロンテック 聚楽荘 JAM ベルク ブルームコンサルティング その他)
	validates :comment, length: { maximum: 200 }
	validates :payment_parts, length: { maximum: MAX_PARTS_LENGTH }

	def self.search(slip_no = nil)
		if slip_no
			PaymentHeader.where(['slip_no like ?', "%#{slip_no}%"])
		else
			PaymentHeader.all
		end
	end

	def self.search_account(account_name)
		if account_name
			PaymentHeader.joins(:account).merge(Account.where(['name like ?', "%#{account_name}%"]))
		else
			PaymentHeader.all
		end
	end

	def self.onlymine(user)
		if user.is_admin?
			PaymentHeader.all
		else
			PaymentHeader.where(user_id: user.id)
		end
	end
	
	def total
		ttl = 0
		self.payment_parts.each do |part|
			ttl += part.amount.to_i
		end
		ttl
	end
end

