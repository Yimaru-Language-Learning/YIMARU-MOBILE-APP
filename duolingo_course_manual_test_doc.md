# Duolingo Course Section – Manual Test Document

> **Screens covered**: Course Unit View · Course Unit Tile (expanded) · Course Module View · Course Lesson Tile  
> **Illustration assets**: `assets/images/07-duolingo-english-test/`  
> **Brand color**: Green `#58CC02` (Duolingo)

---

## Test Environment

| Field | Value |
|-------|-------|
| Platform | Android / iOS |
| App state | Logged-in user (valid session) |
| Network | Connected (API accessible) |
| Course | Duolingo English Test (7 units) |

---

## TC-DU01 – Course Unit View (Screen 1 & 2)

| ID | Scenario | Steps | Expected Result |
|----|----------|-------|-----------------|
| DU01-01 | Green hero banner renders | 1. Navigate to Duolingo English Test course units | Full-width green (#58CC02) banner displayed with `7.1-det-course-01.svg` illustration |
| DU01-02 | SVG illustration in banner | 1. Open course unit view | Illustration is visible on the right side of the banner; no broken image |
| DU01-03 | Units pill in banner | 1. Open course unit view with 7 units loaded | "7 UNITS" white pill badge appears bottom-left of banner |
| DU01-04 | Units pill count updates | 1. Open a course with a different number of units | Pill shows actual unit count from `viewModel.units.length` |
| DU01-05 | Overall progress section | 1. Open course unit view | "አጠቃላይ እድገት" label + "0%" green + progress bar at 0 + subtitle text shown below banner |
| DU01-06 | Loading spinner | 1. Open course unit view on slow network | Circular progress spinner shown while units load |
| DU01-07 | Units listed after load | 1. Wait for API response | All units appear as expansion tiles below the progress section |
| DU01-08 | Top bar title | 1. Open course unit view | Top bar shows "Duolingo English Test" (catalog name) |
| DU01-09 | Back navigation | 1. Tap ← in top bar | Returns to Course Catalog screen |
| DU01-10 | Background color | 1. Open course unit view | Page background is light grey (#F7F7F7), not white |

---

## TC-DU02 – Course Unit Tile (per-unit row)

| ID | Scenario | Steps | Expected Result |
|----|----------|-------|-----------------|
| DU02-01 | "UNIT X" label color | 1. Observe Unit 1 tile | "UNIT 1" label shown in green (#58CC02) above the unit name |
| DU02-02 | Unit 2 label color | 1. Observe Unit 2 tile | "UNIT 2" label shown in blue (#1CB0F6) |
| DU02-03 | Unit 3 label color | 1. Observe Unit 3 tile | "UNIT 3" label shown in purple (#9C27B0) |
| DU02-04 | Unit 4 label color | 1. Observe Unit 4 tile | "UNIT 4" label shown in orange (#FF9600) |
| DU02-05 | Unit 5 label color | 1. Observe Unit 5 tile | "UNIT 5" label shown in red (#FF4B4B) |
| DU02-06 | Unit 6 label color | 1. Observe Unit 6 tile | "UNIT 6" label shown in yellow (#FFD700) |
| DU02-07 | Demo unit icon | 1. Observe Demo unit tile | Green circle with play icon |
| DU02-08 | Flag icon – Unit 1 | 1. Observe Unit 1 icon | Solid green circle with flag icon |
| DU02-09 | Bar chart icon – Unit 2 | 1. Observe Unit 2 icon | Blue circle with bar chart icon |
| DU02-10 | Progress bar per unit | 1. Observe any unit tile | Progress bar shown under unit name at 0% with matching unit color |
| DU02-11 | "0% ትምፀና" subtitle | 1. Observe unit tile subtitle | Progress label text shown next to the bar |
| DU02-12 | Expand unit | 1. Tap any unit tile | Tile expands to reveal module list below; loading spinner appears briefly |
| DU02-13 | Module list loads on expand | 1. Expand Unit 1 | API fires; modules "1.1 Introduction" and "1.2 How Scoring Works" appear |
| DU02-14 | No duplicate API call | 1. Collapse then re-expand same unit | No second API call; cached modules shown immediately |
| DU02-15 | Module row bookmark icon | 1. Expand a unit, observe sub-rows | Each module row shows bookmark-style icon on left, module name, radio circle on right |
| DU02-16 | Module tap navigates | 1. Expand a unit 2. Tap a module row | Navigates to Course Module screen for that module |
| DU02-17 | Locked unit tap | 1. Unit with `isAccessible = false` 2. Tap tile | `onPracticeTap` fires (subscription/practice flow) |
| DU02-18 | Divider between expanded rows | 1. Expand a unit | Thin divider line separates tile header from module list |
| DU02-19 | Collapse chevron | 1. Expand then collapse a unit | Chevron rotates and modules list hides |

---

## TC-DU03 – Course Module View (Screen 3 & 4)

| ID | Scenario | Steps | Expected Result |
|----|----------|-------|-----------------|
| DU03-01 | Top bar label | 1. Navigate to a module | Top bar shows "የሞጁ ዝርዝር" (Module Detail) |
| DU03-02 | Back navigation | 1. Tap ← in top bar | Returns to Course Unit screen |
| DU03-03 | Page title | 1. Open module view | "Duolingo English Test" shown as large bold heading below top bar |
| DU03-04 | Loading spinner | 1. Open module on slow network | Circular spinner shown while lessons load |
| DU03-05 | Green section header renders | 1. Wait for lessons to load | Green collapsible card shown with "UNIT · MODULE DETAIL" small label + module name |
| DU03-06 | Module name in header | 1. Open module 1.1 | Header shows "1.1 Introduction" as large white bold text |
| DU03-07 | Module name – screen 4 | 1. Open module 1.2 | Header shows "1.2 How Scoring Works" |
| DU03-08 | Header initially expanded | 1. Open any module | Green header card is expanded by default showing progress row |
| DU03-09 | Progress "0% ትምፀና" in header | 1. Open module | "0% ትምፀና" text visible inside expanded header |
| DU03-10 | Lesson count badge | 1. Open module with 3 lessons | "0/3" badge shown inside green header |
| DU03-11 | Lesson count badge – 2 | 1. Open module with 2 lessons | "0/2" badge shown |
| DU03-12 | Header collapse toggle | 1. Tap the chevron/button on header | Green header collapses hiding progress row |
| DU03-13 | Lessons listed | 1. Wait for load | Lesson cards appear below header |
| DU03-14 | Lesson count matches API | 1. Open module 1.1 | 3 lesson cards shown (1.1.1, 1.1.2, 1.1.3) |
| DU03-15 | Background color | 1. Open module view | Page background is light grey (#F7F7F7) |

---

## TC-DU04 – Course Lesson Tile

| ID | Scenario | Steps | Expected Result |
|----|----------|-------|-----------------|
| DU04-01 | Lesson card renders | 1. Open module with lessons | White rounded card for each lesson with shadow |
| DU04-02 | Thumbnail area | 1. Observe a lesson card | Thumbnail shown on left; if SVG asset exists it is displayed; else green placeholder |
| DU04-03 | Lesson title | 1. Observe card | Lesson title (e.g., "1.1.1 Overview of the DET Test") shown in bold |
| DU04-04 | Duration row | 1. Observe card | Clock icon + "0 ደቂቃ" text shown below title |
| DU04-05 | Radio indicator | 1. Observe top-right of lesson card | Empty circle (radio) shown on right, unchecked |
| DU04-06 | Green "Play" button | 1. Observe bottom of lesson card | Full-width green (#58CC02) button with play icon and text |
| DU04-07 | Button label | 1. Open app in Amharic | Button shows "ዝይም አጣለት" (localized play_video key) |
| DU04-08 | Button label – English | 1. Open app in English | Button shows "Play Video" |
| DU04-09 | Free lesson tap | 1. Tap play button on FREE lesson | Navigates to course lesson detail view |
| DU04-10 | Paid lesson – no subscription | 1. Tap play on PAID lesson (no subscription) | Navigates to Duolingo subscription screen |
| DU04-11 | Paid lesson – subscribed | 1. Tap play on PAID lesson with active subscription | Navigates to course lesson detail view |
| DU04-12 | Placeholder for missing thumbnail | 1. Lesson with null/empty thumbnail | Green placeholder box with play-circle icon shown |
| DU04-13 | Card spacing | 1. Observe multiple lesson cards | Cards have 12px bottom margin; not touching each other |
| DU04-14 | Long lesson title | 1. Lesson title > 60 chars | Title wraps to max 3 lines then ellipsis |

---

## TC-DU05 – Cross-Cutting / Regression

| ID | Scenario | Steps | Expected Result |
|----|----------|-------|-----------------|
| DU05-01 | Full flow | Course Catalog → Duolingo tile → Unit view → expand unit → tap module → Module view | All 4 screens render correctly; back stack intact |
| DU05-02 | No viewmodel changes | 1. Run app and navigate full flow | All API calls, navigation, and state management work as before |
| DU05-03 | Assets bundled (cold start) | 1. Stop and restart app | `7.1-det-course-01.svg` in banner renders; no asset-not-found errors |
| DU05-04 | Locale switch | 1. Switch to English then Amharic; navigate to all 4 screens | No `???` placeholders; all strings translate correctly |
| DU05-05 | No bgDecoration / gradient | 1. Open any of the 4 screens | Only flat white or #F7F7F7 backgrounds; no gradient decoration |
| DU05-06 | Other course types unaffected | 1. Navigate to IELTS course | IELTS unit/module screens still render with magenta/red branding |

---

*End of Duolingo course section manual test document.*


## TC-DU06 – Per-Lesson SVG Thumbnails

| ID | Scenario | Steps | Expected Result |
|----|----------|-------|-----------------|
| DU06-01 | Unit 1 · Module 1 · Lesson 1 | 1. Navigate to Module 1.1 · Lesson 1 card | Thumbnail shows `7.3-module-lessons-01.svg` (checklist illustration) |
| DU06-02 | Unit 1 · Module 1 · Lesson 2 | 1. Navigate to Module 1.1 · Lesson 2 card | Thumbnail shows `7.3-module-lessons-02.svg` (target/goal illustration) |
| DU06-03 | Unit 1 · Module 1 · Lesson 3 | 1. Navigate to Module 1.1 · Lesson 3 card | Thumbnail shows `7.3-module-lessons-03.svg` (landscape/path illustration) |
| DU06-04 | Unit 1 · Module 2 · Lesson 1 | 1. Navigate to Module 1.2 · Lesson 1 card | Thumbnail shows `lessons/1-2-1-det-subscores.svg` (gauge/speedometer illustration) |
| DU06-05 | Unit 1 · Module 2 · Lesson 2 | 1. Navigate to Module 1.2 · Lesson 2 card | Thumbnail shows `lessons/1-2-2-scoring-details.svg` (bar-chart illustration) |
| DU06-06 | Unit 2 · Module 1 · Lessons | 1. Open modules under Unit 2 | Lessons show `2-1-1-comprehension.svg` and `2-1-2-literacy.svg` respectively |
| DU06-07 | Unit 2 · Module 2 · Lessons | 1. Open Module 2.2 | Lessons show `2-2-1-production.svg` and `2-2-2-conversation.svg` respectively |
| DU06-08 | No two lessons share the same SVG | 1. Open any module with 2+ lessons | Each lesson card shows a **different** illustration |
| DU06-09 | Fallback for unmapped lesson | 1. If backend adds a lesson with no asset map entry | Green placeholder icon shown (no crash) |
| DU06-10 | Thumbnail dimensions | 1. Inspect any lesson card thumbnail | Image is 72×60 px, `BoxFit.cover`, rounded 10px corners |
| DU06-11 | unitSortOrder resolved correctly | 1. Open Unit 3 (Listening) → Module 3.1 | Lessons show `3-1-1-listen-and-type-introduction.svg` and `3-1-2-essential-tips-and-strategies.svg` |
| DU06-12 | No cycling behaviour | 1. Open a module with 3 lessons | Thumbnails are NOT repeated/cycled — each shows its own unique SVG |

---

*End of Duolingo lesson thumbnail test cases.*


## TC-DU07 – Units 2, 3, and 4 Module Screens & Practice Action Buttons

| ID | Scenario | Steps | Expected Result |
|----|----------|-------|-----------------|
| DU07-01 | 2.1 Understanding (Header) | 1. Open Unit 2 -> Module 2.1 | Header shows "UNIT 2 · MODULE 2.1", "2.1 Understanding", "0/2" count badge |
| DU07-02 | 2.1 Understanding (Thumbnails) | 1. Observe lessons in Module 2.1 | Lesson 2.1.1 shows open book comprehension illustration (`2-1-1-comprehension.svg`), Lesson 2.1.2 shows literacy illustration (`2-1-2-literacy.svg`) |
| DU07-03 | 2.1 Single play button | 1. Observe buttons on 2.1 lessons | Both lessons show single full-width green "ቪዲዮ ይመልከቱ" button |
| DU07-04 | 2.2 Expression (Header) | 1. Open Unit 2 -> Module 2.2 | Header shows "UNIT 2 · MODULE 2.2", "2.2 Expression", "0/2" count badge |
| DU07-05 | 2.2 Expression (Thumbnails) | 1. Observe lessons in Module 2.2 | Lesson 2.2.1 shows megaphone (`2-2-1-production.svg`), Lesson 2.2.2 shows speech bubbles (`2-2-2-conversation.svg`) |
| DU07-06 | 3.1 Listen and Type (Header) | 1. Open Unit 3 -> Module 3.1 | Header shows "UNIT 3 · MODULE 3.1", "3.1 Listen and Type", "0/2" count badge |
| DU07-07 | 3.1.1 Introduction Actions | 1. Observe 3.1.1 lesson card | Shows single full-width green "ቪዲዮ ይመልከቱ" button |
| DU07-08 | 3.1.2 Dual Action Buttons | 1. Observe 3.1.2 lesson card | Shows two side-by-side buttons: Green "ቪዲዮ ይመልከቱ" + White "የልምምድ ፈተና" |
| DU07-09 | 3.1.2 Practice Tap | 1. Tap "የልምምድ ፈተና" on 3.1.2 | Navigates to Course Practice view for the lesson |
| DU07-10 | 3.2 Interactive Listening (Header) | 1. Open Unit 3 -> Module 3.2 | Header shows "UNIT 3 · MODULE 3.2", "3.2 Interactive Listening", "0/4" count badge |
| DU07-11 | 3.2.1 Introduction Single Button | 1. Observe 3.2.1 card | Shows single play button |
| DU07-12 | 3.2.2 - 3.2.4 Dual Action Buttons | 1. Observe 3.2.2, 3.2.3, and 3.2.4 cards | All three show dual buttons: "ቪዲዮ ይመልከቱ" (play) and "የልምምድ ፈተና" (practice) |
| DU07-13 | 4.1 Read and Complete (Header) | 1. Open Unit 4 -> Module 4.1 | Header shows "UNIT 4 · MODULE 4.1", "4.1 Read and Complete", "0/3" count badge |
| DU07-14 | 4.1.1 Dual Action Buttons | 1. Observe 4.1.1 card | Shows dual buttons: Green play button + Practice test button |
| DU07-15 | 4.1.2 & 4.1.3 Single Play Button | 1. Observe 4.1.2 and 4.1.3 cards | Both show single full-width green play button |
| DU07-16 | 4.2 Read and Select (Header) | 1. Open Unit 4 -> Module 4.2 | Header shows "UNIT 4 · MODULE 4.2", "4.2 Read and Select", "0/3" count badge |
| DU07-17 | 4.2.1 Single Play Button | 1. Observe 4.2.1 card | Shows single play button |
| DU07-18 | 4.2.2 & 4.2.3 Dual Action Buttons | 1. Observe 4.2.2 and 4.2.3 cards | Both show dual buttons: Green play button + Practice test button |
| DU07-19 | Thumbnails match design | 1. Verify 4.2.1, 4.2.2, and 4.2.3 | Word cards (`4-2-1-read-and-select-introduction.svg`), book (`4-2-2-mastering-your-vocabulary.svg`), and magnifying glass (`4-2-3-how-to-spot-fake-words.svg`) render clearly |

---

*End of Units 2, 3, and 4 manual test document.*


## TC-DU08 – Screens 7.9 (4.1 Read and Complete) & 7.10 (4.2 Read and Select)

| ID | Scenario | Steps | Expected Result |
|----|----------|-------|-----------------|
| DU08-01 | 4.1 Top Bar & Title | 1. Navigate to Duolingo course -> Unit 4 -> Module 4.1 | Top bar shows boxed back button, centered "የሞጁል ዝርዝር", and "Duolingo English Test" heading |
| DU08-02 | 4.1 Green Module Header | 1. Observe Module 4.1 header card | Card shows "UNIT 4 · MODULE 4.1", "4.1 Read and Complete", "0% ተጠናቋል", and "0/3" progress counter pill |
| DU08-03 | 4.1.1 Card & Dual Buttons | 1. Observe Lesson 4.1.1 | Thumbnail shows `4-1-1-read-and-complete-introduction.svg`, title "4.1.1 Read and Complete: Introduction", and **dual buttons**: "ቪዲዮ ይመልከቱ" (green) + "የልምምድ ፈተና" (white) |
| DU08-04 | 4.1.2 Card & Single Button | 1. Observe Lesson 4.1.2 | Thumbnail shows `4-1-2-essential-tips-and-strategies.svg`, title "4.1.2 Essential Tips and Strategies", and single full-width green "ቪዲዮ ይመልከቱ" button |
| DU08-05 | 4.1.3 Card & Single Button | 1. Observe Lesson 4.1.3 | Thumbnail shows `4-1-3-mastering-context-and-grammar.svg`, title "4.1.3 Mastering Context and Grammar", and single full-width green "ቪዲዮ ይመልከቱ" button |
| DU08-06 | 4.1.1 Practice Button Tap | 1. Tap "የልምምድ ፈተና" on Lesson 4.1.1 | Navigates to Course Practice view for 4.1.1 |
| DU08-07 | 4.1 Video Button Tap | 1. Tap "ቪዲዮ ይመልከቱ" on any 4.1 lesson | Navigates to video detail screen (or subscription sheet if unsubscribed) |
| DU08-08 | 4.2 Top Bar & Title | 1. Navigate to Duolingo course -> Unit 4 -> Module 4.2 | Top bar shows boxed back button, centered "የሞጁል ዝርዝር", and "Duolingo English Test" heading |
| DU08-09 | 4.2 Green Module Header | 1. Observe Module 4.2 header card | Card shows "UNIT 4 · MODULE 4.2", "4.2 Read and Select", "0% ተጠናቋል", and "0/3" progress counter pill |
| DU08-10 | 4.2.1 Card & Single Button | 1. Observe Lesson 4.2.1 | Thumbnail shows `4-2-1-read-and-select-introduction.svg`, title "4.2.1 Read and Select: Introduction", and single full-width green "ቪዲዮ ይመልከቱ" button |
| DU08-11 | 4.2.2 Card & Dual Buttons | 1. Observe Lesson 4.2.2 | Thumbnail shows `4-2-2-mastering-your-vocabulary.svg`, title "4.2.2 Mastering Your Vocabulary", and **dual buttons**: "ቪዲዮ ይመልከቱ" (green) + "የልምምድ ፈተና" (white) |
| DU08-12 | 4.2.3 Card & Dual Buttons | 1. Observe Lesson 4.2.3 | Thumbnail shows `4-2-3-how-to-spot-fake-words.svg`, title "4.2.3 How to Spot Fake Words", and **dual buttons**: "ቪዲዮ ይመልከቱ" (green) + "የልምምድ ፈተና" (white) |
| DU08-13 | 4.2 Practice Button Tap | 1. Tap "የልምምድ ፈተና" on 4.2.2 or 4.2.3 | Navigates to Course Practice view for the respective lesson |
| DU08-14 | Peach Background & Badge | 1. Inspect any 4.1 or 4.2 thumbnail | Rounded peach background `#FFEBD1` with top-right play badge rendered without clipping |
| DU08-15 | Radio Indicator | 1. Observe top-right of all lesson cards | Circle outline (radio indicator) is unselected and aligned with lesson title |

---

*End of Screen 7.9 and 7.10 manual test document.*


## TC-DU09 – Modules 4.3 through 6.4 & Screen 7.20 (DET Practice Test Start)

| ID | Scenario | Steps | Expected Result |
|----|----------|-------|-----------------|
| DU09-01 | 4.3 Fill in the Blanks | 1. Open Module 4.3 | Header shows "UNIT 4 · MODULE 4.3", "0/2". 4.3.1 has single video button; 4.3.2 has dual action buttons (Video + Practice) |
| DU09-02 | 4.4 Interactive Reading | 1. Open Module 4.4 | Header shows "UNIT 4 · MODULE 4.4", "0/6". 4.4.1 and 4.4.2 show dual action buttons; 4.4.3 to 4.4.6 show single video button |
| DU09-03 | 5.1 Write About the Photo | 1. Open Module 5.1 | Header shows "UNIT 5 · MODULE 5.1", "0/2". 5.1.1 is single play; 5.1.2 has dual action buttons |
| DU09-04 | 5.2 Writing Sample | 1. Open Module 5.2 | Header shows "UNIT 5 · MODULE 5.2", "0/2". Both 5.2.1 and 5.2.2 have dual action buttons |
| DU09-05 | 5.3 Interactive Writing | 1. Open Module 5.3 | Header shows "UNIT 5 · MODULE 5.3", "0/3". 5.3.2 has dual action buttons; 5.3.1 and 5.3.3 are single play |
| DU09-06 | 6.1 Speak About the Photo | 1. Open Module 6.1 | Header shows "UNIT 6 · MODULE 6.1", "0/2". 6.1.1 is single play; 6.1.2 has dual action buttons |
| DU09-07 | 6.2 Read Then Speak | 1. Open Module 6.2 | Header shows "UNIT 6 · MODULE 6.2", "0/2". Both 6.2.1 and 6.2.2 have dual action buttons |
| DU09-08 | 6.3 Speaking Sample | 1. Open Module 6.3 | Header shows "UNIT 6 · MODULE 6.3", "0/2". Both 6.3.1 and 6.3.2 have dual action buttons |
| DU09-09 | 6.4 Interactive Speaking | 1. Open Module 6.4 | Header shows "UNIT 6 · MODULE 6.4", "0/3". 6.4.1 is single play; 6.4.2 and 6.4.3 have dual action buttons |
| DU09-10 | 7.20 Practice Test Top Bar | 1. Tap "የልምምድ ፈተና" from any lesson | Opens Screen 7.20 with white top bar, boxed back button, and centered "የልምምድ ፈተና" |
| DU09-11 | 7.20 Practice Test Banner | 1. Observe Screen 7.20 banner | Green rounded card displays `7.20-det-practice-test-start-01.svg` centered with shadow |
| DU09-12 | 7.20 Practice Test Title | 1. Observe text under banner | Practice category title (e.g. "Listen and Type") displayed in bold 18px |
| DU09-13 | 7.20 Start Practice Button | 1. Observe bottom of Screen 7.20 | Full-width green button with "ምዘና ይጀምሩ" / Start Assessment |
| DU09-14 | 7.20 Start Practice Tap | 1. Tap start button on Screen 7.20 | Advances into first practice question of the session |
| DU09-15 | 7.20 Exit Sheet | 1. Tap back button on Screen 7.20 | Opens `CancelPracticeSheet` modal dialog to confirm leaving |

---

*End of Modules 4.3–6.4 and Screen 7.20 manual test document.*


## TC-DU10 – English Proficiency Course Catalog & Unit 5.3 Follow-up Task Thumbnail

| ID | Scenario | Steps | Expected Result |
|----|----------|-------|-----------------|
| DU10-01 | Catalog Floating Back Button | 1. Open the English Proficiency Course Catalog view | Top bar shows a floating white rounded button (44×44, r=14) with magenta arrow (`#9A288D`); no top bar title |
| DU10-02 | Catalog Title & Subtitle | 1. Inspect typography below back button | Shows bold title "የእንግሊዝኛ ብቃት ፈተናዎች" (24px, w800, `#1E132D`) and subtitle "የሚፈልጉትን ፈተና ይምረጡ እና መዘጋጀት ይጀምሩ" (13px, `#888899`) |
| DU10-03 | Duolingo English Test Card Styling | 1. Inspect first course card | Vibrant green background (`#58CC02`), 22px border radius with 4px 3D bevel (`#46A302`), white squircle container with lime circular disc (`#D7FFB8`), purple-screen laptop (`#8E2483`), clock badge (`#E8644A`), bold white "Duolingo English\nTest" text, and white chevron |
| DU10-04 | IELTS Card Styling | 1. Inspect second course card | Solid red background (`#E4002B`), 22px border radius with 4px 3D bevel (`#A8001F`), white squircle container with pink circular disc (`#FFE1E6`), exam paper with red header, navy headphones (`#2E2A6B`), red pencil, bold white "IELTS" text, and white chevron |
| DU10-05 | English For Professionals Card Styling | 1. Inspect third course card | Soft lavender background (`#F4E3F2`), 22px border radius with 4px 3D bevel (`#E3C6DF`), white squircle container with lilac circular disc (`#EBCDE8`), purple briefcase (`#6A1A62`) with gold clasp, orange speech bubble with dots (`#FF8A65`), bold dark text "English For\nProfessionals" (`#2A1830`), and dark chevron |
| DU10-06 | Card Navigation - Duolingo | 1. Tap Duolingo card | Navigates to Duolingo course unit overview |
| DU10-07 | Card Navigation - IELTS | 1. Tap IELTS card | Navigates to IELTS course view (or practice sheet if locked) |
| DU10-08 | Follow-up Task Thumbnail Fix | 1. Navigate to Duolingo Course -> Unit 5 -> Module 5.3 (Interactive Writing)<br>2. Inspect Lesson 5.3.3 "The Follow-up Task" | Thumbnail displays `5-3-3-the-follow-up-task.svg` (desktop monitor with pencil, clock, and document) on peach rounded background with play badge |
| DU10-09 | Unit 5 & 6 Dedicated Lesson Assets | 1. Inspect modules in Unit 5 and Unit 6 | All lessons display their unique, dedicated SVGs (`5-1-x`, `5-2-x`, `5-3-x`, `6-1-x`, `6-2-x`, `6-3-x`, `6-4-x`) rather than fallback generic thumbnails |

---

*End of English Proficiency Course Catalog and Unit 5/6 manual test document.*
