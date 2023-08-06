class UsersController < ApplicationController
  skip_before_action :authenticate, only: [:create]

  # POST /users
  def create
    @user = User.new(user_params)

    if @user.save
      send_email_verification
      render json: @user, status: :created
    else
      render json: {error: @user.errors.full_messages}, status: :unprocessable_entity
    end
  end

  # PATCH /users
  def update
    @user = Current.user

    if @user.update(user_params)
      render json: @user, status: :ok
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # POST /users/attach_resume
  def attach_resume
    @user = Current.user
    if @user.resume.attach(user_params[:resume])
      render json: {user: @user, resume: @user.resume.attached?}, status: :ok
    else
      render json: @user.errors
    end
  end

  # GET /users/stored_data
  def stored_data
    @user = Current.user
    render json: @user.stored_weather_data_objects, status: :ok
  end
  private

  def user_params
    params.permit(:email, :password, :password_confirmation, :resume)
  end

  def send_email_verification
    UserMailer.with(user: @user).email_verification.deliver_later
  end
end
