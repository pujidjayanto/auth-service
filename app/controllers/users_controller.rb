class UsersController < ApplicationController
  before_action :require_basic_auth, only: [:show, :update, :close]

  # POST /signup
  def signup
    user = User.new(user_params)
    if user.save
      render json: {
        message: "Account successfully created",
        user: {
          user_id: user.user_id,
          nickname: user.user_id
        }
      }, status: :created
    else
      render json: {
        message: "Account creation failed",
        cause: user.errors.full_messages.join(", ")
      }, status: :unprocessable_entity
    end
  end

  # GET /users/:user_id
  def show
    user = User.find_by(user_id: params[:user_id])
    if user
      render json: {
        message: "User details by user_id",
        user: {
          user_id: user.user_id,
          nickname: user.nickname,
          comment: user.comment
        }
      }
    else
      render json: { message: "No user found" }, status: :not_found
    end
  end

  # PATCH /users/:user_id
  def update
    if @current_user&.user_id != params[:user_id]
      render json: { message: "No user found" }, status: :not_found
      return
    end

    if @current_user&.update(update_params)
      render json: {
        message: "Account successfully updated",
        user: {
          user_id: @current_user&.user_id,
          nickname: @current_user&.nickname,
          comment: @current_user&.comment
        }
      }, status: :ok
    else
      render json: {
        message: "Account update failed",
        cause: @current_user&.errors&.full_messages&.join(", ")
      }, status: :unprocessable_entity
    end
  end

  # POST /close
  def close
    if @current_user&.destroy
      render json: { message: "User deleted successfully" }
    else
      render json: { message: "Delete failed" }, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.permit(:user_id, :password, :nickname, :comment)
  end

  def update_params
    params.permit(:nickname, :comment)
  end
end
