Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  post 'parses/carregar' => 'parses#parse_transaction_cnae', as: 'parses_carregar'


  get 'transactions' => 'transactions#index', as: 'transactions_all'
  
  post 'api_users/create' => 'users#create', as: 'api_users_create'
  get 'api_users/show/' => 'users#show', as: 'api_users_show'
  put 'api_users/update/' => 'users#update', as: 'api_users_update'

end

