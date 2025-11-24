class OtpService
  OTP_LENGTH = 6
  OTP_VALIDITY_SECONDS = 300 # 5 minutes

  # Generate a random 6-digit OTP code
  def self.generate_otp
    rand(100_000..999_999).to_s
  end

  # Generate a secret for TOTP (Time-based One-Time Password) for authenticator apps
  def self.generate_secret
    ROTP::Base32.random
  end

  # Verify TOTP code from authenticator app
  def self.verify_otp(secret, otp)
    totp = ROTP::TOTP.new(secret)
    totp.verify(otp, drift_behind: 30, drift_ahead: 30)
  end

  # Generate provisioning URI for QR code
  def self.provisioning_uri(email, secret, issuer = "Mahi")
    totp = ROTP::TOTP.new(secret, issuer: issuer)
    totp.provisioning_uri(email)
  end

  # Generate QR code SVG
  def self.generate_qr_code(provisioning_uri)
    qrcode = RQRCode::QRCode.new(provisioning_uri)
    qrcode.as_svg(module_size: 4)
  end

  # Store OTP in cache for email-based verification
  def self.store_otp(user_id, otp_code)
    Rails.cache.write("otp_#{user_id}", otp_code, expires_in: OTP_VALIDITY_SECONDS.seconds)
  end

  # Verify email-based OTP
  def self.verify_email_otp(user_id, otp_code)
    stored_otp = Rails.cache.read("otp_#{user_id}")
    return false unless stored_otp
    return false unless stored_otp == otp_code
    
    Rails.cache.delete("otp_#{user_id}")
    true
  end
end

