Storeitsquirrel::Application.routes.draw do
# Administration
  namespace :admin do

# Banned users
    resources :banned_users

# Withdrawings
    resources :withdrawings

# Withdrawal methods
    resources :withdrawal_methods

# PayPal import
    resources :paypal_imports

# Broadcast messages
    resources :broadcasts

# City SEOs
    resources :city_seos

# City currencies
    resources :currencies

# Content management
    get 'tags/:tag',            to: 'contents#index',   as: :tag
    get 'tags/:tag/:id/edit',   to: 'contents#edit',    as: :tagged_edit
    put 'tags/:tag/:id',        to: 'contents#update',  as: :tagged_update
    resources :contents

# Users
    resources :users
    match "users/hostings/:id", to: "users#hostings",   as: "user_hostings"
    match "users/requests/:id", to: "users#requests",   as: "user_requests"
    match "quick_info",         to: "quick_info#index", as: "quick_info"
  end

# Front-end API
  namespace :api do
    resources :spaces
    resources :storage_requests
    resources :sessions, :only => [:create, :destroy]
    resources :listings
    resources :public_profiles, :only => :show
    get 'listings/:source_site/last_id', to: 'listings#last_id',      as: :last_id
    put 'listings/:id/change_owner',     to: 'listings#change_owner', as: :change_owner
  end

# Feedbacks
  resources :feedbacks

# Custom requests
  resources :custom_requests

# Visitor contacts
  resources :contacts

# Size calculation helper
  get "size_calcs/show", to: "size_calcs#show", as: "show_size_calc"

# Transaction history report
  get "transaction_histories/index", as: "transaction_histories"

# Withdrawings
  resources :withdrawings

# Withdrawal methods
  resources :withdrawal_methods

# Notifications
  get "notifications/list_active", to: "notifications#list_active", as: "list_active_notifications"
  resources :notifications, :only => [:index, :destroy]

# Pusher authentication
  post "pusher/auth", to: "pusher#auth", as: "auth_pusher"

# SMS service
  get  "sms/receive", to: "sms#receive", as: "receive_sms"
  get  "sms/receipt", to: "sms#receipt", as: "receipt_sms"
  get  "sms/token",   to: "sms#token",   as: "token_sms"
  post "sms/confirm", to: "sms#confirm", as: "confirm_sms"

# Dashboard
  resources :dashboards

# Email validation
  match "emails/:user_id/validate/:token", to: "emails#validate",            as: "validate_email"
  match "emails/resend_verification",      to: "emails#resend_verification", as: "resend_verification"

# Storage request photo
  resources :storage_request_photos

# Space hosting
  match "spaces/search",        to: "spaces#search",     as: "search"
  match "spaces/publish/:id",   to: "spaces#publish",    as: "publish"
  match "spaces/unpublish/:id", to: "spaces#unpublish",  as: "unpublish"
  match "spaces/trash/:id",     to: "spaces#trash",      as: "trash"
  match "spaces/myhostings",    to: "spaces#myhostings", as: "myhostings"
  match "spaces/myrequests",    to: "spaces#myrequests", as: "myrequests"
  match 'spaces/change_owner/:id', to: 'spaces#change_owner', as: "space_change_owner"
  resources :spaces do

# Storage request
    resources :storage_requests do
      resources :host_receipts
      resources :requester_receipts
    end

# Booking 
    resources :bookings
    resources :storage_item_logs

# Hosting
    resources :hostings

# Space photos
    resources :space_photos

  end # Space listing

# Request negotiation
  match "storage_requests/:id/details",          to: "storage_requests#details",               as: "details_storage_request"
  match "storage_requests/:id/allow_booking",    to: "storage_requests#allow_booking",         as: "allow_booking_storage_request"
  match "storage_requests/:id/decline_rental",   to: "storage_requests#decline_rental",        as: "decline_rental_storage_request"
  match "storage_requests/:id/delete_booking",   to: "storage_requests#delete_direct_booking", as: "delete_booking_storage_request"
  match "storage_requests/:id/archive",          to: "storage_requests#archive",               as: "archive_storage_request"

  match "storage_requests/:id/request_messages", to: "request_messages#create",  as: "storage_request_request_messages"

# Default settings
  resources :settings

# User profile
  resources :profiles
  match "profile_photo", to: "profiles#photo", as: "profile_photo"

# User authentication
  get  "logout"   => "sessions#destroy",                as: "logout"
  get  "login"    => "sessions#new",                    as: "login"
  get  "forgot"   => "sessions#forgot",                 as: "forgot"
  post "reset_password" => "sessions#reset_password",   as: "reset_password"
  get  "signup"   => "users#new",                       as: "signup"
  put  "internal_users/:id" => "users#update",          as: "internal_user"
  put  "internal_users/upgrade/:id" => "users#upgrade_to_fb", as: "upgrade_internal_user"
  put  "fb_users/:id"       => "users#update",          as: "fb_user"
  post "internal_users"     => "users#create",          as: "internal_users"
 
  get  "users/fb_survey",        to: "users#fb_survey", as: "fb_survey_user"
  post "users/submit_fb_survey", to: "users#submit_fb_survey", as: "submit_fb_survey_user"

  resources :users
  resources :sessions, :only => [:create, :destroy]

# Facebook authentication
  match "auth/:provider/callback", to: "sessions#fb_create"
  match "auth/failure",            to:  redirect('/login')

# Application root
  root to: "pages#home"

# Static pages
  match 'pages/:action',           to: "pages"

# Shortcuts for cities
  match ':id/self-storage',        to: "cities#search"
end
