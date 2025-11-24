class TwoFactorController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = current_user
    if @user.otp_enabled?
      @provisioning_uri = @user.provisioning_uri
      @qr_code = OtpService.generate_qr_code(@provisioning_uri) if @provisioning_uri
    end
  end

  def enable
    @user = current_user
    if @user.enable_otp!
      @provisioning_uri = @user.provisioning_uri
      @qr_code = OtpService.generate_qr_code(@provisioning_uri) if @provisioning_uri
      redirect_to two_factor_path, notice: "Two-factor authentication has been enabled. Please scan the QR code with your authenticator app."
    else
      redirect_to two_factor_path, alert: "Failed to enable two-factor authentication."
    end
  end

  def disable
    @user = current_user
    if @user.disable_otp!
      redirect_to two_factor_path, notice: "Two-factor authentication has been disabled."
    else
      redirect_to two_factor_path, alert: "Failed to disable two-factor authentication."
    end
  end
end

