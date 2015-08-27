class Report < ActiveRecord::Base
	ReportList = [
		['プロジェクト別出金予定・実績一覧','payment-list', '/casein/reports/pdf_list'],
		['月別出金予定・実績','payment-monthly', '/casein/reports/pdf_monthly'],
	]

end
