# frozen_string_literal: true

class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class # default in rails 7

  self.abstract_class = true

  acts_as_paranoid
end
