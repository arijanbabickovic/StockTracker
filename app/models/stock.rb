class Stock < ApplicationRecord


    
    def self.lookup(ticker)
        client = IEX::Api::Client.new(publishable_token: ENV["PUBLISHABLE_TOKEN"],
                                      secret_token: ENV["SECRET_TOKEN"],
                                      endpoint: 'https://sandbox.iexapis.com/v1')
        client.price(ticker)
    end
end
