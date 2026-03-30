// Login method
enum LoginMethod { phone, email, google }

// Response status
enum ResponseStatus { success, failure }

// Sign-up method
enum SignUpMethod { phone, email, google }

// Voice recording state
enum VoiceRecordingState { pending, recording }

// Levels
enum ProficiencyLevels { a1, a2, b1, b2, none }

// Progress status
enum ProgressStatuses { pending, started, completed }

// Duolingo assessment types
enum DuolingoAssessmentType { speaking, reading, writing, listening }

// State object
enum StateObjects {
  none,
  courses,
  homeView,
  register,
  verifyOtp,
  resendOtp,
  profileImage,
  courseLessons,
  profileUpdate,
  resetPassword,
  subcategories,
  loginWithEmail,
  coursePractice,
  loginWithGoogle,
  loadLessonVideo,
  loadCourseVideo,
  requestResetCode,
  courseCategories,
  profileCompletion,
  registerWithGoogle,
  learnPracticeSample,
  learnPracticeAnswer,
  loginWithPhoneNumber,
  learnPracticeQuestion,
  recordLearnPracticeAnswer,

}
