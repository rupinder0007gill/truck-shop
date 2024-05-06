# frozen_string_literal: true

module Users::InvoicesHelper
  def services_duration_options
    [['10 minutes', 10], ['15 minutes', 15], ['20 minutes', 20], ['25 minutes', 25], ['30 minutes', 30], ['35 minutes', 35], ['40 minutes', 40], ['45 minutes', 45], ['50 minutes', 50], ['55 minutes', 55], ['1 hour', 60], ['1 1/4 hour', 75], ['1 1/2 hour', 90], ['2 hours', 120], ['2 1/2 hours', 150], ['3 hours', 180], ['3 1/2 hours', 210], ['4 hours', 240], ['4 1/2 hours', 270], ['5 hours', 300], ['5 1/2 hours', 330], ['6 hours', 360], ['6 1/2 hours', 390], ['7 hours', 420], ['7 1/2 hours', 450], ['8 hours', 480], ['8 1/2 hours', 510], ['9 hours', 540], ['9 1/2 hours', 570], ['10 hours', 600]]
  end
end
