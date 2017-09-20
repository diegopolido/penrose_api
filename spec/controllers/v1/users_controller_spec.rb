require 'rails_helper'

RSpec.describe V1::UsersController, type: :controller do
  before do
    @created_users = create_list(:user, 10)
  end

  it 'returns all users in the database using the specified JSON format, ordered by most recently created first without a query parameter' do
    get :index
    expect(assigns(:users)).to eq(@created_users.reverse)
    expect(JSON.parse(response.body)).to eq({"users" => @created_users.reverse.as_json()})
  end

  it 'returns all users in the database filtered by the query paramater, using the specified JSON format, ordered by most recently created first with a query parameter' do
    user_1 = create(:user, metadata: "custom metadata")
    user_2 = create(:user, metadata: "custom metadata")
    get :index, { params: { query: "custom metadata" } }
    expect(assigns(:users).size).to be(2)
    expect(assigns(:users)).to match([user_2, user_1])
  end

  it 'creates a new user with unique values specified, and returns a single User JSON object and a 201 Created status header' do
    post :create, { params: { email: "diego@polidosantana.com.br", phone_number: "+5541991249776", full_name: "Diego Polido Santana", password: "123456", metadata: "male, age 30, employed, looking for new challanges" } }
    response_body = JSON.parse(response.body)
    expect(response.status).to eq(201)
    expect(response_body["email"]).to eq("diego@polidosantana.com.br")
    expect(response_body["phone_number"]).to eq("+5541991249776")
    expect(response_body["full_name"]).to eq("Diego Polido Santana")
    expect(response_body["metadata"]).to eq("male, age 30, employed, looking for new challanges")
    expect(response_body["key"]).not_to be_empty
  end

  it 'doesnt create a new user with non-unique values specified, returns a 422 Unprocessable Entity status, and an array of errors in the specified JSON format' do
    create(:user, email: "diego@polidosantana.com.br")
    post :create, { params: { email: "diego@polidosantana.com.br", phone_number: "+5541991249776", full_name: "Diego Polido Santana", password: "123456", metadata: "male, age 30, employed, looking for new challanges" } }
    response_body = JSON.parse(response.body)
    expect(response.status).to eq(422)
    expect(response_body["email"]).to eq(["has already been taken"])
  end

  it 'has a random key generated for it on the server side' do
    post :create, { params: { email: "diego@polidosantana.com.br", phone_number: "+5541991249776", full_name: "Diego Polido Santana", password: "123456", metadata: "male, age 30, employed, looking for new challanges" } }
    response_body = JSON.parse(response.body)
    expect(response_body["key"]).not_to be_empty
    expect(response_body["key"].size).to be(64)
  end

  it 'has its password stored in a hashed manner, with a salt value' do
    post :create, { params: { email: "diego@polidosantana.com.br", phone_number: "+5541991249776", full_name: "Diego Polido Santana", password: "123456", metadata: "male, age 30, employed, looking for new challanges" } }
    expect(assigns(:user).password_digest).not_to eq(assigns(:user).password)
  end

  it 'has an account_key created for it by accessing the Account Key service'
end
