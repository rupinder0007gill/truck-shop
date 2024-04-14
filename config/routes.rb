# frozen_string_literal: true

# == Route Map
#
#                                   Prefix Verb   URI Pattern                                                                                       Controller#Action
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
#                             users_orders GET    /users/orders(.:format)                                                                           users/orders#index
#                                          POST   /users/orders(.:format)                                                                           users/orders#create
#                          new_users_order GET    /users/orders/new(.:format)                                                                       users/orders#new
#                         edit_users_order GET    /users/orders/:id/edit(.:format)                                                                  users/orders#edit
#                              users_order GET    /users/orders/:id(.:format)                                                                       users/orders#show
#                                          PATCH  /users/orders/:id(.:format)                                                                       users/orders#update
#                                          PUT    /users/orders/:id(.:format)                                                                       users/orders#update
#                                          DELETE /users/orders/:id(.:format)                                                                       users/orders#destroy
#                           users_products GET    /users/products(.:format)                                                                         users/products#index
#                                          POST   /users/products(.:format)                                                                         users/products#create
#                        new_users_product GET    /users/products/new(.:format)                                                                     users/products#new
#                       edit_users_product GET    /users/products/:id/edit(.:format)                                                                users/products#edit
#                            users_product GET    /users/products/:id(.:format)                                                                     users/products#show
#                                          PATCH  /users/products/:id(.:format)                                                                     users/products#update
#                                          PUT    /users/products/:id(.:format)                                                                     users/products#update
#                                          DELETE /users/products/:id(.:format)                                                                     users/products#destroy
#                              users_users GET    /users/users(.:format)                                                                            users/users#index
#                                          POST   /users/users(.:format)                                                                            users/users#create
#                           new_users_user GET    /users/users/new(.:format)                                                                        users/users#new
#                          edit_users_user GET    /users/users/:id/edit(.:format)                                                                   users/users#edit
#                               users_user GET    /users/users/:id(.:format)                                                                        users/users#show
#                                          PATCH  /users/users/:id(.:format)                                                                        users/users#update
#                                          PUT    /users/users/:id(.:format)                                                                        users/users#update
#                                          DELETE /users/users/:id(.:format)                                                                        users/users#destroy
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
    resources :orders
    resources :products
    resources :users
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
