// Registration type
enum RegistrationType { phone, email }

// Response status
enum ResponseStatus { success, failure }

// Levels
enum ProficiencyLevels { a1, a2, b1, b2, none }

// Progress status
enum ProgressStatuses { pending, started, completed }

// State object
enum StateObjects {
  homeView,
  verifyOtp,
  resendOtp,
  profileImage,
  profileUpdate,
  resetPassword,
  loginWithEmail,
  loginWithGoogle,
  loadLessonVideo,
  requestResetCode,
  registerWithEmail,
  profileCompletion,
  registerWithGoogle,
}
