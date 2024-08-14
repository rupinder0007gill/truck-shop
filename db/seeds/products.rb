# frozen_string_literal: true

module AppSeeds
  class Products
    class << self
      def seed
        User.find 1
        Product.create([
                         { product_number: 'B0001', name: 'Brake Pad', base_price_cents: 35_000, selling_price_cents: 45_000, core_price_cents: 5_000, add_stock: 5 },
                         { product_number: 'DL0001', name: 'Drag Links', base_price_cents: 55_000, selling_price_cents: 65_000, core_price_cents: 10_000, add_stock: 15 },
                         { product_number: 'W0005', name: 'Wishbones', base_price_cents: 300_000, selling_price_cents: 320_000, core_price_cents: 20_000, add_stock: 2 },
                         { product_number: 'W0002', name: 'Wheel Hub Seal Kits', base_price_cents: 45_000, selling_price_cents: 65_000, core_price_cents: 5_000, add_stock: 0 },
                         { product_number: 'PS0001', name: 'Power Steering Pumps', base_price_cents: 255_000, selling_price_cents: 280_000, core_price_cents: 10_000, add_stock: 5 },
                         { product_number: 'LS0002', name: 'Leaf Spring Bushings', base_price_cents: 12_000, selling_price_cents: 15_000, core_price_cents: 1_000, add_stock: 5 },
                         { product_number: 'RAT0001', name: 'Tie Rods And Tie Rod Ends', base_price_cents: 55_000, selling_price_cents: 65_000, core_price_cents: 2_000, add_stock: 5 },
                         { product_number: 'AR0001', name: 'Axle Rods', base_price_cents: 21_000, selling_price_cents: 25_000, core_price_cents: 1_500, add_stock: 5 },
                         { product_number: 'B0002', name: 'Brake Discs', base_price_cents: 350_000, selling_price_cents: 280_000, core_price_cents: 30_000, add_stock: 15 },
                         { product_number: 'CB0001', name: 'Compressed Air Brake System Components', base_price_cents: 260_000, selling_price_cents: 300_000, core_price_cents: 50_000, add_stock: 15 },
                         { product_number: 'W0001', name: 'Water Pumps', base_price_cents: 120_000, selling_price_cents: 165_000, core_price_cents: 20_000, add_stock: 5 }
                       ])
      end
    end
  end
end
