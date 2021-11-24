class Comparison < ApplicationRecord
  belongs_to :user, optional: true
  has_many :entries, dependent: :destroy
  validates :topic, presence: true
  # validates :start_date, presence: true
  # validates :end_date, presence: true
  # validates :country_one, if: (:publisher_one.nil? && :publisher_two.nil?), presence: true
  # validates :country_two, if: (:publisher_one.nil? && :publisher_two.nil?), presence: true
  # validates :publisher_one, if: (:country_one.nil? && :country_two.nil?), presence: true
  # validates :publisher_two, if: (:country_one.nil? && :country_two.nil?), presence: true
  SOURCES = ["cnn",
              "bbc",
              "guardian",
              "nytimes"]

  # SOURCES = Source.all.map do |source|
  #   source.name
  # end
end
