import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:yimaru_app/app/app.router.dart';

import '../../../app/app.locator.dart';
import '../../common/enmus.dart';

class LearnModuleViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();

  // Modules
  final List<Map<String, dynamic>> _modules = [
    {
      'status': ProgressStatuses.started,
      'title': 'Lesson 1.1',
      'subtitle': 'Start Speaking English Today! Greetings & Introductions',
      'topics':
          """👉 How to use "Good Morning," "Afternoon," and "Evening" at the right time.
      👉 Why saying "I'm" is often better than "I am" in spoken English.
      👉 Master "My," "Your," and the verb "To Be" without the headache.
      👉 How to perfectly say the "Long I" sound in "Hi" and "My."
        """,
      'practices': [
        {
          'question_text': 'Good morning! How are you?',
          'question_audio_url':
              'https://drive.google.com/file/d/1El9hhmZvLnrTYtVreHR0EDXNrZyGphT9/view?usp=sharing',
          'sample_answer':
              'https://drive.google.com/file/d/1dUSahuj_VdunV293gEZr0XL9d4WV7_8G/view?usp=sharing'
        },
        {
          'question_text': 'What\'s your name?',
          'sample_answer':
              'https://drive.google.com/file/d/14oAqcMRltXeQhQ-RTGizO2DZ4CkHmKdu/view?usp=drive_link',
          'question_audio_url':
              'https://drive.google.com/file/d/1iAsOIXD4NcsctKuubnvWlnwXodTMlou5/view?usp=drive_link'
        },
        {
          'question_text': 'Nice to meet you!',
          'question_audio_url':
              'https://drive.google.com/file/d/10bOaNCcpNFzxpJ4d2-5KYahMCCcWt668/view?usp=drive_link',
          'sample_answer':
              'https://drive.google.com/file/d/1h8V6lFuOiOf0zRRN-NvYjtLrmMdx0SeX/view?usp=drive_link'
        },
        {
          'question_text':
              'You are doing great! Tell me, are you happy to be here?',
          'sample_answer':
              'https://drive.google.com/file/d/1sjNFofDRr9KB8fQptdM12LDJ5DIaHujs/view?usp=drive_link',
          'question_audio_url':
              'https://drive.google.com/file/d/1kcNIL5NCt_lfTzAbmCkM3yojD_UzjSx7/view?usp=drive_link',
        },
      ],
      'description':
          """Stop feeling nervous when you meet someone new! In this lesson, we break down the most common English greetings and show you exactly how to introduce yourself with confidence.
      Whether you are at the market, in a classroom, or meeting someone online, the first 10 seconds of a conversation are the most important. Our teacher  will guide you through the exact phrases you need to sound natural and friendly from the very first moment.
      """,
    },
    {
      'status': ProgressStatuses.started,
      'title': 'Lesson 1.2',
      'subtitle': 'Talk About Your Home! "Where Are You From?" & Locations',
      'topics':
          """👉 The difference between "Where are you from?" and "Where do you live?"
      👉 How to use "Am," "Is," and "Are" to talk about your home.
      👉 Learn to say "Where-are-you" as one smooth sound (word linking).
      👉 Practice a full conversation with Miss Alem.
      👉 A fast-paced game to test your speed and memory.
      """,
      'practices': [
        {
          'question_text':
              'Hey, It is a pleasure to meet you. Where are you from?',
          'sample_answer':
              'https://drive.google.com/file/d/1F98PdPqeDhkF5KMzFjgmUoy4HanIDHVs/view?usp=drive_link',
          'question_audio_url':
              'https://drive.google.com/file/d/1vipFTk-DYgOCYhyDyWVaORec7g0JeidD/view?usp=drive_link',
        },
        {
          'question_text': 'Ethiopia is beautiful! What city are you from?',
          'sample_answer':
              'https://drive.google.com/file/d/1nZJLV9lOgFGqYr-W3vlpt8rbay_bwARJ/view?usp=drive_link',
          'question_audio_url':
              'https://drive.google.com/file/d/1T8JIYQ6T9Mq_7TazGr85ag4PCyQgHhzi/view?usp=drive_link'
        },
        {
          'question_text': 'I see. And where does your family live now?',
          'question_audio_url':
              'https://drive.google.com/file/d/19XAbHL3HqTpPcolvOQUVPSGef-Ythusu/view?usp=drive_link',
          'sample_answer':
              'https://drive.google.com/file/d/1O8o11DNKYZBcm1-f8pjMFJjNIvGmawvg/view?usp=drive_link'
        },
      ],
      'description':
          """Are you ready to talk about your city, town, or country with pride? In Lesson 1.2, we move past basic greetings and learn how to share where you come from and where you live now.
      Whether you are meeting a tourist, a new classmate, or a colleague, being able to say "I’m from Ethiopia" or "I live in Addis Ababa" is the best way to build a connection. Miss Alem will show you how to link your words together so you sound like a natural English speaker!
      """,
    },
    {
      'title': 'Lesson 1.3',
      'status': ProgressStatuses.started,
      'subtitle': 'Talk About Your Family! Master "Have" vs. "Has"',
      'topics':
          """👉 Master the names for parents, grandparents, and the secret word for brothers and sisters (Siblings).
      👉 Never mix up "I have" and "She has" ever again.
      👉 Why the letter "S" is the most important sound when talking about your brothers.
      👉 A close-up look at how to pronounce "Mother" and "Father" like a native speaker.
      👉 Test your eyes and ears by finding the hidden mistakes in our family game.
        """,
      'practices': [
        {
          'question_text':
              'Hello! I want to know about your family. Do you have a brother or sister?',
          'sample_answer':
              'https://drive.google.com/file/d/1fred7Y5ocdD4codZuK7Pr349O38UkB0Z/view?usp=drive_link',
          'question_audio_url':
              'https://drive.google.com/file/d/1tMoTA4D6joz0bkWS5Nfn-neUvbej6XDI/view?usp=drive_link',
        },
        {
          'question_text': 'That is nice! How many people are in your family?',
          'sample_answer':
              'https://drive.google.com/file/d/1dhYhiycWwdtW0ndJUMdMXxxVyrXLXPCM/view?usp=drive_link',
          'question_audio_url':
              'https://drive.google.com/file/d/1FwRxWvrxzKbhEIYImy2ONzd410pabkJa/view?usp=drive_link'
        },
        {
          'question_text': 'Do you have grandparents?',
          'question_audio_url':
              'https://drive.google.com/file/d/1UBaQYiJINgOmZWDLFKeXZQ8Zfb7cOKNZ/view?usp=drive_link',
          'sample_answer':
              'https://drive.google.com/file/d/14cnEJTO7GtGZcO8ag50JdupV2EkvDHes/view?usp=drive_link'
        },
      ],
      'description':
          """Do you have brothers and sisters? In Lesson 1.3, we dive into the most personal and important topic for building friendships: Your Family. Many beginners make mistakes with the words "have" and "has," but today, we will fix that! Our teacher will teach you the exact formulas to describe your parents, siblings, and grandparents with perfect grammar. By the end of this video, you will be able to introduce your entire family in English with confidence.""",
    },
    {
      'status': ProgressStatuses.started,
      'title': 'Lesson 1.4',
      'subtitle': '"What Do You Do?" Talk About Your Job & Studies',
      'topics':
          """👉 The clear difference between talking about work and academic life.
    👉 Simple rules to decide between "I’m a teacher" and "I’m an accountant."
    👉 How to use the "-ing" form if you are still training for your dream job.
    👉 Perfecting the final "T" in "Student" and the "SH" sound in "Cashier."
    👉 A high-energy game to test your grammar reflexes!""",
      'practices': [
        {
          'question_text': 'It is good to see you again! What do you do?',
          'question_audio_url':
              'https://drive.google.com/file/d/171fh_iN0aXS0t95_5RzcxFiVmLCB7caP/view?usp=sharing',
          'sample_answer':
              'https://drive.google.com/file/d/1wDkbp23F2PsLZM9mWlRd-JjnwZa97T-8/view?usp=drive_link',
        },
        {
          'question_text':
              'That is great. Are you studying to be a professional? What are you studying?',
          'sample_answer':
              'https://drive.google.com/file/d/1egHUMIqGt9VAw5HMVMdjWR3zmamdSB6F/view?usp=drive_link',
          'question_audio_url':
              'https://drive.google.com/file/d/1T_qrH_-KHgQFw5kX4Ti-UwXvnBFyJsWT/view?usp=drive_link'
        },
        {
          'question_text':
              'Your sister works in a restaurant. Is she a waitress?',
          'question_audio_url':
              'https://drive.google.com/file/d/1Okd-W2zRZCukQfnbLEp9A4r_5rt99U_6/view?usp=drive_link',
          'sample_answer':
              'https://drive.google.com/file/d/1t-_JHXel9dtSHRwYU_CO1Mc8-Pa1pOa0/view?usp=drive_link'
        },
        {
          'question_text': 'My friend works in a bank. Is he an accountant?',
          'question_audio_url':
              'https://drive.google.com/file/d/1K4ahmIzuBdrsUoO-gVRp525ZFyP7b1Cq/view?usp=drive_link',
          'sample_answer':
              'https://drive.google.com/file/d/1ecpWSQTvU9pu8BYq3qRkYUjblX5wG4RZ/view?usp=drive_link'
        },
      ],
      'description':
          """You’ve shared your name and your home—now it’s time to talk about your daily life! In Lesson 1.4, we master the most common question in English: "What do you do?" Whether you are working a full-time job, searching for a new career, or currently studying, this lesson gives you the exact phrases to describe your profession with perfect grammar.
Miss [Name] breaks down the tricky "A vs. An" rule so you never have to second-guess yourself again. Plus, learn how to sound more natural by "linking" your words like a native speaker!
"""
    },
    {
      'title': 'Lesson 1.5',
      'status': ProgressStatuses.started,
      'subtitle': 'Talk About Your Day! Daily Routines & Time Words',
      'topics':
          """👉 Master the 6 most common actions, from "Wake up" to "Go to bed."
    👉 Learn why we say "I eat" but "She eats" (and how to never forget it!).
    👉 Use "First," "Then," and "Finally" to tell a complete story about your day.
    👉 How to perfectly say the tricky "TH" sound in the word "Teeth."
    👉 A fast-paced game to test if your brain can handle the "S" rule under pressure!""",
      'practices': [
        {
          'question_text':
              'I want to hear about your day! What is the first thing you do in the morning?',
          'question_audio_url':
              'https://drive.google.com/file/d/1B_g45crvD0X2xfJJuCBdBhe7LNRJtKpa/view?usp=drive_link',
          'sample_answer':
              'https://drive.google.com/file/d/13nV3uQ6Vftc0DznBJ8GQMi26dHxmMUwH/view?usp=drive_link',
        },
        {
          'question_text':
              'That is a great start. What do you do for your hygiene? I brush...',
          'sample_answer':
              'https://drive.google.com/file/d/1ijbKHO9A3PEOUb712ycCw-P3ZvWX-NTp/view?usp=drive_link',
          'question_audio_url':
              'https://drive.google.com/file/d/1r92ixsWSD58TrV9LIArPRaKk1bVE5m44/view?usp=drive_link'
        },
        {
          'question_text':
              'Perfect. And then, what do you do before you leave the house?',
          'question_audio_url':
              'https://drive.google.com/file/d/1xEHuliUwyqFV35o_C2varAHcoI3QrOsS/view?usp=drive_link',
          'sample_answer':
              'https://drive.google.com/file/d/1RJgS3tp0ZKQ1YIt9fLRch-IqFialZR6Q/view?usp=drive_link'
        },
        {
          'question_text':
              'And finally, what is the last thing you do at night?',
          'question_audio_url':
              'https://drive.google.com/file/d/1njWyQExmgAPWgDTrcpqitEoNjiPfCbEw/view?usp=drive_link',
          'sample_answer':
              'https://drive.google.com/file/d/140O0xAkYpVo5FLZQmbc1BaY_6agYWeki/view?usp=drive_link'
        },
      ],
      'description':
          """What do you do from the moment you wake up until you go to bed? In Lesson 1.5, we master the art of describing your Daily Routine at Home. This is the best way to practice the "Simple Present Tense" so you can talk about your habits, chores, and schedules like a pro.
Our teacher will show you the "S" secret—the most important grammar rule for talking about other people—and teach you the "Time Order Words" that make your English flow naturally from one activity to the next.
"""
    },
    {
      'title': 'Lesson 1.6',
      'status': ProgressStatuses.started,
      'subtitle': 'Express Your Feelings! Likes, Dislikes & Hobbies',
      'topics':
          """👉 How to build perfect positive and negative sentences (I like vs. I don't like).
    👉 Master the "Do you like...?" structure and the correct short answers.
    👉 Learn why we switch from "Don't" to "Doesn't" for He and She.
    👉 How to master the "L" sound and make your "Don't" sound natural and fast.
    👉 A high-speed game to test if you can handle the grammar of likes and dislikes!""",
      'practices': [
        {
          'question_text':
              'I want to know about your hobbies. Do you like football?',
          'question_audio_url':
              'https://drive.google.com/file/d/1ombhL58UTSSMlVr4OkjEN2m1TXeIs3Jw/view?usp=sharing',
          'sample_answer':
              'https://drive.google.com/file/d/1E-NilYZkazwTyAFwwNunDQmWIxBHH_GL/view?usp=drive_link',
        },
        {
          'question_text':
              'That’s fun! Some people prefer quiet things. What do you like to do at home',
          'sample_answer':
              'https://drive.google.com/file/d/1HJqwHQId9MUhaQvjoyhuhk-ZQNCz5-RP/view?usp=drive_link',
          'question_audio_url':
              'https://drive.google.com/file/d/1HJqwHQId9MUhaQvjoyhuhk-ZQNCz5-RP/view?usp=drive_link'
        },
        {
          'question_text':
              'Interesting. Many people like music. Do you like slow music?',
          'question_audio_url':
              'https://drive.google.com/file/d/13edPllK_dZYmmFIsue_A-sGmDe9fh89K/view?usp=drive_link',
          'sample_answer':
              'https://drive.google.com/file/d/1lA18zdiFbKKXaGwUvJv4JwBMW_Vxxkip/view?usp=drive_link'
        },
        {
          'question_text': 'Do you like running?',
          'question_audio_url':
              'https://drive.google.com/file/d/1MSVceVXL-mAELGvv0_SN68t1-pCM-V6R/view?usp=drive_link',
          'sample_answer':
              'https://drive.google.com/file/d/1XkwoWINsoXDSe63kjJXQFczjtPKbBTY4/view?usp=drive_link'
        },
      ],
      'description':
          """What makes you happy? What do you avoid? In Lesson 1.6, we learn how to make your English conversations personal and fun by sharing your Likes and Dislikes. This is the final topic of Module 1, and it is the key to building real friendships by finding common interests!
We will see how to use the power of "Do" and "Don't," and show you how the "S" rule changes when we talk about what our friends like. Get ready to talk about football, coffee, music, and more!
"""
    },
    {
      'title': 'Lesson 1.7',
      'status': ProgressStatuses.started,
      'subtitle': 'Module 1 Final Test! Speaking Review & Graduation',
      'topics': """👉 Fast-paced practice for names, origins, and jobs.
     Mastering "Have," "Has," and the plural "S" under pressure.
    👉 Using the Simple Present Tense to describe your day and your likes.
    👉 A bonus challenge to find and correct common beginner mistakes.
    👉 Two speaking scripts to help you link your words and sound like a native speaker.""",
      'practices': [
        {
          'question_text': 'Hello! What\'s your name?',
          'question_audio_url':
              'https://drive.google.com/file/d/11xsnZpqOXQREc2nku77u_qOXucUdncDq/view?usp=drive_link',
          'sample_answer':
              'https://drive.google.com/file/d/1OgvhumoPNdw33WfxEZfS1xtYZHshAM-k/view?usp=drive_link',
        },
        {
          'question_text': 'It was a pleasure meeting you. Nice to meet you!',
          'sample_answer':
              'https://drive.google.com/file/d/1NmKeyx0mKmbFyZdmQ4sWGM6UMpwAIrHN/view?usp=drive_link',
          'question_audio_url':
              'https://drive.google.com/file/d/1nu1fiK4dLCjW9jjENvThshU48vFj-T3h/view?usp=drive_link'
        },
        {
          'question_text': 'Where are you from?',
          'question_audio_url':
              'https://drive.google.com/file/d/1uM2L6-u0H-LHyDQL_Y0txjoO64n5lHkp/view?usp=drive_link',
          'sample_answer':
              'https://drive.google.com/file/d/1VXhHRG2CJR3lx07cAuiZrfCxzxdOcCIz/view?usp=drive_link'
        },
        {
          'question_text': 'And where do you live now?',
          'question_audio_url':
              'https://drive.google.com/file/d/1sGJpaRQ1wArA2iDq7BZM-56abMZwiISO/view?usp=drive_link',
          'sample_answer':
              'https://drive.google.com/file/d/10Cj8r2KeYUttBJ7W2wETP8XSdK2ZItom/view?usp=drive_link'
        },
        {
          'question_text': 'Do you have a brother or sister?',
          'question_audio_url':
              'https://drive.google.com/file/d/1cA4wD7zY7WRgorWladvf1f8QRu54oBBw/view?usp=drive_link',
          'sample_answer':
              'https://drive.google.com/file/d/1IeiGyN1S5XaREfXgmzfl-zESap8A_k3H/view?usp=drive_link'
        },
        {
          'question_text': 'I am a teacher. Are you a student?',
          'question_audio_url':
              'https://drive.google.com/file/d/1n5w3skHBvQ2hE_OA2HdeUnr0YeN4zL2_/view?usp=drive_link',
          'sample_answer':
              'https://drive.google.com/file/d/1j86TVmeNzZvL8RueZeIueCQO_40i9aMh/view?usp=drive_link'
        },
        {
          'question_text': 'What is the first thing you do in the morning?',
          'question_audio_url':
              'https://drive.google.com/file/d/1oCrDDtYF4-1S2UYu6shilqmQSqyRG3v_/view?usp=drive_link',
          'sample_answer':
              'https://drive.google.com/file/d/1shpCr2XvV12cXaxuJ-AjW-0XWvBdtT8Q/view?usp=drive_link'
        },
      ],
      'description':
          """Congratulations! You have reached the end of Module 1. You started with simple greetings, and now you are ready to hold a full conversation in English! This is our Final Speaking Review, where we test everything you’ve learned so far.
From your name and family to your daily habits and hobbies, this lesson is designed to push your speed, accuracy, and confidence. We will lead you through three high-intensity speaking drills and a bonus Grammar Check to make sure you are 100% ready for Module 2!
"""
    },
  ];

  List<Map<String, dynamic>> get modules => _modules;

  // Navigation
  void pop() => _navigationService.back();

  Future<void> navigateToLearnLesson(
          {required String title,
          required String topics,
          required String subtitle,
          required String description,
          required List<Map<String, dynamic>> practices}) async =>
      await _navigationService.navigateToLearnLessonView(
          title: title,
          topics: topics,
          subtitle: subtitle,
          practices: practices,
          description: description);

  Future<void> navigateToLearnPractice(
          List<Map<String, dynamic>> practices) async =>
      await _navigationService.navigateToLearnPracticeView(
        practices: practices,
        title: 'Let’s Practice',
        buttonLabel: 'Begin Lesson Practice',
        subtitle: 'Let’s quickly review what you’ve learned in this lesson!',
      );
}
