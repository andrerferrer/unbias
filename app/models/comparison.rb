class Comparison < ApplicationRecord
  belongs_to :user
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
             "The guardian",
             "nytimes",
             "search",
             "thejournal",
             "Indiatimes",
             "The Hindu",
             "The Star online",
             "Jerusalem Post",
             "Haaretz - Science &amp; Health"]

  # SOURCES = Source.all.map do |source|
  #   source.name
  # end
end
