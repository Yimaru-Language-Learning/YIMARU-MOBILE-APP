# Auth Screens Redesign - Manual Test Document

This document outlines manual verification test cases for the redesigned Login and Registration screens matching the design mockup.

---

## 1. Frame A1: Login (`login_with_email_screen.dart`)

| Test ID | Test Scenario | Steps to Verify | Expected Result |
|---|---|---|---|
| **A1-01** | Header Display | Open the login screen. | • Magenta gradient header with sparkles.<br>• Top right language pill (`en` / `አማ`).<br>• Mascot Yimi peeking with speech bubble: *"ሰላም! Good to see you again."* |
| **A1-02** | Form Fields & Links | Check inputs on the white bottom sheet. | • "Welcome back" heading.<br>• "Don't have an account? Register" link navigates to register view.<br>• "Email" field with hint `you@example.com`.<br>• "Password" field with eye toggle icon.<br>• "Forgot password?" right-aligned link navigates to forgot password view. |
| **A1-03** | Button States & Actions | Fill in / clear email & password. | • "Continue" button is soft purple when empty, full magenta when filled.<br>• "Login with Google" button with Google logo.<br>• "Or" divider.<br>• "Login with phone number" button switches to phone login screen. |

---

## 2. Frame A2: Register with Email (`register_with_email_screen.dart`)

| Test ID | Test Scenario | Steps to Verify | Expected Result |
|---|---|---|---|
| **A2-01** | Header Display | Navigate to Register screen. | • Squircle back button on left.<br>• Language pill on right.<br>• Winking Yimi mascot with speech bubble: *"እንኳን ደህና መጡ! Let's get you started."* |
| **A2-02** | Inputs & Alternative Actions | Check form content. | • "Create an account" heading.<br>• "Already have an account? Login" navigates back to login.<br>• Email input with validation error display.<br>• "Continue" button advances to password creation.<br>• "Register with Google" and "Register with phone number" buttons present. |

---

## 3. Frame A3: Create Password (`create_password_screen.dart`)

| Test ID | Test Scenario | Steps to Verify | Expected Result |
|---|---|---|---|
| **A3-01** | Header & Mascot | Enter email on A2 and tap Continue. | • Squircle back button and Language pill.<br>• Shy Yimi mascot covering eyes with speech bubble: *"Don't worry, I won't peek!"* |
| **A3-02** | Password Validation & Strength | Type password and confirm password. | • Segmented strength bar updates based on criteria.<br>• "8 characters minimum" checkmark turns green when ≥ 9 chars.<br>• "Passwords match" checkmark turns green when both match. |
| **A3-03** | Terms & Submission | Check terms and tap Register. | • Checkbox for Terms of Service and Privacy Policy.<br>• Tapping links opens respective legal views.<br>• "Register" button enables only when all checks pass and box is checked. |

---

## 4. Frame A4: Verification Code (`registration_otp_screen.dart` / `login_otp_screen.dart`)

| Test ID | Test Scenario | Steps to Verify | Expected Result |
|---|---|---|---|
| **A4-01** | Toast & Illustration | Trigger registration or phone login OTP. | • Top green toast banner: *"✔ Code sent successfully"*.<br>• Illustrated white envelope with green checkmark badge. |
| **A4-02** | PIN Input & Timer | Type verification code. | • "Verification code" heading with masked email / phone subtext.<br>• 6 rounded Pinput square boxes.<br>• Timer countdown displays *"Resend code in mm:ss"*.<br>• When timer ends, turns into clickable *"Resend code"* button.<br>• "Continue" button verifies code. |

---

## 5. Frame A5: Register / Login with Phone (`register_with_phone_number_screen.dart` / `login_with_phone_number_screen.dart`)

| Test ID | Test Scenario | Steps to Verify | Expected Result |
|---|---|---|---|
| **A5-01** | Header & Mascot | Tap "Register with phone number" / "Login with phone number". | • Squircle back button & Language pill.<br>• Mascot Yimi holding phone / speaking with speech bubble: *"እንኳን ደህና መጡ! I'll text you a code."* |
| **A5-02** | Country Code & Counter | Inspect phone number field. | • Prefix container: Ethiopian flag + `+251` + dropdown arrow.<br>• Input field: `9X XXX XXXX`.<br>• Digits only allowed, max length 9.<br>• Counter `X/9` displayed.<br>• "Continue" button enables once 9 digits are entered. |
| **A5-03** | Switch to Email | Tap "Register with email" / "Login with email". | • Switches back to email registration / login screen seamlessly. |

