class Report < ActiveRecord::Base
	ReportList = [
		['プロジェクト別費目別出金・実績一覧','payment-list', '/casein/reports/pdf_list'],
		['月別出金・実績','payment-monthly', '/casein/reports/reports/pd_monthly'],
	]

end
