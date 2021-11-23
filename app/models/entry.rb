class Entry < ApplicationRecord
  belongs_to :comparison
  belongs_to :article
end
