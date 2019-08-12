Rails.application.routes.draw do
	
  get '/new', to: 'timesheets#new'
  post '/new', to: 'timesheets#create'
  root 'timesheets#index'

  resources :timesheets
end
