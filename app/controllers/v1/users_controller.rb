module V1
  class UsersController < ApplicationController
    def index
      @users = User.all
      @users = @users.by_query(params[:query]) if params[:query]
      @users = @users.order(created_at: :desc)
      render json: { users: @users }
    end

    def create
      @user = User.new(email: params[:email], phone_number: params[:phone_number], full_name: params[:full_name], password: params[:password], metadata: params[:metadata])
      @user.key = SecureRandom.hex(32)
      if @user.save
        AccountKeyServiceWorker.perform_async(@user.id)
        render json: @user.as_json, status: :created
      else
        render json: @user.errors, status: :unprocessable_entity
      end
    end
  end
end
