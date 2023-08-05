class UsersController < ApplicationController
  skip_before_action :authenticate, only: [:create]

  def create
    @user = User.new(user_params)

    if @user.save
      send_email_verification
      render json: @user, status: :created
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  def update
    @user = Current.user

    if @user.update(user_params)
      render json: @user, status: :ok
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  def attach_resume
    @user = Current.user

    if @user.resume.attach(user_params[:resume])
      render json: url_for(@user.resume), status: :ok
    else
      render json: @user.errors
    end
  end

  private

  def user_params
    params.permit(:email, :password, :password_confirmation, :resume)
  end

  def send_email_verification
    UserMailer.with(user: @user).email_verification.deliver_later
  end
end
