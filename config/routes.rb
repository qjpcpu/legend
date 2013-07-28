Legend::Application.routes.draw do
  scope '(:locale)' do
    root :to => 'welcome#index'

    controller :crumb_sorter do
      get "crumbs-sorter/index"=>:index, as:"crumbs_sorter"
      post "crumbs-sorter/sort"=>:sort, as:"sort_crumbs_sorter"
    end

    devise_for :users

    resources :stories do
      member do
        get "writers"=>:writers
        post "writers"=>:update_writers
      end
      resources :events
    end

    resources :events,:only=>:none do 
      resources :crumbs,only: [:edit,:update,:destroy] do 
        collection do 
          get 'upload'
          post 'upload',:to=>:upload_one
        end
      end
    end

    get "/paperclip/:class/:attachment/:id/:style/:filename",to:"assets#show"

    get "welcome/index"
  end
end
