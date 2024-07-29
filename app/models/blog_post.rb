class BlogPost < ApplicationRecord
  validates :title, presence: true
  # validates :body, presence: true
  validates_presence_of :body, on: :create, message: "can't be blank"
end
