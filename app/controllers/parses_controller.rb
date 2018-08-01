class ParsesController < ApplicationController

	def parse_transaction_cnae
		if document == 'true'
			byebug
			Parse.save_transaction_financial('public/txt/CNAB.txt')
		end
		
	end

	# recebe paramento do formulario
  	def document
    	params[:document]
  	end
end
