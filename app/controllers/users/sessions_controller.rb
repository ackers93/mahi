class Users::SessionsController < Devise::SessionsController
  def create
    super do |resource|
      if resource.persisted? && resource.otp_enabled?
        session[:otp_verified] = false
        sign_out(resource)
        session[:pending_user_id] = resource.id
        # Send OTP via email
        resource.send_otp_email
        redirect_to new_otp_verification_path, notice: "An OTP code has been sent to your email." and return
      end
    end
  end
end

