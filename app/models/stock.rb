class Stock < ApplicationRecord


    
    def self.lookup(ticker)
        client = IEX::Api::Client.new(publishable_token: ENV["PUBLISHABLE_TOKEN"],
                                      secret_token: ENV["SECRET_TOKEN"],
                                      endpoint: 'https://sandbox.iexapis.com/v1')
        new(ticker: ticker, name: client.company(ticker).company_name, last_price: client.price(ticker))
    end
end
