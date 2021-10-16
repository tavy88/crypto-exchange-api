Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  get 'currencies', to: 'currencies#tickers'
  get 'convert', to: 'currencies#convert'
end
