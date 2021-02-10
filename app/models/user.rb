class User < ApplicationRecord
  has_many :stocks_users
  has_many :stocks, through: :stocks_users
  has_many :friendships
  has_many :friends, through: :friendships
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  
  def stock_already_tracked?(ticker_symbol)
    stock = Stock.check_db(ticker_symbol) # Method from Stock model, checking if the stock exists in database
    return false unless stock
    stocks.where(id: stock.id).exists? # Checking if user already follows the stock from the database
  end
         
  def under_stock_limit?
    stocks.count < 10
  end
  
  def can_track_stocks?(ticker_symbol)
    under_stock_limit? && !stock_already_tracked?(ticker_symbol)
  end

  def full_name
    return "#{first_name} #{last_name}" if first_name || last_name
    "Anonymous"
  end

  def self.search(param)
    param.strip!
    to_send_back = (first_name_matches(param) + last_name_matches(param) + email_matches(param)).uniq
    return nil unless to_send_back
    to_send_back
  end

  def self.first_name_matches(param)
    matches('first_name', param)
  end

  def self.last_name_matches(param)
    matches('last_name', param)
  end

  def self.email.matches(param)
    matches('email', param)
  end

  def self.matches(field_name, param)
    where ("#{field_name} like?", "%#{param}%")
  end

end
