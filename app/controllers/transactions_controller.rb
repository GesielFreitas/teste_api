class TransactionsController < ApplicationController
	include ActionController::HttpAuthentication::Token::ControllerMethods

    before_action :authenticate?

	def index
		@transactions = Transaction.where(nil)

		filtering_params(params).each do |key, value|
			@transactions = @transactions.public_send(key, value) if value.present?
		end

		render json: @transactions, status: :ok
	end
	
	# methods privates
	

	#slice of paramets of attributs of transactions
	def filtering_params(params)
		params.slice(:type_transaction, :date_time, :cpf, :value, :credit_card)
	end

	#authenticate based in token
	def authenticate?
      	authenticate_or_request_with_http_token do |token, _options|
        	decoded_token = JWT.decode token, nil, false
        	email = decoded_token[0]['email']
        	user = User.find_by(email: email)
        	unless user.nil?
          		ActiveSupport::SecurityUtils.secure_compare(
            	::Digest::SHA256.hexdigest(token),
            	::Digest::SHA256.hexdigest(user.token)
          		)
        	end
      	end
    end

end
