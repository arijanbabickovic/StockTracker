class Stock < ApplicationRecord
  has_many :stocks_users
  has_many :users, through: :stocks_users

  validates :name, :ticker, presence: true

  def self.lookup(ticker_symbol)
    client = IEX::Api::Client.new(publishable_token: ENV["PUBLISHABLE_TOKEN"],
                                  secret_token: ENV["SECRET_TOKEN"],
                                  endpoint: 'https://sandbox.iexapis.com/v1')
    begin
      new(ticker: ticker_symbol.upcase, name: client.company(ticker_symbol).company_name, last_price: client.price(ticker_symbol))
    rescue => exception
      return nil
    end
  end

  def self.check_db(ticker_symbol)
    where(ticker: ticker_symbol.upcase).first
  end
end