# Mahi App Setup Guide

## Authentication System with OTP 2FA

This Rails application includes:
- **Devise** for user authentication (registration, sign in, password recovery)
- **OTP 2FA** system supporting both:
  - Email-based OTP codes (sent via Gmail SMTP)
  - Authenticator app TOTP (Google Authenticator, Authy, etc.)

## Setup Instructions

### 1. Gmail SMTP Configuration

To send OTP codes via email, you need to set up Gmail App Password:

1. Go to your Google Account settings: https://myaccount.google.com/
2. Enable 2-Step Verification if not already enabled
3. Go to App Passwords: https://myaccount.google.com/apppasswords
4. Generate a new app password for "Mail"
5. Copy the generated password

### 2. Environment Variables

Set the following environment variables:

```bash
export GMAIL_USERNAME="your-email@gmail.com"
export GMAIL_APP_PASSWORD="your-app-password-here"
```

For production, set these in your deployment environment.

### 3. Database Setup

```bash
rails db:create
rails db:migrate
```

### 4. Start the Application

```bash
bin/dev
```

This starts both the Rails server and the SCSS watcher.

## Usage

### User Registration & Sign In

1. Visit `/users/sign_up` to create a new account
2. Visit `/users/sign_in` to sign in

### Enable Two-Factor Authentication

1. Sign in to your account
2. Go to `/two_factor` or click "Manage 2FA" on the home page
3. Click "Enable Two-Factor Authentication"
4. You have two options:
   - **Authenticator App**: Scan the QR code with Google Authenticator, Authy, or similar app
   - **Email OTP**: OTP codes will be sent to your email when signing in

### Sign In with 2FA Enabled

1. Sign in with your email and password
2. If 2FA is enabled, you'll be redirected to enter your OTP code
3. Enter the code from your authenticator app OR check your email for the code
4. Click "Verify" to complete sign in

### Resend OTP

If you didn't receive the email OTP code, click "Resend OTP" on the verification page.

## Features

- ✅ User registration and authentication
- ✅ Password recovery
- ✅ Remember me functionality
- ✅ Two-factor authentication (2FA)
- ✅ Email-based OTP codes
- ✅ Authenticator app support (TOTP)
- ✅ QR code generation for easy setup
- ✅ Gmail SMTP integration

## Routes

- `/` - Home page
- `/users/sign_up` - Registration
- `/users/sign_in` - Sign in
- `/users/sign_out` - Sign out
- `/two_factor` - Manage 2FA settings
- `/otp_verification/new` - OTP verification page

## Notes

- OTP codes expire after 5 minutes
- Email OTP codes are stored in Rails cache
- TOTP codes from authenticator apps are time-based and valid for 30 seconds
- The system supports both email OTP and authenticator app OTP simultaneously

