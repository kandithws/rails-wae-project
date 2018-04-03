class Category < ApplicationRecord
  has_many :items
  before_save :case_insensitive

  def case_insensitive
    self.name = self.name.downcase
  end
end
