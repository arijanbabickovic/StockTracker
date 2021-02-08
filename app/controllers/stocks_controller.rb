class StocksController < ApplicationController

  def search
    @stock = Stock.lookup(params[:stock])
    render 'users/my_portfolio'
  end

end