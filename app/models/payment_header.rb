class PaymentHeader < ActiveRecord::Base
	has_many :payment_parts
  
end
