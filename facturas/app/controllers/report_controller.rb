class ReportController < ApplicationController

	def receptor
		receptor = params['receptor']
		puts "receptor => #{receptor}"
	end
	
end
