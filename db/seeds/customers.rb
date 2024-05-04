# frozen_string_literal: true

# This file contains app data for seeding purposes
# load Rails.root.join('db/seeds/*.rb') ; AppSeeds::ClassName.seed

module AppSeeds
  class Customers
    class << self
      def seed
        Customer.create([
                          { first_name: 'Customer', last_name: 'Account', email: 'customer@test.com', password: 'test1234' },
                          { first_name: 'Rupinder', last_name: 'Gill', email: 'rupinder0007gill@gmail.com', password: 'test1234' },
                          { first_name: 'Bhupendra', last_name: 'Singh', email: 'aventumcormac@gmail.com', password: 'test1234' },
                          { first_name: 'Manager', last_name: 'Account', email: 'manager@test.com', password: 'test1234' },
                          { first_name: 'Technician', last_name: 'Account', email: 'technician@test.com', password: 'test1234' }
                        ])
      end
    end
  end
end
