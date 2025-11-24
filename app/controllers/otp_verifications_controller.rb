class OtpVerificationsController < ApplicationController
  skip_before_action :verify_otp_if_enabled
  before_action :ensure_pending_user, only: [:new, :create]

  def new
    @user = pending_user
    @otp_code = ""
  end

  def create
    @user = pending_user
    otp_code = params[:otp_code]
    
    if @user&.verify_otp(otp_code)
      session[:otp_verified] = true
      sign_in(@user)
      session.delete(:pending_user_id)
      redirect_to root_path, notice: "Successfully verified!"
    else
      flash.now[:alert] = "Invalid OTP code. Please try again."
      @otp_code = otp_code
      render :new, status: :unprocessable_entity
    end
  end

  def resend
    @user = pending_user
    if @user
      @user.send_otp_email
      redirect_to new_otp_verification_path, notice: "A new OTP code has been sent to your email."
    else
      redirect_to new_user_session_path, alert: "Please sign in first."
    end
  end

  private

  def ensure_pending_user
    if session[:pending_user_id]
      @pending_user = User.find_by(id: session[:pending_user_id])
    elsif user_signed_in? && current_user.otp_enabled?
      @pending_user = current_user
    else
      redirect_to new_user_session_path, alert: "Please sign in first."
    end
  end

  def pending_user
    @pending_user
  end
end


