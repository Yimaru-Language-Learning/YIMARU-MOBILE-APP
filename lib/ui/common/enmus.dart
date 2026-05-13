// Practice voice
enum Voice { sample, recorded }

// Response status
enum ResponseStatus { success, failure }

// Login method
enum LoginMethod { phone, email, google }

// Sign-up method
enum SignUpMethod { phone, email, google }

// Learn practice
enum LearnPractices { course, module, lesson }

// Voice recording state
enum VoiceRecordingState { pending, recording }

// // Levels
// enum ProficiencyLevels { a1, a2, b1, b2, none }

// Progress status
enum ProgressStatuses { pending, started, completed }

// Duolingo  types
enum DuolingoAssessments { speaking, reading, writing, listening }

// State object
enum StateObjects {
  none,
  courses,
  register,
  verifyOtp,
  resendOtp,
  assessments,
  startupView,
  learnLessons,
  learnModules,
  learnCourses,
  profileImage,
  learnPrograms,
  courseLessons,
  profileUpdate,
  resetPassword,
  learnPractice,
  courseCatalogs,
  loginWithEmail,
  coursePractice,
  loginWithGoogle,
  loadLessonVideo,
  loadCourseVideo,
  learnSubmodules,
  requestResetCode,
  profileCompletion,
  learnSubscription,
  learnSubscriptions,
  registerWithGoogle,
  learnPracticeSample,
  learnPracticeAnswer,
  loginWithPhoneNumber,
  assessmentQuestions,
  learnPracticeQuestion,
  completeLearnPractice,
  coursePracticeQuestion,
  coursePracticeQuestions,
  recordLearnPracticeAnswer,
  finishLearnPracticeQuestion
}
