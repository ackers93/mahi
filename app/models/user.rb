class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # OTP methods
  def enable_otp!
    update!(
      otp_secret: OtpService.generate_secret,
      otp_enabled: true,
      otp_enabled_at: Time.current
    )
  end

  def disable_otp!
    update!(
      otp_secret: nil,
      otp_enabled: false,
      otp_enabled_at: nil
    )
  end

  def verify_otp(otp_code)
    return false unless otp_enabled? && otp_secret.present?
    # Try TOTP first (authenticator app), then email-based OTP
    OtpService.verify_otp(otp_secret, otp_code) || OtpService.verify_email_otp(id, otp_code)
  end

  def send_otp_email
    otp_code = OtpService.generate_otp
    OtpService.store_otp(id, otp_code)
    OtpMailer.send_otp(self, otp_code).deliver_now
  end

  def provisioning_uri
    return nil unless otp_secret.present?
    OtpService.provisioning_uri(email, otp_secret)
  end
end
