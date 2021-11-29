class Article < ApplicationRecord
  has_many :entries, dependent: :destroy
end
