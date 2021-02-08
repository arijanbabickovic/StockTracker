class Stock < ApplicationRecord
  has_many :stocks_users
  has_many :users, through: :stocks_users

  validates :name, :ticker, presence: true

  def self.lookup(ticker)
    client = IEX::Api::Client.new(publishable_token: ENV["PUBLISHABLE_TOKEN"],
                                  secret_token: ENV["SECRET_TOKEN"],
                                  endpoint: 'https://sandbox.iexapis.com/v1')
    begin
      new(ticker: ticker, name: client.company(ticker).company_name, last_price: client.price(ticker))
    rescue => exception
      return nil
    end
  end
end
