# frozen_string_literal: true

# This file contains app data for seeding purposes
# load Rails.root.join('db/seeds/*.rb') ; AppSeeds::ClassName.seed

module AppSeeds
  class Users
    class << self
      def seed
        admin = Role.create(name: 'Admin')
        manager = Role.create(name: 'Manager')
        product_manager = Role.create(name: 'Product Manager')
        supervisor = Role.create(name: 'Supervisor')
        techinician = Role.create(name: 'Technician')
        User.create([
                      { first_name: 'Admin', last_name: 'Account', email: 'admin@test.com', password: 'test1234', role: admin },
                      { first_name: 'Rupinder', last_name: 'Gill', email: 'rupinder0007gill@gmail.com', password: 'test1234', role: admin },
                      { first_name: 'Manager', last_name: 'Account', email: 'manager@test.com', password: 'test1234', role: manager },
                      { first_name: 'Product Manager', last_name: 'Account', email: 'product_manager@test.com', password: 'test1234', role: product_manager },
                      { first_name: 'Supervisor', last_name: 'Account', email: 'supervisor@test.com', password: 'test1234', role: supervisor },
                      { first_name: 'Technician', last_name: 'Account', email: 'technician@test.com', password: 'test1234', role: techinician }
                    ])
        Setting.create(tax_name: 'GST', tax_percentage: 13, hourly_rate: 25)
      end
    end
  end
end
