# frozen_string_literal: true

# This file contains app data for seeding purposes
# load Rails.root.join('db/seeds/*.rb') ; AppSeeds::ClassName.seed

module AppSeeds
  class Users
    class << self
      def seed
        admin = Role.create(name: 'Admin')
        manager = Role.create(name: 'Manager')
        techinician = Role.create(name: 'Technician')
        User.create([
                      { first_name: 'Admin', last_name: 'Account', email: 'admin@test.com', password: 'test1234', role: admin },
                      { first_name: 'Rupinder', last_name: 'Gill', email: 'rupinder0007gill@gmail.com', password: 'test1234', role: admin },
                      { first_name: 'Bhupendra', last_name: 'Singh', email: 'aventumcormac@gmail.com', password: 'test1234', role: admin },
                      { first_name: 'Manager', last_name: 'Account', email: 'manager@test.com', password: 'test1234', role: manager },
                      { first_name: 'Technician', last_name: 'Account', email: 'technician@test.com', password: 'test1234', role: techinician }
                    ])
        Setting.create(tax_name: 'GST', tax_percentage: 13, hourly_rate: 25)
      end
    end
  end
end
