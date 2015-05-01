class PaymentPart < ActiveRecord::Base
	belongs_to :payment_header
  
end
