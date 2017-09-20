class User < ApplicationRecord
  scope :by_query, ->(query) { where("email like :query or full_name like :query or metadata like :query", query: query) }
  validates_presence_of :email, :phone_number, :password, :key
  validates_uniqueness_of :email, :phone_number, :key, :account_key
  validates :email, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
  has_secure_password
  def as_json(options={})
    super(only: [:email, :phone_number, :full_name, :key, :account_key, :metadata])
  end
end
