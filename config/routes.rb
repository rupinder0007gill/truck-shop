# frozen_string_literal: true

# == Route Map
#
#                                   Prefix Verb   URI Pattern                                                                                       Controller#Action
#                     new_customer_session GET    /customers/sign_in(.:format)                                                                      devise/sessions#new
#                         customer_session POST   /customers/sign_in(.:format)                                                                      devise/sessions#create
#                 destroy_customer_session DELETE /customers/sign_out(.:format)                                                                     devise/sessions#destroy
#                    new_customer_password GET    /customers/password/new(.:format)                                                                 devise/passwords#new
#                   edit_customer_password GET    /customers/password/edit(.:format)                                                                devise/passwords#edit
#                        customer_password PATCH  /customers/password(.:format)                                                                     devise/passwords#update
#                                          PUT    /customers/password(.:format)                                                                     devise/passwords#update
#                                          POST   /customers/password(.:format)                                                                     devise/passwords#create
#                      new_customer_unlock GET    /customers/unlock/new(.:format)                                                                   devise/unlocks#new
#                          customer_unlock GET    /customers/unlock(.:format)                                                                       devise/unlocks#show
#                                          POST   /customers/unlock(.:format)                                                                       devise/unlocks#create
#               accept_customer_invitation GET    /customers/invitation/accept(.:format)                                                            devise/invitations#edit
#               remove_customer_invitation GET    /customers/invitation/remove(.:format)                                                            devise/invitations#destroy
#                  new_customer_invitation GET    /customers/invitation/new(.:format)                                                               devise/invitations#new
#                      customer_invitation PATCH  /customers/invitation(.:format)                                                                   devise/invitations#update
#                                          PUT    /customers/invitation(.:format)                                                                   devise/invitations#update
#                                          POST   /customers/invitation(.:format)                                                                   devise/invitations#create
#                         new_user_session GET    /users/sign_in(.:format)                                                                          users/sessions#new
#                             user_session POST   /users/sign_in(.:format)                                                                          users/sessions#create
#                     destroy_user_session DELETE /users/sign_out(.:format)                                                                         users/sessions#destroy
#                        new_user_password GET    /users/password/new(.:format)                                                                     users/passwords#new
#                       edit_user_password GET    /users/password/edit(.:format)                                                                    users/passwords#edit
#                            user_password PATCH  /users/password(.:format)                                                                         users/passwords#update
#                                          PUT    /users/password(.:format)                                                                         users/passwords#update
#                                          POST   /users/password(.:format)                                                                         users/passwords#create
#                          new_user_unlock GET    /users/unlock/new(.:format)                                                                       users/unlocks#new
#                              user_unlock GET    /users/unlock(.:format)                                                                           users/unlocks#show
#                                          POST   /users/unlock(.:format)                                                                           users/unlocks#create
#                   accept_user_invitation GET    /users/invitation/accept(.:format)                                                                devise/invitations#edit
#                   remove_user_invitation GET    /users/invitation/remove(.:format)                                                                devise/invitations#destroy
#                      new_user_invitation GET    /users/invitation/new(.:format)                                                                   devise/invitations#new
#                          user_invitation PATCH  /users/invitation(.:format)                                                                       devise/invitations#update
#                                          PUT    /users/invitation(.:format)                                                                       devise/invitations#update
#                                          POST   /users/invitation(.:format)                                                                       devise/invitations#create
#                       rails_health_check GET    /up(.:format)                                                                                     rails/health#show
#                                     root GET    /                                                                                                 home#index
#                       paid_users_invoice GET    /users/invoices/:id/paid(.:format)                                                                users/invoices#paid
#           search_customer_users_invoices GET    /users/invoices/search_customer(.:format)                                                         users/invoices#search_customer
#   find_or_create_customer_users_invoices GET    /users/invoices/find_or_create_customer(.:format)                                                 users/invoices#find_or_create_customer
#            search_vehicle_users_invoices GET    /users/invoices/search_vehicle(.:format)                                                          users/invoices#search_vehicle
#    find_or_create_vehicle_users_invoices GET    /users/invoices/find_or_create_vehicle(.:format)                                                  users/invoices#find_or_create_vehicle
#                           users_invoices GET    /users/invoices(.:format)                                                                         users/invoices#index
#                                          POST   /users/invoices(.:format)                                                                         users/invoices#create
#                        new_users_invoice GET    /users/invoices/new(.:format)                                                                     users/invoices#new
#                       edit_users_invoice GET    /users/invoices/:id/edit(.:format)                                                                users/invoices#edit
#                            users_invoice GET    /users/invoices/:id(.:format)                                                                     users/invoices#show
#                                          PATCH  /users/invoices/:id(.:format)                                                                     users/invoices#update
#                                          PUT    /users/invoices/:id(.:format)                                                                     users/invoices#update
#                                          DELETE /users/invoices/:id(.:format)                                                                     users/invoices#destroy
#                           users_products GET    /users/products(.:format)                                                                         users/products#index
#                                          POST   /users/products(.:format)                                                                         users/products#create
#                        new_users_product GET    /users/products/new(.:format)                                                                     users/products#new
#                       edit_users_product GET    /users/products/:id/edit(.:format)                                                                users/products#edit
#                            users_product GET    /users/products/:id(.:format)                                                                     users/products#show
#                                          PATCH  /users/products/:id(.:format)                                                                     users/products#update
#                                          PUT    /users/products/:id(.:format)                                                                     users/products#update
#                                          DELETE /users/products/:id(.:format)                                                                     users/products#destroy
#                   enable_user_users_user POST   /users/users/:id/enable_user(.:format)                                                            users/users#enable_user
#                              users_users GET    /users/users(.:format)                                                                            users/users#index
#                                          POST   /users/users(.:format)                                                                            users/users#create
#                           new_users_user GET    /users/users/new(.:format)                                                                        users/users#new
#                          edit_users_user GET    /users/users/:id/edit(.:format)                                                                   users/users#edit
#                               users_user GET    /users/users/:id(.:format)                                                                        users/users#show
#                                          PATCH  /users/users/:id(.:format)                                                                        users/users#update
#                                          PUT    /users/users/:id(.:format)                                                                        users/users#update
#                                          DELETE /users/users/:id(.:format)                                                                        users/users#destroy
#                      users_notifications GET    /users/notifications(.:format)                                                                    users/notifications#index
#                       users_notification GET    /users/notifications/:id(.:format)                                                                users/notifications#show
#                                          DELETE /users/notifications/:id(.:format)                                                                users/notifications#destroy
#                        clients_customers GET    /clients/customers(.:format)                                                                      clients/customers#index
#                                          POST   /clients/customers(.:format)                                                                      clients/customers#create
#                     new_clients_customer GET    /clients/customers/new(.:format)                                                                  clients/customers#new
#                    edit_clients_customer GET    /clients/customers/:id/edit(.:format)                                                             clients/customers#edit
#                         clients_customer GET    /clients/customers/:id(.:format)                                                                  clients/customers#show
#                                          PATCH  /clients/customers/:id(.:format)                                                                  clients/customers#update
#                                          PUT    /clients/customers/:id(.:format)                                                                  clients/customers#update
#                                          DELETE /clients/customers/:id(.:format)                                                                  clients/customers#destroy
#                     analytics_home_index GET    /home/analytics(.:format)                                                                         home#analytics
#                           crm_home_index GET    /home/crm(.:format)                                                                               home#crm
#                     ecommerce_home_index GET    /home/ecommerce(.:format)                                                                         home#ecommerce
#                           lms_home_index GET    /home/lms(.:format)                                                                               home#lms
#                    management_home_index GET    /home/management(.:format)                                                                        home#management
#                          saas_home_index GET    /home/saas(.:format)                                                                              home#saas
#                               home_index GET    /home(.:format)                                                                                   home#index
#                                          POST   /home(.:format)                                                                                   home#create
#                                 new_home GET    /home/new(.:format)                                                                               home#new
#                                edit_home GET    /home/:id/edit(.:format)                                                                          home#edit
#                                     home GET    /home/:id(.:format)                                                                               home#show
#                                          PATCH  /home/:id(.:format)                                                                               home#update
#                                          PUT    /home/:id(.:format)                                                                               home#update
#                                          DELETE /home/:id(.:format)                                                                               home#destroy
#         turbo_recede_historical_location GET    /recede_historical_location(.:format)                                                             turbo/native/navigation#recede
#         turbo_resume_historical_location GET    /resume_historical_location(.:format)                                                             turbo/native/navigation#resume
#        turbo_refresh_historical_location GET    /refresh_historical_location(.:format)                                                            turbo/native/navigation#refresh
#            rails_postmark_inbound_emails POST   /rails/action_mailbox/postmark/inbound_emails(.:format)                                           action_mailbox/ingresses/postmark/inbound_emails#create
#               rails_relay_inbound_emails POST   /rails/action_mailbox/relay/inbound_emails(.:format)                                              action_mailbox/ingresses/relay/inbound_emails#create
#            rails_sendgrid_inbound_emails POST   /rails/action_mailbox/sendgrid/inbound_emails(.:format)                                           action_mailbox/ingresses/sendgrid/inbound_emails#create
#      rails_mandrill_inbound_health_check GET    /rails/action_mailbox/mandrill/inbound_emails(.:format)                                           action_mailbox/ingresses/mandrill/inbound_emails#health_check
#            rails_mandrill_inbound_emails POST   /rails/action_mailbox/mandrill/inbound_emails(.:format)                                           action_mailbox/ingresses/mandrill/inbound_emails#create
#             rails_mailgun_inbound_emails POST   /rails/action_mailbox/mailgun/inbound_emails/mime(.:format)                                       action_mailbox/ingresses/mailgun/inbound_emails#create
#           rails_conductor_inbound_emails GET    /rails/conductor/action_mailbox/inbound_emails(.:format)                                          rails/conductor/action_mailbox/inbound_emails#index
#                                          POST   /rails/conductor/action_mailbox/inbound_emails(.:format)                                          rails/conductor/action_mailbox/inbound_emails#create
#        new_rails_conductor_inbound_email GET    /rails/conductor/action_mailbox/inbound_emails/new(.:format)                                      rails/conductor/action_mailbox/inbound_emails#new
#            rails_conductor_inbound_email GET    /rails/conductor/action_mailbox/inbound_emails/:id(.:format)                                      rails/conductor/action_mailbox/inbound_emails#show
# new_rails_conductor_inbound_email_source GET    /rails/conductor/action_mailbox/inbound_emails/sources/new(.:format)                              rails/conductor/action_mailbox/inbound_emails/sources#new
#    rails_conductor_inbound_email_sources POST   /rails/conductor/action_mailbox/inbound_emails/sources(.:format)                                  rails/conductor/action_mailbox/inbound_emails/sources#create
#    rails_conductor_inbound_email_reroute POST   /rails/conductor/action_mailbox/:inbound_email_id/reroute(.:format)                               rails/conductor/action_mailbox/reroutes#create
# rails_conductor_inbound_email_incinerate POST   /rails/conductor/action_mailbox/:inbound_email_id/incinerate(.:format)                            rails/conductor/action_mailbox/incinerates#create
#                       rails_service_blob GET    /rails/active_storage/blobs/redirect/:signed_id/*filename(.:format)                               active_storage/blobs/redirect#show
#                 rails_service_blob_proxy GET    /rails/active_storage/blobs/proxy/:signed_id/*filename(.:format)                                  active_storage/blobs/proxy#show
#                                          GET    /rails/active_storage/blobs/:signed_id/*filename(.:format)                                        active_storage/blobs/redirect#show
#                rails_blob_representation GET    /rails/active_storage/representations/redirect/:signed_blob_id/:variation_key/*filename(.:format) active_storage/representations/redirect#show
#          rails_blob_representation_proxy GET    /rails/active_storage/representations/proxy/:signed_blob_id/:variation_key/*filename(.:format)    active_storage/representations/proxy#show
#                                          GET    /rails/active_storage/representations/:signed_blob_id/:variation_key/*filename(.:format)          active_storage/representations/redirect#show
#                       rails_disk_service GET    /rails/active_storage/disk/:encoded_key/*filename(.:format)                                       active_storage/disk#show
#                update_rails_disk_service PUT    /rails/active_storage/disk/:encoded_token(.:format)                                               active_storage/disk#update
#                     rails_direct_uploads POST   /rails/active_storage/direct_uploads(.:format)                                                    active_storage/direct_uploads#create

Rails.application.routes.draw do
  devise_for :customers
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations',
    passwords: 'users/passwords',
    unlocks: 'users/unlocks'
  }
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get 'up' => 'rails/health#show', as: :rails_health_check

  # Defines the root path route ("/")
  root 'home#index'

  namespace :users do
    resources :invoices do
      member do
        get :paid
      end
      collection do
        get :search_customer
        get :find_or_create_customer
        get :search_vehicle
        get :find_or_create_vehicle
      end
    end
    resources :products
    resources :users do
      member do
        post :enable_user
      end
    end
    resources :notifications, only: %i[index show destroy]
  end

  namespace :clients do
    resources :customers
  end

  resources :home do
    collection do
      get :analytics
      get :crm
      get :ecommerce
      get :lms
      get :management
      get :saas
    end
  end
end
