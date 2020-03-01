class Domain < ApplicationRecord
  extend Enumerize

  enumerize :protocol, in: %w[http https]
end
