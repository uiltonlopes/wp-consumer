class Domain < ApplicationRecord
  extend Enumerize
  validates :name, :protocol, :host, presence: true

  enumerize :protocol, in: %w[http https]
end
