class ReportController < ApplicationController

	def receptor
		@rfc_receptor = params['receptor']
		@receipts = [ 
			{ 'emisor' => 'BBB020305RRR','receptor' => @rfc_receptor, 'total' => 1020.45},
			{ 'emisor' => 'TTT090817DEW','receptor' => @rfc_receptor, 'total' => 89000.17},
			{ 'emisor' => 'ZXC070801WWW','receptor' => @rfc_receptor, 'total' => 98211.45}
 		]
		puts "receptor => #{@rfc_receptor}"
	end

end
