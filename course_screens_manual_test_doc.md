# Course Screens – Manual Test Document

> Generated for **YIMARU Mobile App** · Course UI Redesign  
> Screens covered: Course Home, Course Catalog, Course Unit, Course Module

---

## Test Environment

| Field | Value |
|-------|-------|
| Platform | Android / iOS |
| App state | Logged-in user (valid session) |
| Network | Connected (API accessible) |
| Test data | At least one CourseCatalog, CourseUnit, CourseModule, and CourseLesson available in backend |

---

## TC-C01 – Course Home Screen

| ID | Scenario | Steps | Expected Result |
|----|----------|-------|-----------------|
| C01-01 | Screen loads correctly | 1. Navigate to the **Course** tab from bottom nav | ProfileAppBar is shown at top with user name and notification bell; "ኮርሶች" title and subtitle rendered below |
| C01-02 | Course card layout | 1. Open Course tab and observe card | Card shows magenta left-accent stripe, "English Proficiency Exams" title, description text, green "ኮርሱን ይጀምሩ" button, and certificate SVG illustration on the right |
| C01-03 | SVG illustration renders | 1. Open Course tab, observe right side of card | `course_exam_certificate.svg` is displayed inside a light-purple background box without errors |
| C01-04 | Start-course button tap | 1. Tap the green "ኮርሱን ይጀምሩ" button on the card | Navigates to **Course Catalog** screen |
| C01-05 | Card tap navigates | 1. Tap anywhere on the course card | Same as C01-04 – navigates to Course Catalog |
| C01-06 | Notification icon | 1. Tap the notification bell in ProfileAppBar | Navigates to Notification view |
| C01-07 | Locale – Amharic | 1. Switch app language to Amharic 2. Open Course tab | All text shows in Amharic (ኮርሶች, ኮርሱን ይጀምሩ) |
| C01-08 | Locale – English | 1. Switch app language to English 2. Open Course tab | All text shows in English (Courses, Start Course) |
| C01-09 | Background colour | 1. Open Course tab | Screen background is light grey (#F8F8FC), not white or gradient |

---

## TC-C02 – Course Catalog Screen

| ID | Scenario | Steps | Expected Result |
|----|----------|-------|-----------------|
| C02-01 | Loading state | 1. Navigate to Course Catalog | A circular progress spinner is shown while catalogs load |
| C02-02 | Catalogs listed | 1. Wait for load to finish | Duolingo English Test, IELTS, and English For Professionals tiles appear as cards |
| C02-03 | Back button | 1. Tap the back arrow (←) in the top bar | Returns to Course Home screen |
| C02-04 | Duolingo tile color | 1. Observe Duolingo tile | Left stripe and chevron are **green** (#58CC02); background box is light green; `course_duolingo_laptop.svg` illustration shown |
| C02-05 | IELTS tile color | 1. Observe IELTS tile | Left stripe and chevron are **red** (#E53935); background box is light red; `course_exam_certificate.svg` illustration shown |
| C02-06 | Other category tile color | 1. Observe "English For Professionals" tile (if present) | Left stripe and chevron use **magenta** (#9A288D); fallback icon displayed |
| C02-07 | Tile tap – accessible course | 1. Ensure catalog.access.isAccessible = true 2. Tap the tile | Navigates to **Course Unit** screen for selected catalog |
| C02-08 | Tile tap – locked course | 1. Ensure catalog.access.isAccessible = false 2. Tap the tile | Navigates to practice / subscription flow (onPracticeTap called) |
| C02-09 | Tile chevron visible | 1. Open Catalog screen | Chevron icon (›) visible on the right of each tile |
| C02-10 | No expansion on tap | 1. Tap any tile | Tile does **not** expand inline; it navigates away |
| C02-11 | Empty list | 1. Simulate empty catalogs from API | Empty ListView shown (no crash) |
| C02-12 | Screen title | 1. Open Catalog screen | Top bar title and page heading both display the correct proficiency label |

---

## TC-C03 – Course Unit Screen

| ID | Scenario | Steps | Expected Result |
|----|----------|-------|-----------------|
| C03-01 | Loading state | 1. Navigate to Course Unit screen | Circular progress indicator shown while units are being fetched |
| C03-02 | Units listed | 1. Wait for load | List of CourseUnit expansion tiles shown with colored circle icons, titles, "0% ሆነ" subtitle, and progress bar |
| C03-03 | Back button | 1. Tap the ← button in top bar | Returns to Course Catalog screen |
| C03-04 | Top bar title | 1. Open Course Unit | Top bar shows catalog name (e.g., "Duolingo English Test") |
| C03-05 | Header card rendered | 1. Open Course Unit | A white card shows catalog name, "Course Detail" label, and a green progress bar at 0% |
| C03-06 | Unit icon color cycling | 1. Observe multiple unit tiles | Each unit displays a different color circle icon (green, blue, orange, red…) cycling through the palette |
| C03-07 | Unit expansion | 1. Tap on a unit tile | Tile expands to reveal module list below; a loading spinner appears briefly |
| C03-08 | Module list loads on expand | 1. Expand a unit for the first time | API call fires; modules appear as `CourseModuleTileSmall` rows |
| C03-09 | No duplicate API call | 1. Collapse then re-expand a unit | No duplicate API call is made (modules were cached on first expand) |
| C03-10 | Module tap navigates | 1. Expand a unit 2. Tap a module row | Navigates to **Course Module** screen for that module |
| C03-11 | Locked unit tap | 1. Unit with isAccessible = false 2. Tap anywhere on the tile | Navigates to practice/subscription flow (onPracticeTap) |
| C03-12 | Progress bar styling | 1. Observe the progress bar in each unit | Bar background is light grey; active fill matches the unit's color |

---

## TC-C04 – Course Module Screen

| ID | Scenario | Steps | Expected Result |
|----|----------|-------|-----------------|
| C04-01 | Loading state | 1. Navigate to Course Module screen | Circular progress spinner shown while lessons load |
| C04-02 | Module section header | 1. Wait for load | Section header card rendered: magenta circle icon, "Module Detail" label, module name, progress bar at 0/0 |
| C04-03 | Lessons listed | 1. Observe lesson list | `CourseLessonTile` cards appear below the section header |
| C04-04 | Lesson tile layout | 1. Inspect a lesson tile | Thumbnail on left; title and duration on right; green "ትምህርቱን ይጀምሩ" / "Play Video" button below |
| C04-05 | Thumbnail shows image | 1. Lesson with valid thumbnail URL | Thumbnail image loads via CachedNetworkImage; rounded corners |
| C04-06 | Thumbnail placeholder | 1. Lesson with no/invalid thumbnail | Grey placeholder box with a play-circle icon displayed |
| C04-07 | Play Video button tap | 1. Tap "Play Video" on a FREE lesson | Navigates to lesson detail view |
| C04-08 | Play Video – locked lesson | 1. Tap "Play Video" on a PAID lesson (no subscription) | Navigates to subscription screen |
| C04-09 | Practice button shown conditionally | 1. Lesson with hasPractice = true | Magenta-bordered "Practice Test" button appears beside the play button |
| C04-10 | Practice button hidden | 1. Lesson with hasPractice = false | Only the play button is shown; no practice button |
| C04-11 | Practice button tap | 1. Tap "Practice Test" | Navigates to lesson practice view |
| C04-12 | Back button | 1. Tap ← in top bar | Returns to Course Unit screen |
| C04-13 | Top bar catalog name | 1. Open Module screen | Top bar shows catalog name, not module name |
| C04-14 | Section label text | 1. Open Module screen | "Module Detail" label shown above catalog title in magenta |
| C04-15 | Empty lesson list | 1. Simulate no lessons from API | Section header shown; lesson list is empty (no crash) |
| C04-16 | Duolingo subscription gate | 1. Log in without Duolingo subscription 2. Tap paid Duolingo lesson | Navigates to Duolingo subscription view |
| C04-17 | IELTS subscription gate | 1. Log in without IELTS subscription 2. Tap paid IELTS lesson | Navigates to IELTS subscription view |

---

## TC-C05 – Cross-Cutting / Regression

| ID | Scenario | Steps | Expected Result |
|----|----------|-------|-----------------|
| C05-01 | Full navigation flow | Course tab → Catalog → Unit → expand unit → Module screen | All transitions work; back stack is correct at each step |
| C05-02 | No `bgDecoration` used | 1. Open any course screen | No gradient background; screens use flat #F8F8FC background |
| C05-03 | ViewModels unchanged | 1. Run existing unit tests for viewmodels | All viewmodel tests pass (no structural changes were made) |
| C05-04 | Dark-mode / contrast | 1. Enable device dark mode and open course screens | Text remains readable (use system theme test if applicable) |
| C05-05 | Long catalog/unit name | 1. Backend returns name > 40 chars | Name truncated with ellipsis; no overflow or layout break |
| C05-06 | No `SmallAppBar` or `bgDecoration` | 1. Inspect layout of any new course screen | Old widgets (`SmallAppBar`, `CourseModuleBanner`, `bgDecoration`) are **not** present in new screens |
| C05-07 | SVG assets bundled | 1. Cold-start app (stop then run) | Both `course_exam_certificate.svg` and `course_duolingo_laptop.svg` render without error |
| C05-08 | Locale keys exist | 1. Switch to English then Amharic on each screen | No `???` or missing-key placeholders appear |

---

*End of manual test document.*



---

## TC-PR01 – Profile Screen (Main)

| ID | Scenario | Steps | Expected Result |
|----|----------|-------|-----------------|
| PR01-01 | Profile screen layout | 1. Log in → tap the "መልካሚ" (Profile) tab at the bottom | Screen shows: soft `#FAF8FC` background, notification bell (top-right), circular avatar, user name, `"… →"` link, 2×2 card grid, red outlined logout button |
| PR01-02 | Notification bell tap | 1. Tap the notification bell icon | Navigates to Notification screen |
| PR01-03 | Avatar / image picker | 1. Tap the camera-icon overlay on the avatar | Image-picker dialog appears with Camera / Gallery options |
| PR01-04 | View profile link | 1. Tap the `"→"` subtitle link below the user name | Navigates to Profile Detail screen |
| PR01-05 | Subscriptions card | 1. Tap the yellow "የእኔ ምዝገባዎች" card | Navigates to My Subscription screen |
| PR01-06 | Progress card | 1. Tap the green "የእኔ እድገት" card | Navigates to My Progress screen |
| PR01-07 | Account & Privacy card | 1. Tap the pink "መልይ እና ግላዊነት" card | Navigates to Account & Privacy screen |
| PR01-08 | Support card | 1. Tap the cyan "ድጋፍ" card | Navigates to Support screen |
| PR01-09 | Logout button styling | 1. Observe the logout button | Button is **outlined** (red border, faint red fill), NOT a filled button |
| PR01-10 | Logout tap | 1. Tap logout button | Confirmation dialog appears; confirming logs the user out and redirects to Login |
| PR01-11 | iOS subscription card hidden | 1. Run app on an **iOS** device | Subscription card is **not** visible (Platform.isIOS guard) |
| PR01-12 | Scroll behaviour | 1. On a small device, scroll the profile page | Page scrolls smoothly; grid cards and logout button remain accessible |

---

## TC-PR02 – Account & Privacy Screen ("መልይ እና ግላዊነት")

| ID | Scenario | Steps | Expected Result |
|----|----------|-------|-----------------|
| PR02-01 | Screen layout | 1. Tap Account & Privacy card from Profile | Screen shows white background, magenta back arrow, bold title "Account and Privacy", two sections |
| PR02-02 | Section headers | 1. Observe section labels | "App Settings" and "Legal and Information" section headers rendered in bold dark text |
| PR02-03 | Language tile display | 1. Observe the language tile | Tile shows globe icon (cyan bg), language name in a chip/badge on the right, and a chevron |
| PR02-04 | Change language | 1. Tap the language tile | Navigates to Language selection screen |
| PR02-05 | Terms & Conditions | 1. Tap "Terms & Conditions" list tile | Navigates to Terms & Conditions screen |
| PR02-06 | Privacy Policy | 1. Tap "Privacy Policy" list tile | Navigates to Privacy Policy screen |
| PR02-07 | Back navigation | 1. Tap the back arrow | Returns to Profile screen |
| PR02-08 | Icon colours | 1. Observe all list-tile icons | Globe → cyan, Terms → yellow/amber, Privacy → pink; backgrounds match design |

---

## TC-PR03 – Support / Help Screen ("እርዳታ ይፈልጋሉ?")

| ID | Scenario | Steps | Expected Result |
|----|----------|-------|-----------------|
| PR03-01 | Screen layout | 1. Tap Support card from Profile | Screen shows white background, magenta back arrow, bold title "Need Help?", 5 coloured list tiles |
| PR03-02 | Call Support tile | 1. Observe first tile | Pink/rose bg, phone icon; title = call support; tapping navigates to Call Support screen |
| PR03-03 | Telegram Support tile | 1. Observe second tile | Blue/cyan bg, Telegram icon; tapping navigates to Telegram Support screen |
| PR03-04 | In-App Support tile | 1. Observe third tile | Yellow/amber bg, chat icon; tapping navigates to In-App Support screen |
| PR03-05 | FAQs tile | 1. Observe fourth tile | Green bg, help/question icon; tapping navigates to FAQs screen |
| PR03-06 | App Rating tile | 1. Observe fifth tile | Magenta/purple bg, star icon; tapping navigates to App Rating screen |
| PR03-07 | Chevron on each tile | 1. Observe trailing side of all tiles | Each tile has a right-chevron arrow in the tile's accent colour |
| PR03-08 | Back navigation | 1. Tap the back arrow | Returns to Profile screen |
| PR03-09 | Scroll (many items) | 1. On a small device | All 5 tiles scroll smoothly if the screen is short |

---

*End of profile screen manual test cases.*


---

## TC-I01 – IELTS Course Unit Screen

| ID | Scenario | Steps | Expected Result |
|----|----------|-------|-----------------|
| I01-01 | IELTS Course Screen Layout | 1. From Catalog, tap "IELTS" card | Top bar shows back button and centered "የኮርስ ዝርዝር"; centered bold title "IELTS"; red hero banner (#E4002B) with headphones/book illustration; overall progress section; unit list |
| I01-02 | IELTS Hero Banner | 1. Observe hero banner | Banner has solid red background (#E4002B), renders `8.1-ielts-course-01.svg` cleanly, and shows white pill with red text "{N} UNITS" |
| I01-03 | Overall Progress Color | 1. Observe progress indicator | Progress percentage and linear progress bar use red theme color (#E4002B) |
| I01-04 | Unit Tile Colors and Icons | 1. Observe unit icons in collapsed state | Unit 1 has red circle with white flag; Unit 2 has navy circle with white microphone; Unit 3 has red circle with white headphones; Unit 4 has navy circle with white book |
| I01-05 | Unit Expansion | 1. Tap Unit 1 "Introduction to IELTS" | Expansion tile opens smoothly; shows sub-modules (1.1, 1.2, 1.3) with bookmark icon and trailing circular indicator |
| I01-06 | Back Navigation | 1. Tap top back button | Returns smoothly to Course Catalog view |

---

## TC-I02 – IELTS Module Detail Screen

| ID | Scenario | Steps | Expected Result |
|----|----------|-------|-----------------|
| I02-01 | IELTS Module Screen Layout | 1. From expanded Unit 1, tap Module 1.1 "Meet Your Instructor" | Top bar has back button and centered "የሞጁል ዝርዝር"; centered bold title "IELTS"; collapsible red module banner; list of lesson cards |
| I02-02 | Red Module Header Card | 1. Observe collapsible module card | Banner background is red (#E4002B); white text "UNIT 1 · MODULE 1.1" and "1.1 Meet Your Instructor"; progress bar with gold indicator; trailing collapse chevron |
| I02-03 | Lesson Thumbnail Resolution | 1. Inspect lesson thumbnails in Module 1.1 | Lesson 1.1.1 displays instructor illustration; Lesson 1.1.2 displays IELTS overview illustration |
| I02-04 | Single Play Button | 1. Observe buttons on lessons 1.1.1 and 1.1.2 | Full-width red play button (#E4002B) with white play icon and white text "ቪዲዮ አጫውት" |

---

## TC-I03 – IELTS Speaking Modules & Dual Action Buttons

| ID | Scenario | Steps | Expected Result |
|----|----------|-------|-----------------|
| I03-01 | Speaking Part 1 Lessons | 1. Open Unit 2, Module 2.2 "Speaking Part 1 Tutorial" | Lessons 2.2.1, 2.2.2, 2.2.3 display exact SVG thumbnails; single red play button |
| I03-02 | Dual Buttons on Example Lesson (2.2.4) | 1. Scroll to Lesson 2.2.4 "An Example for Part 1" | Card displays DUAL buttons: left button is red "ቪዲዮ አጫውት"; right button is white outlined "የልምምድ ፈተና" with red icon |
| I03-03 | Dual Buttons on Part 2 (2.3.4) | 1. Open Module 2.3; scroll to 2.3.4 "An Example for Part 2" | Displays DUAL action buttons (Play Video + Practice Test) |
| I03-04 | Dual Buttons on Part 3 (2.4.4) | 1. Open Module 2.4; scroll to 2.4.4 "An Example for Part 3" | Displays DUAL action buttons (Play Video + Practice Test) |
| I03-05 | Practice Test Tap | 1. Tap "የልምምድ ፈተና" on lesson 2.2.4 | Navigates to IELTS speaking course practice flow |
| I03-06 | Play Video Tap | 1. Tap "ቪዲዮ አጫውት" on any lesson | Navigates to video player or subscription paywall if locked |

---

## TC-I04 – Non-Regression & Theme Isolation

| ID | Scenario | Steps | Expected Result |
|----|----------|-------|-----------------|
| I04-01 | Duolingo Course Green Theme | 1. Navigate to Duolingo English Test from Catalog | Hero banner remains green (#58CC02); module cards and buttons remain gamified green; Duolingo SVGs load correctly |
| I04-02 | Asset Loading | 1. Inspect debug console when scrolling IELTS and Duolingo lessons | No `SvgPicture` asset missing errors or 404s |
| I04-03 | Font Consistency | 1. Check typography across all IELTS screens | Aeonik font family applied consistently to titles, subtitles, and button labels |

---

## TC-I05 – IELTS Listening Modules & Section Tutorials (Unit 3)

| ID | Scenario | Steps | Expected Result |
|----|----------|-------|-----------------|
| I05-01 | Module 3.2 Question Types | 1. Open Unit 3, Module 3.2 "Question Types"<br>2. Inspect Lesson 3.2.1 | Displays audio/question illustration thumbnail; single red play button (#E4002B) "ቪዲዮ አጫውት" |
| I05-02 | Module 3.4 Section 2 Tutorial & Dual Buttons | 1. Open Module 3.4 "Section 2 Tutorial"<br>2. Inspect Lessons 3.4.1 to 3.4.5<br>3. Inspect Lesson 3.4.6 "Examples for Section 2" | Lessons 3.4.1–3.4.5 show single red play button.<br>Lesson 3.4.6 displays DUAL action buttons: red "ቪዲዮ አጫውት" + white outlined "የልምምድ ፈተና" with red icon |
| I05-03 | Module 3.5 Section 3 Tutorial & Dual Buttons | 1. Open Module 3.5 "Section 3 Tutorial"<br>2. Inspect Lessons 3.5.1 to 3.5.4<br>3. Inspect Lesson 3.5.5 "Examples for Section 3" | Lessons 3.5.1–3.5.4 show single red play button.<br>Lesson 3.5.5 displays DUAL action buttons: red "ቪዲዮ አጫውት" + white outlined "የልምምድ ፈተና" with red icon |
| I05-04 | Module 3.6 Section 4 Tutorial & Dual Buttons | 1. Open Module 3.6 "Section 4 Tutorial"<br>2. Inspect Lessons 3.6.1 to 3.6.4<br>3. Inspect Lesson 3.6.5 "Examples for Section 4" | Lessons 3.6.1–3.6.4 show single red play button.<br>Lesson 3.6.5 displays DUAL action buttons: red "ቪዲዮ አጫውት" + white outlined "የልምምድ ፈተና" with red icon |
| I05-05 | Module 3.7 Listening Tips & Practice Button | 1. Open Module 3.7 "3.7 IELTS Listening Tips"<br>2. Inspect Lesson 3.7.1 "5 Tips for a Band 7+ in Listening" | Displays trophy with headphones SVG thumbnail; DUAL action buttons: red "ቪዲዮ አጫውት" + white outlined "የልምምድ ፈተና" |
| I05-06 | Listening Thumbnail Fidelity | 1. Check thumbnails across all Unit 3 lessons | Exact SVG illustrations render for radio, strategies puzzle, multiple choice, map/plan pinning, table completion, and headphones |

---

## TC-I06 – IELTS Reading Modules (Unit 4)

| ID | Scenario | Steps | Expected Result |
|----|----------|-------|-----------------|
| I06-01 | Module 4.1 Introduction to IELTS Reading | 1. Open Unit 4, Module 4.1 "Introduction to IELTS Reading"<br>2. Inspect Lesson 4.1.1 "Test Format" | Displays reading test format illustration; single red play button (#E4002B) "ቪዲዮ አጫውት" |
| I06-02 | Module 4.2 Skills to Work on for IELTS Reading | 1. Open Module 4.2 "Skills to Work on for IELTS Reading"<br>2. Inspect Lesson 4.2.1 | Displays magnifying glass reading SVG illustration; single red play button |
| I06-03 | Module 4.3 Passage 1 & Diagram Labelling Practice | 1. Open Module 4.3 "Strategies for Question Types in Passage 1"<br>2. Inspect Lessons 4.3.1 to 4.3.4<br>3. Inspect Lesson 4.3.5 "Example for Labelling a Diagram" | Lessons 4.3.1–4.3.4 show single red play button.<br>Lesson 4.3.5 displays DUAL action buttons (Play Video + Practice Test) |
| I06-04 | Module 4.5 Passage 3 Strategies & Question Types | 1. Open Module 4.5 "Strategies for Question Types in Passage 3"<br>2. Inspect Lessons 4.5.1 to 4.5.6 (Yes/No/Not Given, Summary Completion, Matching, Multiple Choice 1 & 2) | All 6 lessons render single full-width red play button (#E4002B) with white text and icon |
| I06-05 | Reading Thumbnail Fidelity | 1. Verify thumbnails in Module 4.3 and 4.5 | Exact SVG illustrations render for search strategy, question format cards, true/false comparison, sentence completion, diagram labelling, and multiple choice |

---

## TC-I07 – IELTS Speaking Tips (Module 2.6)

| ID | Scenario | Steps | Expected Result |
|----|----------|-------|-----------------|
| I07-01 | Module 2.6 Speaking Tips Layout | 1. Open Unit 2, Module 2.6 "2.6 IELTS Speaking Tips"<br>2. Inspect Lesson 2.6.1 "5 Tips for a Band 7+ in Speaking" | Header shows red collapsible banner "UNIT 2 · MODULE 2.6"; Lesson 2.6.1 shows golden trophy with microphone illustration; single red play button |
| I07-02 | Overall Unit & Module Visual Polish | 1. Inspect top bar and layout across Units 2, 3, and 4 | Top bar centered with "የሞጁል ዝርዝር"; centered "IELTS" heading; Aeonik typography applied cleanly without overflows |

---

## TC-I08 – IELTS Writing Modules & Dual Action Buttons (Unit 5)

| ID | Scenario | Steps | Expected Result |
|----|----------|-------|-----------------|
| I08-01 | Module 5.1 Introduction to IELTS Writing | 1. Open Unit 5, Module 5.1 "Introduction to IELTS Writing"<br>2. Inspect Lessons 5.1.1 and 5.1.2 | Both lessons show single red play button (#E4002B) "ቪዲዮ አጫውት"; test format and rubric SVG illustrations rendered cleanly |
| I08-02 | Module 5.2 Task 1 Writing Single Buttons | 1. Open Module 5.2 "Task 1 Writing"<br>2. Inspect Lessons 5.2.1, 5.2.2, 5.2.3, 5.2.4 | Single red play button; line chart, pie chart, framework, and checklist illustrations display properly |
| I08-03 | Module 5.2 Task 1 Writing Dual Action Buttons | 1. In Module 5.2, inspect Lessons 5.2.5, 5.2.6, 5.2.7, 5.2.8 | Each displays DUAL action buttons: red "ቪዲዮ አጫውት" + white outlined "የልምምድ ፈተና" with red icon |
| I08-04 | Module 5.2 Lesson 5.2.9 Single Button | 1. In Module 5.2, inspect Lesson 5.2.9 "Vocabulary Use for Task 1" | Single red play button (#E4002B) with vocabulary trend line illustration |
| I08-05 | Module 5.3 Task 1 Tips Single Button | 1. Open Module 5.3 "Task 1 Tips"<br>2. Inspect Lesson 5.3.1 | Single red play button with trophy illustration |
| I08-06 | Module 5.4 Task 2 Writing Single Buttons | 1. Open Module 5.4 "Task 2 Writing"<br>2. Inspect Lessons 5.4.1, 5.4.2, 5.4.3, 5.4.4 | Single red play button; question format, dialogue, essay structure, and brainstorm bubble illustrations display |
| I08-07 | Module 5.4 Task 2 Writing Dual Action Buttons | 1. In Module 5.4, inspect Lessons 5.4.5, 5.4.6, 5.4.7, 5.4.8 | Each displays DUAL action buttons: red "ቪዲዮ አጫውት" + white outlined "የልምምድ ፈተና" with red icon |
| I08-08 | Module 5.4 Lesson 5.4.9 Single Button | 1. In Module 5.4, inspect Lesson 5.4.9 "Vocabulary Use for Task 2" | Single red play button (#E4002B) with vocabulary concept tree illustration |
| I08-09 | Module 5.5 Task 2 Tips Single Button | 1. Open Module 5.5 "Task 2 Tips"<br>2. Inspect Lesson 5.5.1 | Single red play button with golden trophy illustration |

---

## TC-I09 – IELTS Test Day Essentials & Farewell (Unit 6)

| ID | Scenario | Steps | Expected Result |
|----|----------|-------|-----------------|
| I09-01 | Module 6.1 Test Day Essentials | 1. Open Unit 6, Module 6.1 "Test Day Essentials"<br>2. Inspect Lesson 6.1.1 "What to Bring on Test Day" | Displays suitcase/passport illustration; single red play button (#E4002B) |
| I09-02 | Module 6.2 What to Expect | 1. Open Module 6.2 "What to Expect"<br>2. Inspect Lesson 6.2.1 "Getting Familiar with IELTS Answer Sheets" | Displays answer sheet and pencil illustration; single red play button |
| I09-03 | Module 6.3 After the Test | 1. Open Module 6.3 "After the Test"<br>2. Inspect Lesson 6.3.1 "Results and Farewell" | Displays results certificate & celebration party popper illustration; single red play button |

---

## TC-I10 – IELTS Practice Intro Screen

| ID | Scenario | Steps | Expected Result |
|----|----------|-------|-----------------|
| I10-01 | Practice Screen Layout | 1. Tap "የልምምድ ፈተና" from any lesson with dual action buttons | Screen opens with clean white background, top bar with back arrow and centered "የልምምድ ፈተና", centered bold "IELTS" heading, and rounded practice card |
| I10-02 | Practice Card Presentation | 1. Observe practice card | Card has soft pink/salmon top banner (#xFFFFEEF0) rendering headphones illustration (`8.1-ielts-course-01.svg`), followed by bold title (e.g. "IELTS Listening") |
| I10-03 | Start Assessment Button | 1. Inspect button inside the card | Full-width red button (#E4002B) with white text "ምዘና ይጀምሩ" |
| I10-04 | Start Assessment Tap | 1. Tap "ምዘና ይጀምሩ" | Smoothly transitions to the first practice question; loading indicator shows if prompts are fetching |
| I10-05 | Back / Cancel Bottom Sheet | 1. Tap top-left back button | CancelPracticeSheet appears with Amharic prompt and options to continue or exit |

---

## TC-EP01 – English For Professionals Catalog Card

| ID | Scenario | Steps | Expected Result |
|----|----------|-------|-----------------|
| EP01-01 | Catalog Card Styling & Color | 1. Navigate to Course Catalog | "English For Professionals" tile appears with lilac/lavender background (#F4E3F2), white squircle box with purple briefcase SVG (`6.2-proficiency-exams-03.svg`), bold title, and trailing chevron |
| EP01-02 | Catalog Card Tap Navigation | 1. Tap "English For Professionals" card | Navigates directly to the Course Unit screen for English For Professionals |

---

## TC-EP02 – English For Professionals Course Unit Screen (Frame 1)

| ID | Scenario | Steps | Expected Result |
|----|----------|-------|-----------------|
| EP02-01 | Course Unit Screen Layout | 1. Open English For Professionals from Catalog | Top bar shows back button and centered "የኮርስ ዝርዝር"; centered heading "English For Professionals"; purple hero banner (#8E2483); overall progress card; unit list |
| EP02-02 | Hero Banner Presentation | 1. Observe hero banner | Deep purple background (#8E2483), briefcase and speech bubble illustration (`9.1-english-for-professionals-course-01.svg`), and white pill badge "2 UNITS" |
| EP02-03 | Overall Progress Section | 1. Observe progress indicator | Progress percentage and linear indicator use magenta/purple theme (#8E2483); subtitle text rendered in Aeonik |
| EP02-04 | Unit 1 Tile (Before Getting a Job) | 1. Observe Unit 1 tile | Purple circle (#8E2483) with white search icon (`Icons.search_rounded`); title "ሥራ ከማግኘትዎ በፊት \| Before Getting a Job"; progress bar at 0% |
| EP02-05 | Unit 2 Tile (After Landing a Job) | 1. Observe Unit 2 tile | Orange circle (#FF7A50) with white briefcase icon (`Icons.work_rounded`); title "በሥራ ላይ \| After Landing a Job"; progress bar at 0% |
| EP02-06 | Unit 1 Module Expansion | 1. Tap Unit 1 tile | Expands smoothly to list Modules 1 through 6 (Finding Job, Self Assessments, CV, Cover Letter, Interview, Talking about Yourself) |

---

## TC-EP03 – English For Professionals Module Detail & Large Lesson Cards (Frames 2–7)

| ID | Scenario | Steps | Expected Result |
|----|----------|-------|-----------------|
| EP03-01 | Module Detail Screen Header | 1. Open any module (e.g., Module 1) | Top bar has back button and centered "የሞጁል ዝርዝር"; centered heading "English For Professionals"; collapsible purple module card (#8E2483) with "UNIT 1 · MODULE {N}", title, and "0/1" |
| EP03-02 | Module 1 Lesson Card (Frame 2) | 1. Open Module 1 | Card shows full-width illustration banner (#F7F2F8) with `01-finding-and-securing-the-right-job-for-you.svg`; Amharic title "እርስዎ የሚፈልጉትን ትክክለኛ ሥራ ማግኘት"; English subtitle "Finding and securing the right job for you"; clock icon with "4 ደቂቃ"; single purple play button (#8E2483) "ቪዲዮ አጫውት" |
| EP03-03 | Module 2 Lesson Card (Frame 3) | 1. Open Module 2 | Top banner renders `02-self-assessments-and-understanding-job-advertisements.svg`; Amharic title "የራስ ግምገማዎች እና የሥራ ማስታወቂያዎችን መረዳት"; English subtitle "Self assessments & Understanding job advertisements"; single purple play button |
| EP03-04 | Module 3 Lesson Card (Frame 4) | 1. Open Module 3 | Top banner renders `03-writing-your-cv-curriculum-vitae-or-resume.svg`; Amharic title "ሲቪ (CV - ከሪኩለም ቪቴ) ወይም የሥራ ከንቲብ ማዘጋጀት"; English subtitle "Writing your CV (Curriculum Vitae) or resume"; single purple play button |
| EP03-05 | Module 4 Lesson Card (Frame 5) | 1. Open Module 4 | Top banner renders `04-how-to-write-your-cover-letter.svg`; Amharic title "የሥራ ደብዳቤ (Cover Letter) እንዴት እንደሚጻፍ"; English subtitle "How to write your cover letter"; single purple play button |
| EP03-06 | Module 5 Lesson Card (Frame 6) | 1. Open Module 5 | Top banner renders `05-the-interview-attire-and-attitude.svg`; Amharic title "ቃለ መጠይቅ (አለባበስ እና አመለካከት)"; English subtitle "The interview (Attire & Attitude)"; single purple play button |
| EP03-07 | Module 6 Lesson Card (Frame 7) | 1. Open Module 6 | Top banner renders `06-talking-about-yourself-personal-information-and-summary-of-skills-and-.svg`; Amharic title "ስለ ራስዎ ማውራት..."; English subtitle "Talking about Yourself..."; single purple play button |
| EP03-08 | Play Video Action Tap | 1. Tap "ቪዲዮ አጫውት" on any lesson card | Navigates to the video lesson player |
| EP03-09 | Non-Regression Across All Courses | 1. Open Duolingo course<br>2. Open IELTS course | Duolingo remains green (#58CC02) with horizontal thumbnails; IELTS remains crimson (#E4002B); neither is affected by English for Professionals styling |

---

## TC-SP01 – My Subscriptions Screen (Figma Redesign)

| ID | Scenario | Steps | Expected Result |
|----|----------|-------|-----------------|
| SP01-01 | Screen Header & Subtitle | 1. Navigate to Profile > My Subscriptions | Top bar displays squircle back button (`CustomBackButton`), centered bold title "My Subscriptions" in magenta35 (#8E2483), and subtitle "Continue learning with your favorite platforms." in grey (#666680) |
| SP01-02 | Learn English Card Layout | 1. Observe first subscription card | White card with rounded corners (18px) and border (#EEEEF0); pink squircle container (#F7EBF5) with `learn-english-book.svg`; title "Learn English (3 Months)"; mint green "ACTIVE" badge (#E4F8EE) |
| SP01-03 | Learn English Card Stats | 1. Observe stats box in Learn English card | Tinted background box (#FAF8FC) showing 3 columns: Days remaining ("92"), Duration ("3 months"), Auto-renew ("Off") with numbers in bold magenta35 (#8E2483) |
| SP01-04 | Duolingo Premium Card | 1. Observe second subscription card | Light lime squircle (#E3FADC) with `duolingo-english-test-laptop.svg`; title "Duolingo Premium"; "ACTIVE" pill badge; Days remaining ("123"), Duration ("4 months"), Auto-renew ("Off") |
| SP01-05 | Active Resubscribe Button | 1. Observe Resubscribe button on active cards | Button renders disabled/muted style with faint background (#FAF7FC), purple border (#EADBEE), refresh icon, and muted text (#A594AA); tap is disabled |
| SP01-06 | Inactive Resubscribe Action | 1. Subscription status is expired/cancelled | Status badge displays "EXPIRED" (#FFF0F0 bg, #E4002B text); Resubscribe button activates with solid magenta35 background and white text; tapping initiates resubscription flow |
| SP01-07 | Back Navigation | 1. Tap squircle back button | Pops back to the previous screen (Profile/Settings) smoothly |

---

## TC-SP02 – My Progress Screen (Figma Redesign)

| ID | Scenario | Steps | Expected Result |
|----|----------|-------|-----------------|
| SP02-01 | Screen Header | 1. Navigate to Profile > My Progress | Top bar displays squircle back button and centered bold title "My progress" in magenta35 (#8E2483) on soft surface background (#FAF8FC) |
| SP02-02 | Learn English Progress Card | 1. Observe top progress card | White card with rounded corners (18px) and border (#EEEEF0); pink squircle container (#F7EBF5) with `learn-english-book.svg`; title "Learn English"; subtitle "Great job! Keep the momentum." in grey (#888899) |
| SP02-03 | Learn English Progress Bar & Stats | 1. Observe progress bar and stats | Full-width rounded linear progress indicator with lavender track (#EADBEE) and magenta35 fill (#8E2483); tinted stats box (#FAF8FC) displays Completed practices ("121"), Total practices ("121"), and Progress ("100%") |
| SP02-04 | Continue Learning Navigation | 1. Tap "Continue Learning →" button | Navigates directly to the Learn Program view |
| SP02-05 | Course Progress Section Header | 1. Observe Course card | White card with peach/yellow squircle container (#FFF0D3) and `course-graduation-cap.svg`; section heading "Course" in bold dark font (18px, #1A1A2E) |
| SP02-06 | Duolingo English Test Nested Card | 1. Observe nested course tile | Bordered card with green squircle (#4AC600) and white flag icon (`Icons.flag_rounded`), title "Duolingo English Test", and magenta trailing chevron |
| SP02-07 | Course Progress & Stats Box | 1. Inspect course progress indicators | Rounded green progress indicator (#4AC600); tinted box with "0/0 Videos" and "0/0 Practice" in magenta35; solid magenta35 "Continue Course →" button |
| SP02-08 | Visual Non-Regression | 1. Verify all colors & fonts across both screens | Typography strictly uses Aeonik; brand colors adhere to magenta35 (#8E2483); no overflow or clip errors on any screen size |

---

## TC-DP01 – Duolingo Practice Tests (Multi-Tier & Screen 7.20 Redesign)

| ID | Scenario | Steps | Expected Result |
|----|----------|-------|-----------------|
| DP01-01 | Screen 7.20 Redesign Layout (Figma Reference) | 1. Navigate to any Duolingo practice test | Page displays squircle back button (`CustomBackButton`), centered title "የልምምድ ፈተና", centered heading "Duolingo English Test" (22px, #1A1A2E), and a single white card (20px radius, border #EEEEF0, shadow) |
| DP01-02 | Screen 7.20 Illustration & Start Button | 1. Observe practice card contents | Card features top illustration banner with soft pastel lime background (#E2F8DA) and `7.20-det-practice-test-start-01.svg`; practice title (e.g. "Listen and Type"); and Duolingo green button (#58CC02) with 3D bottom shadow (#46A302) and white text "ምዘና ይውሰዱ" inside the card |
| DP01-03 | Course-Level Practice Test (Mock Exam) | 1. Navigate to Duolingo Course Unit view | Directly below progress section, "የሙከራ ፈተና \| Take Mock Exam" card appears with green icon container, subtitle "Duolingo English Test Mock Exam", and "ምዘና ይውሰዱ" button |
| DP01-04 | Course-Level Mock Exam Navigation | 1. Tap "ምዘና ይውሰዱ" on Course Mock Exam card | Navigates to `CoursePracticeView` with `CoursePractices.courseCatalog` and displays Screen 7.20 |
| DP01-05 | Unit-Level Practice Test | 1. In Duolingo Course Unit view, expand any unit (e.g. Unit 3 Listening) | Light green action container appears above modules list: "የልምምድ ፈተና (Unit 3)" with checkmark icon |
| DP01-06 | Unit-Level Practice Navigation | 1. Tap "የልምምድ ፈተና (Unit X)" button | Navigates to `CoursePracticeView` with `CoursePractices.unit` and displays Screen 7.20 |
| DP01-07 | Module-Level Practice Test | 1. Navigate to Duolingo Module view (e.g. Module 3.1) | Inside green collapsible module header, a module practice button appears: "የልምምድ ፈተና - 3.1 Listen and Type" |
| DP01-08 | Module-Level Practice Navigation | 1. Tap module practice button in header | Navigates to `CoursePracticeView` for the module practice questions |
| DP01-09 | Lesson-Level Practice Test | 1. In module lesson list, locate lesson with practice (e.g. Lesson 3.1.2) | Lesson card displays dual action buttons: "ቪዲዮ አጫውት" and "የልምምድ ፈተና" |
| DP01-10 | Lesson-Level Practice Navigation | 1. Tap "የልምምድ ፈተና" on lesson card | Navigates to `CoursePracticeView` with `CoursePractices.lesson` and displays Screen 7.20 |
| DP01-11 | Screen 7.20 Exit Sheet Confirmation | 1. On Screen 7.20, tap squircle back button | Modal `CancelPracticeSheet` appears asking user confirmation before leaving practice |
| DP01-12 | Start Practice Test Flow | 1. On Screen 7.20, tap "ምዘና ይውሰዱ" | Displays loading spinner while caching/prompting, then advances directly into the first practice question screen |

---

*End of course manual test document.*
