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

// Subscription  type
enum SubscriptionType { ielts, learn, duolingo }

// Voice recording state
enum VoiceRecordingState { pending, recording }

// Course practice
enum CoursePractices { courseCatalog, unit, lesson }

// Progress status
enum ProgressStatuses { pending, started, completed }

// Duolingo  types
enum CoursePracticeType { ielts, speaking, reading, writing, listening }

// Practice reason
enum PracticeReason {
  unit,
  course,
  module,
  lesson,
  previousUnit,
  previousModule,
  previousCourse,
}

// State object
enum StateObjects {
  faqs,
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
  startupView,
  learnLessons,
  learnModules,
  learnCourses,
  profileImage,
  inAppSupport,
  paymentStatus,
  profileDetail,
  learnPrograms,
  courseLessons,
  profileUpdate,
  resetPassword,
  learnPractice,
  notifications,
  subscriptions,
  getAssessments,
  courseCatalogs,
  loginWithEmail,
  coursePractice,
  loginWithGoogle,
  loadLessonVideo,
  loadCourseVideo,
  progressSummary,
  reading1Variant,
  reading7Variant,
  reading2Variant,
  reading8Variant,
  mySubscriptions,
  requestResetCode,
  finishAssessment,
  profileCompletion,
  learnSubscription,
  listening1Variant,
  listening3Variant,
  registerWithGoogle,
  learnPracticeSample,
  learnPracticeAnswer,
  assessmentQuestions,
  updateKnowledgeLevel,
  coursePracticePrompt,
  loginWithPhoneNumber,
  coursePracticeReview,
  learnPracticeQuestion,
  completeLearnPractice,
  ieltsSpeaking1Variant,
  ieltsSpeaking4Variant,
  completeCoursePractice,
  coursePracticeQuestions,
  duolingoSpeaking4Variant,
  recordLearnPracticeAnswer,
  recordCoursePracticeAnswer,
  finishLearnPracticeQuestion,
  finishCoursePracticeQuestion
}
