class PaymentList < Prawn::Document

	def initialize(payment_headers)
		super(
			:page_size => 'A4',
			:page_layout => :portrait,
			:margin => 30,
			:left_margin => 60,
			:bottom_margin => 40
		)

		@payments = payment_headers
		font Rails.root.to_s + '/' + "vendor/fonts/ipaexg.ttf"
		stroke_axis

		# 0         1           2             3                  4              5      6
		# org_name, payable_on, project.name, project.category , account.name , total, slip_no
		pays= []
		@payments.each do |payment|
			pay = []
			project = Project.find(payment.project_id)
			account = Account.find(payment.account_id)
			pay.push(payment.org_name)
			pay.push(payment.payable_on)
			pay.push(project.name)
			pay.push(project.category)
			pay.push(account.name)
			pay.push(payment.total)
			pay.push(payment.slip_no)
			pays.push(pay)
		end

		pays.sort! do |a,b|
			(a[2] <=> b[2]) || 
			(a[3] <=> b[3]) || 
			(a[4] <=> b[4]) ||
			(a[1] <=> b[1])
		end

		fontsize = 8
		list_start = 700
		line_no = 0
		line_pos = list_start

		self.line_width = 0.5
		stroke do
			horizontal_line 0, 510 , :at => line_pos
			horizontal_line 0, 510 , :at => line_pos - 10
		end
		text_box 'No'       , :size => fontsize, :at => [  0, line_pos ], :width => 15, :height => 10, :align => :center, :valign => :center
		text_box '支払日'   , :size => fontsize, :at => [ 20, line_pos ], :width => 75, :height => 10, :align => :center, :valign => :center
		text_box 'PROJECT'  , :size => fontsize, :at => [100, line_pos ], :width => 95, :height => 10, :align => :center, :valign => :center
		text_box ' '        , :size => fontsize, :at => [200, line_pos ], :width => 45, :height => 10, :align => :center, :valign => :center
		text_box '取引先'   , :size => fontsize, :at => [250, line_pos ], :width => 95, :height => 10, :align => :center, :valign => :center
		text_box '金額'     , :size => fontsize, :at => [350, line_pos ], :width => 95, :height => 10, :align => :center, :valign => :center
		text_box '伝票番号' , :size => fontsize, :at => [450, line_pos ], :width => 45, :height => 10, :align => :center, :valign => :center

		last_project = ''
		total_amount = 0
		short_amount = 0
		pays.each do |pay|
			line_no += 1
			line_pos -= 10
			if line_no > 1 && (pay[2] != last_project)
				text_box short_amount.to_s(:delimited) , :size => fontsize, :at => [350, line_pos ], :width => 95, :height => 10, :align => :right, :valign => :center
				stroke do
					horizontal_line 0, 510 , :at => line_pos
				end
				line_pos -= 20
				short_amount = 0
			end
			text_box line_no.to_s , :size => fontsize, :at => [  0, line_pos ], :width => 15, :height => 10, :align => :left, :valign => :center
			text_box pay[1].to_s  , :size => fontsize, :at => [ 20, line_pos ], :width => 75, :height => 10, :align => :left, :valign => :center
			text_box pay[2].to_s  , :size => fontsize, :at => [100, line_pos ], :width => 95, :height => 10, :align => :left, :valign => :center
			text_box pay[3].to_s  , :size => fontsize, :at => [200, line_pos ], :width => 45, :height => 10, :align => :left, :valign => :center
			text_box pay[4][0,10] , :size => fontsize, :at => [250, line_pos ], :width => 95, :height => 10, :align => :left, :valign => :center
			text_box pay[5].to_s(:delimited) , :size => fontsize, :at => [350, line_pos ], :width => 95, :height => 10, :align => :right, :valign => :center
			text_box pay[6].to_s  , :size => fontsize, :at => [450, line_pos ], :width => 95, :height => 10, :align => :left, :valign => :center
			last_project = pay[2]
			total_amount += pay[5].to_i
			short_amount += pay[5].to_i
		end
		# last short amount
		line_pos -= 10
		text_box short_amount.to_s(:delimited) , :size => fontsize, :at => [350, line_pos ], :width => 95, :height => 10, :align => :right, :valign => :center
		stroke do
			horizontal_line 0, 510 , :at => line_pos
		end
		# total amount
		line_pos -= 20
		text_box total_amount.to_s(:delimited) , :size => fontsize, :at => [350, line_pos ], :width => 95, :height => 10, :align => :right, :valign => :center
		stroke do
			horizontal_line 0, 510 , :at => line_pos
		end
	end
end
