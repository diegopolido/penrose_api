require 'rails_helper'

RSpec.describe User, type: :model do
  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:phone_number) }
  it { should validate_presence_of(:password) }
  it { should validate_presence_of(:key) }

  it { should validate_uniqueness_of(:email) }
  it { should validate_uniqueness_of(:phone_number) }
  it { should validate_uniqueness_of(:key) }
  it { should validate_uniqueness_of(:account_key) }

  it 'fetches users "by query" scope' do
    created_list = create_list(:user, 10)
    users = User.by_query("John Doe")
    expect(users).to match(created_list)
    first_user = created_list.first
    users = User.by_query(first_user.email)
    expect(users.size).to be(1)
    expect(users.first.email).to eq(first_user.email)
  end
end
