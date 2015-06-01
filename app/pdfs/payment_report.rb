class PaymentReport < Prawn::Document

	def initialize(payment_header)
		super()

		@payment = payment_header
		font "vendor/fonts/ipaexg.ttf"

		text "支払申請書", size: 28
		text Account.find(@payment.account_id).name
	end
end
