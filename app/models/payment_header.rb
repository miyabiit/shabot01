class PaymentHeader < ActiveRecord::Base
	has_many :payment_parts
  
	MAX_PARTS_LENGTH = 5
	WHO_PAY = ["先方負担", "自社負担"]
	ORG_NAMES = %w(シャロンテック 聚楽荘 JAM ベルク ブルームコンサルティング その他)
	validates :comment, length: { maximum: 200 }
	validates :payment_parts, length: { maximum: MAX_PARTS_LENGTH }

	def total
		ttl = 0
		self.payment_parts.each do |part|
			ttl += part.amount
		end
		ttl
	end
end

