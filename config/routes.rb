Rails.application.routes.draw do
  resources :artists do 
    resources :songs, only: [:index, :show]
  end 
  resources :songs
end



# 1. Create nested resource routes to show all songs for an artist (`/artists/1/songs`) and individual songs for that artist (`/artists/1/songs/1`). 
# Restrict the nested songs routes to `index` and `show` actions only.