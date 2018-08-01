require 'rails_helper'

RSpec.describe UsersController, type: :controller do
	describe 'Users controllers methods' do

		before(:each) do

			TOKEN ||= "eyJhbGciOiJIUzI1NiJ9.eyJuYW1lIjoiY2FybG9zIHNhbnRvcyIsImVtYWlsIjoiY2FybG9zLnNhbnRvc0Bob3RtYWlsLmNvbSJ9.UXEQOe5bgtIxkEaa9jokxPdRdeDXGNyQ_hx-TECN5o0"
			SECRET ||= '$2a$10$L0NCBIw2d.yCXW7H7OD1iurGX4ZzfvzCbtnKH/Qg1GUo.X0eBFRmO'
			@user_api = User.create(name: "carlos santos", email: "carlos.santos@hotmail.com", token: TOKEN, secret: SECRET)
		end

		it 'should create user for api' do
			
			get :create, params: {user: {name: "Saulo Santiago", email: "saulo.santiago@gmail.com"}, default: { format: :json } }
			expect(response).to have_http_status(200)
			expect(User.count).to be(2)
			
		end

		it 'should create user for api error' do
			
			get :create, params: {user: {name: "carlos santos", email: "carlos.santos@hotmail.com"}, default: { format: :json } }
			expect(response).to have_http_status(200)
			expect(JSON.parse(response.body)) == 'E-mail já cadastrado no sistema'.to_json
		end

		it 'should create user for api error name minimum' do
			
			get :create, params: {user: {name: "carlos eduardo andrade dos santos de sousa melo sousa", email: "carlos@hotmail.com"}, default: { format: :json } }
			expect(response).to have_http_status(200)
			expect(JSON.parse(response.body)) == 'O Nome deve ter no mínimo 4 caracteres'.to_json
		end

		it 'should create user for api error name maximum' do
			
			get :create, params: {user: {name: "ca", email: "carlos@hotmail.com"}, default: { format: :json } }
			expect(response).to have_http_status(200)
			expect(JSON.parse(response.body)) == 'O Nome deve ter no mínimo 4 caracteres'.to_json
		end

		it 'should create user for api error name with number' do
			
			get :create, params: {user: {name: "carlos123", email: "carlos@hotmail.com"}, default: { format: :json } }
			expect(response).to have_http_status(200)
			expect(JSON.parse(response.body)) == 'O campo Nome só pode conter letras'.to_json
		end

		it 'should create user for api error email error in format' do
			
			get :create, params: {user: {name: "carlos eduardo", email: "carloshotmail.com"}, default: { format: :json } }
			expect(response).to have_http_status(200)
			expect(JSON.parse(response.body)) == 'Insira um E-mail válido'.to_json
		end

		it 'should create user for api error email error in minimum' do
			
			get :create, params: {user: {name: "carlos eduardo", email: "ca@gmail.com"}, default: { format: :json } }
			expect(response).to have_http_status(200)
			expect(JSON.parse(response.body)) == 'O E-mail deve ter no mínimo 13 caracteres'.to_json
		end

		it 'should create user for api error email error in maximum' do
			
			get :create, params: {user: {name: "carlos eduardo", email: "carlos.eduardo.santos.sousa.feliciano.nascimento.andrade.melo@gmail.com"}, default: { format: :json } }
			expect(response).to have_http_status(200)
			expect(JSON.parse(response.body)) == 'O E-mail deve ter no máximo 60 caracteres'.to_json
		end

		it 'should show user for api' do

			get :show, params: {email: "carlos.santos@hotmail.com", default: { format: :json }}
			expect(response).to have_http_status(200)
			expect(JSON.parse(response.body).fetch("token")).to eql(@user_api.token)
		end

		it 'should edit user for api' do

			get :update, params: {email:"carlos.santos@hotmail.com", user: {name: "carlos eduardo", email: "carlos.santos@hotmail.com"}, default: { format: :json }}
			expect(response).to have_http_status(200)
			expect(JSON.parse(response.body).fetch("success")).to eql("Usuário de API atualizado com sucesso")
		end
	end
end