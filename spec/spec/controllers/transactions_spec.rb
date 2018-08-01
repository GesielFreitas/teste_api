require 'rails_helper'

RSpec.describe TransactionsController, type: :controller do
	describe 'transactions index method' do

		before(:each) do
			
			SECRET ||= '$2a$10$reXHMgegkckEKlceQ.0S5u/L44tbhU46C8TCdSn8HOePlEvnGYTI.'
			TOKEN ||= 'eyJhbGciOiJIUzI1NiJ9.eyJuYW1lIjoiZ2VzaWVsIGZyZWl0YXMiLCJlbWFpbCI6Imdlc2llbC53YXMuZkBnbWFpbC5jb20ifQ.ju_4I9LygKnY_8RxJvkAYqPgZ0CTjf5dDX1QSNy18rs'
			TOKEN_2 ||= 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJuYW1lIjoiR3VzdGF2byBGcmVpcmUgT2xpdmVpcmEiLCJlbWFpbCI6ImZyZWlyZS5vbGl2ZWlyYUBob3RtYWlsLmNvbSJ9.vNfwaSxpdVosGsnaS06JWt9NtMoAkOqwnjWcIAnFCy4'
			@api_user = User.create(name: 'gesiel freitas', email: 'gesiel.was.f@gmail.com', secret: SECRET, token: TOKEN)
			@transaction = Transaction.create(type_transaction: 1, date_time: "1970-08-22 04:00:02", value: 1200, cpf: "67196213009", credit_card: "1234****3324")
			@transaction_2 = Transaction.create(type_transaction: 4, date_time: "1970-08-22 06:46:40", value: 991, cpf: "04056147647", credit_card: "1234****2231")

			@request.env['HTTP_ACCEPT'] = 'application/vnd.api+json'
			@request.env['HTTP_AUTHORIZATION'] = 'Token ' + TOKEN
		end

		it 'should return the all rooms json' do
			
			get :index, params: { default: { format: :json } }
			#byebug
			expect(response).to have_http_status(200)
			#expect(JSON.parse(response.body)) == @room.to_json
		end
	
		it 'request index and return 401 not authorization' do
			@request.env['HTTP_AUTHORIZATION'] = 'Token ' + TOKEN_2
			get :index
			expect(response).to have_http_status(401)
		end

		it 'request index and return 200 ok whith params' do
			get :index, params:{ value: 120, default: { format: :json }}
			expect(response).to have_http_status(200)
		end

		it 'request index whith params for return json' do
			get :index, params:{ value: 120, default: { format: :json }}
			expect(JSON.parse(response.body)) == @transaction.to_json
		end

		it 'request index and return 200 ok whith params value and credit_card' do
			get :index, params:{ value: 120, credit_card:"1234****2231",  default: { format: :json }}
			expect(response).to have_http_status(200)
		end

		it 'request index whith params value and credit_card for return json' do
			get :index, params:{ value: 120, credit_card:"1234****2231", default: { format: :json }}
			expect(JSON.parse(response.body)) == @transaction.to_json
		end

		it 'request index and return 200 ok whith params value, credit_card and cpf' do
			get :index, params:{ value: 120, credit_card:"1234****2231", cpf: "04056147647",  default: { format: :json }}
			expect(response).to have_http_status(200)
		end

		it 'request index whith params value, credit_card and cpf for return json' do
			get :index, params:{ value: 120, credit_card:"1234****2231", cpf: "04056147647", default: { format: :json }}
			response_expect = [@transaction, @transaction_2]
			expect(JSON.parse(response.body)) == response_expect.to_json
		end

		it 'request index and return 200 ok whith params value, credit_card, cpf and date_time' do
			get :index, params:{ value: 120, credit_card:"1234****2231", cpf: "04056147647", date_time: "1970-08-22 04:00:02",  default: { format: :json }}
			expect(response).to have_http_status(200)
		end

		it 'request index whith params value, credit_card, cpf and date_time for return json' do
			get :index, params:{ value: 120, credit_card:"1234****2231", cpf: "04056147647", date_time: "1970-08-22 04:00:02", default: { format: :json }}
			response_expect = [@transaction, @transaction_2]
			expect(JSON.parse(response.body)) == response_expect.to_json
		end
	end
end