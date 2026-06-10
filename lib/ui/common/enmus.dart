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

// Course practice
enum CoursePractices { courseCatalog, unit, lesson }

// Progress status
enum ProgressStatuses { pending, started, completed }

// Duolingo  types
enum DuolingoAssessments { speaking, reading, writing, listening }

// Practice reason
enum PracticeReason { course, module, lesson, previousModule, previousCourse }

// State object
enum StateObjects {
  none,
  logout,
  courses,
  register,
  verifyOtp,
  resendOtp,
  courseUnits,
  assessments,
  startupView,
  learnLessons,
  learnModules,
  learnCourses,
  profileImage,
  paymentStatus,
  profileDetail,
  learnPrograms,
  courseLessons,
  profileUpdate,
  resetPassword,
  learnPractice,
  notifications,
  courseCatalogs,
  loginWithEmail,
  coursePractice,
  loginWithGoogle,
  loadLessonVideo,
  loadCourseVideo,
  progressSummary,
  requestResetCode,
  profileCompletion,
  learnSubscription,
  learnSubscriptions,
  registerWithGoogle,
  learnPracticeSample,
  learnPracticeAnswer,
  loginWithPhoneNumber,
  assessmentQuestions,
  coursePracticeReview,
  learnPracticeQuestion,
  completeLearnPractice,
  coursePracticeQuestion,
  coursePracticeQuestions,
  recordLearnPracticeAnswer,
  recordCoursePracticeAnswer,
  finishLearnPracticeQuestion,
  finishCoursePracticeQuestion
}
