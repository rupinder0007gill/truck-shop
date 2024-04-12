# frozen_string_literal: true

module AppSeeds
  class Products
    class << self
      def seed
        user = User.find 1
        Product.create([
                         { name: 'Brake Pad', status: 1, discount_percentage: 10, price_cents: 35_000, add_stock: 5, user_id: user.id },
                         { name: 'Drag Links', status: 1, discount_percentage: 15, price_cents: 80_000, add_stock: 15, user_id: user.id },
                         { name: 'Wishbones', status: 1, discount_percentage: 12, price_cents: 320_000, add_stock: 0, user_id: user.id },
                         { name: 'Wheel Hub Seal Kits', status: 1, discount_percentage: 8, price_cents: 45_000, add_stock: 0, user_id: user.id },
                         { name: 'Power Steering Pumps', status: 1, discount_percentage: 5, price_cents: 280_000, add_stock: 5, user_id: user.id },
                         { name: 'Leaf Spring Bushings', status: 1, discount_percentage: 2, price_cents: 12_000, add_stock: 5, user_id: user.id },
                         { name: 'Tie Rods And Tie Rod Ends', status: 1, discount_percentage: 10, price_cents: 40_000, add_stock: 5, user_id: user.id },
                         { name: 'Axle Rods', status: 1, discount_percentage: 5, price_cents: 23_000, add_stock: 5, user_id: user.id },
                         { name: 'Brake Discs', status: 1, discount_percentage: 10, price_cents: 350_000, add_stock: 5, user_id: user.id },
                         { name: 'Compressed Air Brake System Components', status: 1, discount_percentage: 15, price_cents: 260_000, add_stock: 5, user_id: user.id },
                         { name: 'Water Pumps', status: 1, discount_percentage: 10, price_cents: 120_000, add_stock: 5, user_id: user.id }
                       ])
      end
    end
  end
end
