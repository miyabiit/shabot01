class PaymentReport < Prawn::Document

	def initialize(payment_header)
		super(
			:page_size => 'A4', 
			:page_layout => :portrait,
			:margin => 30,
			:left_margin => 60,
			:bottom_margin => 40
		)

		@payment = payment_header
		font "vendor/fonts/ipaexg.ttf"
		stroke_axis
		
		# lines
		line_width = 0.5
		dash(1)
		stroke do
			rectangle [0, 750], 510, 750
		end

		# stamp fields
		self.line_width = 0.5
		undash
		stroke do
			horizontal_line 310, 510, :at => 750
			horizontal_line 310, 510, :at => 710
			6.times do |n|
				vertical_line 750, 710, :at => (310 + 40 * n)
			end
		end

		# tables
		self.line_width = 0.5
		undash
		stroke do
			12.times do |n|
				horizontal_line 0, 510, :at => 700 - (25 * n)
			end
		end
		self.line_width = 1
		stroke do
			horizontal_line 0, 510, :at => 500
			horizontal_line 0, 510, :at => 525
		end
		self.line_width = 0.5
		stroke do
			vertical_line 700, 425, :at => 0
			vertical_line 700, 425, :at => 70
			vertical_line 700, 425, :at => 240 
			vertical_line 700, 425, :at => 310
			vertical_line 700, 425, :at => 510
			rectangle [0,423], 510, 100
		end

		# label
		fill_color "0000ff"
		draw_text "株式会社シャロンテック", :size => 12, :at => [5,760]
		fill_color "000000"
		draw_text "支払申請書", :size => 18, :at => [5,730]
		draw_text "No.", :size => 12, :at => [5,710]

		cols = %w(個人コード 所属 勘定科目１ 勘定科目２ 勘定科目３ 勘定科目４ 勘定科目５ 支払日 振込先 事業名 予算区分)
		cols.each_with_index do |s, n|
			draw_text s, :size => 12, :at => [5,( (700 - 25 + 7) - (25 * n))]
		end
		cols = %w(申請者 支払先 金額 金額 金額 金額 金額 計 支店・口座 PROJECT 振込手数料)
		cols.each_with_index do |s, n|
			draw_text s, :size => 12, :at => [245,( (700 - 25 + 7) - (25 * n))]
		end
		draw_text '適用・目的・効果', :size => 10, :at => [5,410]
		draw_text '(証憑等添付)', :size => 10, :at => [5,310]
		#text Account.find(@payment.account_id).name
	end
end
