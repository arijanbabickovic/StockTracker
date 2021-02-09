class StocksUsersController < ApplicationController

  def create
    stock = Stock.check_db(params[:ticker]) # This :ticker is sent from the result partial as an argument
    if stock.blank?
      stock = Stock.lookup(params[:ticker])
      stock.save
    end
    @stock_user = StocksUser.create(user: current_user, stock: stock)
    flash[:notice] = "Stock #{stock.name} was succesfully added to your portfolio."
    redirect_to my_portfolio_path
  end

  def destroy
    stock = Stock.find(params[:id])
    user_stock = StocksUser.where(user_id: current_user.id, stock_id: stock.id).first
    user_stock.destroy
    flash[:notice] = "#{stock.name} was succesfully removed from your portfolio."
    redirect_to my_portfolio_path
  end
end