class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :friend, class_name: 'User' # Because its a self-referential association table
end
