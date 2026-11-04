# Module Details & Lesson Screen Manual Test Specification

## 1. Overview & Test Scope
This document outlines manual testing procedures for the **Module Details / Lessons View** (`LearnLessonView` and `LearnLessonTile`). It validates visual styling, interactive states, vector graphics matching, progress metrics, and localization.

---

## 2. Test Cases Matrix

| Test ID | Category | Feature / Component | Expected Behavior | Status |
|---|---|---|---|---|
| **TC-MOD-01** | Header | Squircle Back Button | 44×44 squircle with white background, border, subtle shadow, and purple arrow. Tapping pops back to previous screen. | [ ] Pass |
| **TC-MOD-02** | Header | Completed Status Banner | When module is 100% complete, card has soft mint background (`#E8F7F0`), border (`#BCECD1`), and "✔ Completed" green badge pill. | [ ] Pass |
| **TC-MOD-03** | Header | In-Progress Status Banner | When module is active/in-progress, card has warm pastel yellow background (`#FFF6D7`), border (`#FFE8A3`), and purple "● In Progress" badge pill. | [ ] Pass |
| **TC-MOD-04** | Header | Module Details & Illustration | Displays `module.name` (Aeonik bold), `module.description`, and 76×76 squircle with module SVG illustration. | [ ] Pass |
| **TC-MOD-05** | Header | Progress Metrics Card | Inner white container displays `$percentInt% Progress` on left, `$completed/$total` on right, and rounded linear progress bar (green if completed, magenta if in-progress). | [ ] Pass |
| **TC-MOD-06** | Mascot | Motivation Card | Displays official Yimi graduate mascot SVG in lavender circular avatar with dynamic message: "Module complete! Amazing work, keep it up." for 100%, "Let's keep going - you're more than half there" for ≥50%, and "Keep up the great work! You're doing amazing." for <50%. | [ ] Pass |
| **TC-MOD-07** | Header | Section Title & Counter | Left: "Lessons in this module" (`LocaleKeys.lessons_in_module`). Right: dynamic total lessons counter (e.g. "7 lessons", "3 lessons"). | [ ] Pass |
| **TC-MOD-08** | Lesson Tile | Squircle Icon & Number Badge | Left 58×58 squircle with pastel background (yellow, mint, peach, lavender, sky, rose) and clean SVG topic illustration. Bottom-left has white squircle badge with lesson index number (1, 2, ... N). | [ ] Pass |
| **TC-MOD-09** | Lesson Tile | Topic-Specific Illustrations | Correct SVG illustration rendered per lesson: Groceries, Restaurant, Market, Favorite food, Soup/Diet, Bill/Money, Bus, Luggage, Traffic/Safety, Map, Directions, Emergency, Profile, Routine, Memories, Hobbies, Weekend, Likes/Dislikes, Post Office, Information, City Master trophy, Speaking Review. | [ ] Pass |
| **TC-MOD-10** | Lesson Tile | Completed Status Checkmark | Completed lessons display 26×26 circular filled green badge (`#22C55E`) with white checkmark. | [ ] Pass |
| **TC-MOD-11** | Lesson Tile | In-Progress Status Pill | Active lesson displays amber/yellow "In Progress" pill badge below lesson title. | [ ] Pass |
| **TC-MOD-12** | Lesson Tile | Expand / Collapse Interaction | Tapping an accessible lesson card expands it to reveal progress bar and action buttons ("Practice" and "Start"). | [ ] Pass |
| **TC-MOD-13** | Lesson Tile | Action Buttons | "Practice": Outlined white button with purple border, text, and mic icon. Navigates to practice. "Start": Filled purple button with white text and play icon. Navigates to lesson detail. | [ ] Pass |
| **TC-MOD-14** | Localization | English / Amharic Switching | All text strings, motivation messages, lesson counters, and status badges translate seamlessly when switching between English and Amharic. | [ ] Pass |
| **TC-MOD-15** | Scrolling | Smooth List Scroll | Screen smoothly scrolls with pinned back button at the top, without overflow errors or jank on varying screen sizes. | [ ] Pass |

---

## 3. Verified Module Contexts & Illustration Mappings

### Module 1: Food & Shopping ("ስለ ምግብ እና ግብይት መወያየት")
1. **Lesson 1** (Groceries): `lesson_food_groceries.svg` (Basket with bread, carrot, fruit)
2. **Lesson 2** (Restaurant): `lesson_food_restaurant.svg` (Dining table with plate, cutlery, glass)
3. **Lesson 3** (Market): `lesson_food_market.svg` (Awning stall with fruit crates)
4. **Lesson 4** (Favorite foods): `lesson_food_favorite.svg` (Pizza slice on serving plate)
5. **Lesson 5** (Dietary/Soup): `lesson_food_soup.svg` (Steaming noodle/soup bowl)
6. **Lesson 6** (Bill/Payment): `lesson_food_bill.svg` (Receipt, cash banknote, and gold coins)
7. **Lesson 7** (Review/Speaking): `lesson_speaking_review.svg` (Microphone with review check badge)

### Module 2: Travel ("ስለ ጉዞ መናገር")
1. **Lesson 1** (Transport): `lesson_travel_bus.svg` (Bus at bus stop)
2. **Lesson 2** (Luggage/Tickets): `lesson_travel_luggage.svg` (Suitcases with airplane ticket)
3. **Lesson 3** (Safety/Rules): `lesson_travel_traffic.svg` (Traffic light and green shield)
4. **Lesson 4** (Map/Landmarks): `lesson_travel_map.svg` (Folded route map with pin)
5. **Lesson 5** (Directions): `lesson_travel_signpost.svg` (Signpost with question mark)
6. **Lesson 6** (Emergency): `lesson_travel_emergency.svg` (Red medical kit and smartphone)
7. **Lesson 7** (Review/Speaking): `lesson_speaking_review.svg` (Microphone with review check badge)

### Module 3: Personal Life ("ስለ ግል ሕይወትዎ መናገር")
1. **Lesson 1** (Profile): `lesson_life_profile.svg` (Browser window with user avatar card)
2. **Lesson 2** (Routine): `lesson_life_routine.svg` (Alarm clock and hot coffee mug)
3. **Lesson 3** (Memories): `lesson_life_memories.svg` (Polaroid photo snapshots)
4. **Lesson 4** (Hobbies): `lesson_life_hobbies.svg` (Music headphones and soccer ball)
5. **Lesson 5** (Weekend): `lesson_life_weekend.svg` (Calendar with weekend dates)
6. **Lesson 6** (Likes/Dislikes): `lesson_life_likes.svg` (Green heart and red cross badges)
7. **Lesson 7** (Review/Speaking): `lesson_speaking_review.svg` (Microphone with review check badge)

### Module 4: Public Services ("የህዝብ አገልግሎቶችን መጠየቅ")
1. **Lesson 1** (Post Office): `lesson_service_post.svg` (Mailbox with flying envelope)
2. **Lesson 2** (Information): `lesson_service_info.svg` (Info "i" and "?" dialog bubbles)
3. **Lesson 3** (City Master): `lesson_service_trophy.svg` (Gold champion trophy on podium)

### Additional Inferred Modules (Work, Study, Tech, Nature, Social)
- **Work / Careers**: `lesson_work_career.svg` (Briefcase & checklist)
- **Study / Education**: `lesson_study_education.svg` (Books & graduation cap)
- **Tech / Digital**: `lesson_tech_digital.svg` (Laptop & smartphone)
- **Nature / Weather**: `lesson_nature_weather.svg` (Sun, cloud, & sprout)
- **Social / Conversations**: `lesson_social_chat.svg` (Speech dialogue bubbles)

