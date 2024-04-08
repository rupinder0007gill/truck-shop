# frozen_string_literal: true

# This file contains app data for seeding purposes
# load Rails.root.join('db/seeds/*.rb') ; AppSeeds::ClassName.seed

module AppSeeds
  class Users
    class << self
      def seed
        User.create([
                      { first_name: 'Admin', last_name: 'Account', email: 'admin@test.com', password: 'test1234', is_admin: true },
                      { first_name: 'Rupinder', last_name: 'Gill', email: 'rupinder0007gill@gmail.com', password: 'test1234', is_admin: true },
                      { first_name: 'Bhupendra', last_name: 'Singh', email: 'aventumcormac@gmail.com', password: 'test1234', is_admin: true },
                      { first_name: 'Technician', last_name: 'Account', email: 'technician@test.com', password: 'test1234' }
                    ])
      end
    end
  end
end
