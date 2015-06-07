class PaymentReport < Prawn::Document

	def initialize(payment_header)
		super(
			:page_size => 'A4', 
			:page_layout => :portrait,
			:margin => 30
		)

		@payment = payment_header
		font "vendor/fonts/ipaexg.ttf"
		stroke_axis
		
		text "支払申請書", size: 28
		text Account.find(@payment.account_id).name
	end
end
