Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/', to: 'shelters#index'
  get '/shelters', to: 'shelters#index'
  get '/shelters/new', to: 'shelters#new'
  post '/shelters', to: 'shelters#create'
  get '/shelters/:id', to: 'shelters#show'
  get '/shelters/:id/edit', to: 'shelters#edit'
  patch '/shelters/:id', to: 'shelters#update'
  delete '/shelters/:id', to: 'shelters#destroy'

  get '/pets', to: 'pets#index'
  get '/shelters/:shelter_id/pets', to: 'shelters#pets_index'
  get '/pets/:id', to: 'pets#show'
  get '/shelters/:id/pets/new', to: 'shelter_pets#new'
  post '/shelters/:id/pets', to: 'shelter_pets#create'
  get '/pets/:id/edit', to: 'pets#edit'
  patch '/pets/:id', to: 'pets#update'
  delete '/pets/:id', to: 'pets#destroy'

  get '/shelters/:shelter_id/reviews/new', to: 'shelter_reviews#new'
  post '/shelters/:shelter_id/reviews/new', to: 'shelter_reviews#create'
  get '/shelters/:shelter_id/reviews/:review_id/edit', to: 'shelter_reviews#edit'
  patch '/shelters/:shelter_id/reviews/:review_id/edit', to: 'shelter_reviews#update'
  delete '/shelters/:shelter_id/reviews/:review_id', to: 'shelter_reviews#destroy'

  get '/favorites', to: 'favorites#index'
  patch '/favorites/:pet_id', to: 'favorites#update'
  delete '/favorites/:pet_id', to: 'favorites#destroy'
  delete '/favorites', to: 'favorites#destroy_all'

  get '/adoption_applications/new', to: 'adoption_applications#new'
  post '/adoption_applications', to: 'adoption_applications#create'
  get '/adoption_applications/:id', to: 'adoption_applications#show'

  get '/pets/:id/adoption_applications', to: 'pet_adoption_applications#index'
  # ^^ this should route to /pets/:id/pet_adoption_applications
  patch '/pets/:pet_id/pet_adoption_applications/:pet_adoption_application_id', to: 'pet_adoption_applications#update'

end
