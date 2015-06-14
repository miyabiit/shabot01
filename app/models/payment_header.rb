class PaymentHeader < ActiveRecord::Base
	has_many :payment_parts
  
	WHO_PAY = ["先方負担", "自社負担"]
	ORG_NAMES = %w(シャロンテック 聚楽荘 その他)
end
