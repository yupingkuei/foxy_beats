class Vinyl < ApplicationRecord
  belongs_to :user
  has_many :rentals, dependent: :destroy
  CONDITIONS = ["Mint", "Near Mint", "Good", "Fair"]
  validates :price, presence: true

  include PgSearch::Model
  pg_search_scope :search_by_title_and_artist,
    against: [ :title, :artist ],
  using: {
    tsearch: { prefix: true }
  }
end
