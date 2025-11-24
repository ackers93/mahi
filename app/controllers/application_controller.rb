class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  # Changes to the importmap will invalidate the etag for HTML responses
  stale_when_importmap_changes

  before_action :verify_otp_if_enabled

  private

  def verify_otp_if_enabled
    return unless user_signed_in?
    return unless current_user.otp_enabled?
    return if session[:otp_verified]
    return if devise_controller? && action_name == "destroy" # Allow sign out
    return if controller_name == "otp_verifications"
    return if controller_name == "two_factor"

    redirect_to new_otp_verification_path
  end
end

