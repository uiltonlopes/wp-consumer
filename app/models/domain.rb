class Domain < ApplicationRecord
  extend Enumerize
  validates :name, :protocol, :host, presence: true
  before_validation :check_api, on: :create
  serialize :namespace, Array

  enumerize :protocol, in: %w[http https]

  def check_api
    Namespace.all.each do |name|
      url = "#{protocol}://#{host}#{name.namespace}"
      response = HTTParty.get(url)
      namespace << name.namespace if response.code == 200
    end
  end
end
