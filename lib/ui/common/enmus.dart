// Payment method
enum PaymentMethod { ussd, sdk }

// Practice voice
enum Voice { sample, recorded }

// Course  type
enum CourseType { ielts, duolingo }

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
enum CoursePracticeType { ielts, speaking, reading, writing, listening }

// Practice reason
enum PracticeReason { course, module, lesson, previousModule, previousCourse }

// State object
enum StateObjects {
  none,
  logout,
  courses,
  openPdf,
  register,
  verifyOtp,
  resendOtp,
  stopAudio,
  cacheImage,
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
  reading1Variant,
  speaking4Variant,
  requestResetCode,
  profileCompletion,
  learnSubscription,
  listening1Variant,
  listening3Variant,
  learnSubscriptions,
  registerWithGoogle,
  learnPracticeSample,
  learnPracticeAnswer,
  coursePracticePrompt,
  loginWithPhoneNumber,
  assessmentQuestions,
  coursePracticeReview,
  learnPracticeQuestion,
  completeLearnPractice,
  coursePracticeQuestions,
  recordLearnPracticeAnswer,
  recordCoursePracticeAnswer,
  finishLearnPracticeQuestion,
  finishCoursePracticeQuestion
}
