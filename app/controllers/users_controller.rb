class UsersController < ApplicationController

  def create
    user = User.create!(user_params)
    session[:user_id] = user.id
    render json: user, status: :created
  rescue ActiveRecord::RecordInvalid => invalid
    render json: invalid.record.errors.full_messages, status: :unprocessable_entity
  end

  def show
    user = User.find(session[:user_id])
    render json: user
  rescue ActiveRecord::RecordNotFound
    render json: { error: "User not found." }, status: :unauthorized
  end

  private

  def user_params
    params.permit(:username, :password, :password_confirmation)
  end

end
