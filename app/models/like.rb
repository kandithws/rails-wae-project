class Like < ApplicationRecord
  belongs_to :user
  # http://guides.rubyonrails.org/association_basics.html#polymorphic-associations
  belongs_to :likeable, polymorphic: true
  # https://stackoverflow.com/questions/7428872/rails-validate-unique-combination-of-3-columns
  validates_uniqueness_of :user_id, scope: [:likeable_id, :likeable_type]
end
