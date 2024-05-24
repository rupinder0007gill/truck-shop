# frozen_string_literal: true

module HomeHelper
  def user_and_customers_image(interlocutor, size = 48)
    size2x = size * 2
    if interlocutor.avatar.attached?
      image_tag interlocutor.avatar.variant(resize_to_fill: [size2x, size2x], saver: { gravity: 'Center' }),
                class: 'rounded-circle'
    else
      lavatar_tag(interlocutor.name.split.map(&:chr).join.upcase[0], size, class: 'rounded-circle')
    end
  end
end
