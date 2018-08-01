require 'rails_helper'

RSpec.describe ParsesController, type: :controller do
	describe 'parses controllers methods' do

		it 'should save data of parse in databases' do
			
			post :parse_transaction_cnae, params: {document: "true", default: { format: :json } }
			expect(response).to have_http_status(204)
			expect(Transaction.count).to be(4)
			
		end

		it 'should save data error in databases' do
			
			post :parse_transaction_cnae, params: {document: "false", default: { format: :json } }
			expect(response).to have_http_status(204)
			expect(Transaction.count).to be(0)
		end

	end
end