class UsersController < ApplicationController

  	def create

    	@api_user = User.new(api_user_params)
    	@api_user = create_token_params(api_user_params, @api_user)
      
    	if @api_user.save
      	render json: {token: @api_user.token}, status: :ok
    	else
        if @api_user.errors.messages[:email].empty? == false && @api_user.errors.messages[:name].empty? == false
          render json: {error_email: @api_user.errors.messages[:email], error_name: @api_user.errors.messages[:name]}
        elsif @api_user.errors.messages[:email].empty? == false
          render json: {error_email: @api_user.errors.messages[:email]}
        elsif @api_user.errors.messages[:name].empty? == false      
          render json: {error_name: @api_user.errors.messages[:name]}   
        end
    	end
  	end

  	def update

    	@api_user = User.find_by email: params[:email]
    	@api_user = create_token_params(api_user_params, @api_user)
    	if @api_user.update_attributes(name: api_user_params[:name],
                                   email: api_user_params[:email],
                                   secret: @api_user.secret,
                                   token: @api_user.token)
      		render json: { success: 'Usuário de API atualizado com sucesso', token: @api_user.token}, status: :ok
    	else
      		render json: {error: 'Usuário de API não pode ser atualizado'}
    	end
  	end

  	def show
  		@api_user = User.find_by email: params[:email]

    	render json: {token: @api_user.token}, status: :ok
  	end

  	private

  	def api_user_params
    	params[:user].permit(:name, :email)
  	end

  	def create_token_params(api_user_params, api_user)
    	random_string = (0..7).map { ('a'..'z').to_a[rand(26)] }.join
    	api_user.secret = BCrypt::Password.create(random_string)
    	payload = { name: api_user_params[:name], email: api_user_params[:email] }
    	api_user.token = JWT.encode payload, api_user.secret, 'HS256'
    	api_user
  	end
end
