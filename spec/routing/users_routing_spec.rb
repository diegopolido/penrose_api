require 'rails_helper'

RSpec.describe "routes for users", type: :routing do
  it "routes GET /v1/users to the users controller with index action" do
    expect(get("/v1/users")).
      to route_to("v1/users#index")
  end
  it "routes POST /v1/users to the users controller with create action" do
    expect(post("/v1/users")).
      to route_to("v1/users#create")
  end
end
