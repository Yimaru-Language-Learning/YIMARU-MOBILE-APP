class LessonIllustrationResolver {
  static const String _lessonsDir = 'assets/images/illustrations/lessons';
  static const String _modulesDir = 'assets/images/illustrations/modules';
  static const String _levelsDir = 'assets/images/illustrations/levels';

  // ── Lesson SVGs ────────────────────────────────────────────────────────────
  // Food
  static const String foodGrocery = '$_lessonsDir/food-1-grocery.svg';
  static const String foodRestaurant = '$_lessonsDir/food-2-restaurant.svg';
  static const String foodMarket = '$_lessonsDir/food-3-market.svg';
  static const String foodFavourite = '$_lessonsDir/food-4-favourite.svg';
  static const String foodFasting = '$_lessonsDir/food-5-fasting.svg';
  static const String foodBill = '$_lessonsDir/food-6-bill.svg';

  // Greetings
  static const String greetHello = '$_lessonsDir/greet-1-hello.svg';
  static const String greetWhereYouLive = '$_lessonsDir/greet-2-where-you-live.svg';
  static const String greetFamily = '$_lessonsDir/greet-3-family.svg';

  // Personal Life
  static const String personalAboutYou = '$_lessonsDir/personal-1-about-you.svg';
  static const String personalRoutine = '$_lessonsDir/personal-2-routine.svg';
  static const String personalMemories = '$_lessonsDir/personal-3-memories.svg';
  static const String personalHobbies = '$_lessonsDir/personal-4-hobbies.svg';
  static const String personalWeekend = '$_lessonsDir/personal-5-weekend.svg';
  static const String personalLikes = '$_lessonsDir/personal-6-likes.svg';

  // Public Services
  static const String publicPostOffice = '$_lessonsDir/public-1-post-office.svg';
  static const String publicInformation = '$_lessonsDir/public-2-information.svg';
  static const String publicCityReview = '$_lessonsDir/public-3-city-review.svg';

  // Review & Speaking
  static const String reviewSpeaking = '$_lessonsDir/review-speaking.svg';

  // Travel
  static const String travelTransport = '$_lessonsDir/travel-1-transport.svg';
  static const String travelTickets = '$_lessonsDir/travel-2-tickets.svg';
  static const String travelSafety = '$_lessonsDir/travel-3-safety.svg';
  static const String travelMaps = '$_lessonsDir/travel-4-maps.svg';
  static const String travelQuestions = '$_lessonsDir/travel-5-questions.svg';
  static const String travelEmergency = '$_lessonsDir/travel-6-emergency.svg';

  // ── Module SVGs ────────────────────────────────────────────────────────────
  static const String moduleFood = '$_modulesDir/module-food.svg';
  static const String moduleTravel = '$_modulesDir/module-travel.svg';
  static const String modulePersonalLife = '$_modulesDir/module-personal-life.svg';
  static const String modulePublicServices = '$_modulesDir/module-public-services.svg';
  static const String moduleGreetings = '$_modulesDir/module-greetings.svg';
  static const String moduleDailyLife = '$_modulesDir/module-daily-life.svg';
  static const String moduleWork = '$_modulesDir/module-work.svg';
  static const String moduleHome = '$_modulesDir/module-home.svg';

  // ── Level SVGs ─────────────────────────────────────────────────────────────
  static const String levelBeginner = '$_levelsDir/level-beginner.svg';
  static const String levelIntermediate = '$_levelsDir/level-intermediate.svg';
  static const String levelAdvanced = '$_levelsDir/level-advanced.svg';

  static const List<String> _allLessons = [
    foodGrocery,
    foodRestaurant,
    foodMarket,
    foodFavourite,
    foodFasting,
    foodBill,
    travelTransport,
    travelTickets,
    travelSafety,
    travelMaps,
    travelQuestions,
    travelEmergency,
    personalAboutYou,
    personalRoutine,
    personalMemories,
    personalHobbies,
    personalWeekend,
    personalLikes,
    publicPostOffice,
    publicInformation,
    publicCityReview,
    greetHello,
    greetWhereYouLive,
    greetFamily,
    reviewSpeaking,
  ];

  /// Resolves the lesson illustration path based on title, index, and module context.
  static String resolve({
    required String? lessonTitle,
    required int index,
    String? lessonThumbnail,
    String? moduleName,
  }) {
    if (lessonThumbnail != null &&
        lessonThumbnail.startsWith('assets/') &&
        lessonThumbnail.endsWith('.svg')) {
      return lessonThumbnail;
    }

    final title = (lessonTitle ?? '').toLowerCase();
    final mod = (moduleName ?? '').toLowerCase();

    // 1. Final Review & Speaking Practice
    if (title.contains('city master') ||
        title.contains('city review') ||
        title.contains('trophy')) {
      return publicCityReview;
    }
    if (title.contains('ክለሳ') ||
        title.contains('የንግግር') ||
        title.contains('speaking') ||
        title.contains('review') ||
        title.contains('ልምምድ')) {
      return reviewSpeaking;
    }

    // 2. Food & Shopping
    if (title.contains('ዕቃዎች') ||
        title.contains('ግዢ') ||
        title.contains('grocery') ||
        title.contains('shopping')) {
      return foodGrocery;
    }
    if (title.contains('ሬስቶራንት') ||
        title.contains('ምግብ ማዘዝ') ||
        title.contains('restaurant') ||
        title.contains('order')) {
      return foodRestaurant;
    }
    if (title.contains('ገበያ') ||
        title.contains('መደብር') ||
        title.contains('መደብሮች') ||
        title.contains('market') ||
        title.contains('store') ||
        title.contains('shop')) {
      return foodMarket;
    }
    if (title.contains('የሚወዷቸው ምግቦች') ||
        title.contains('favourite food') ||
        title.contains('favorite food') ||
        title.contains('ምግቦች')) {
      return foodFavourite;
    }
    if (title.contains('አመጋገብ') ||
        title.contains('ፍላጎቶች') ||
        title.contains('ፆም') ||
        title.contains('fasting') ||
        title.contains('diet') ||
        title.contains('nutrition') ||
        title.contains('ደስታ እና')) {
      return foodFasting;
    }
    if (title.contains('ሒሳብ') ||
        title.contains('መክፈል') ||
        title.contains('bill') ||
        title.contains('pay') ||
        title.contains('receipt') ||
        title.contains('money')) {
      return foodBill;
    }

    // 3. Travel & Transportation
    if (title.contains('ትራንስፖርት') ||
        title.contains('አውቶቡስ') ||
        title.contains('transport') ||
        title.contains('bus')) {
      return travelTransport;
    }
    if (title.contains('ትኬት') ||
        title.contains('ዝግጅት') ||
        title.contains('ሻንጣ') ||
        title.contains('ticket') ||
        title.contains('luggage') ||
        title.contains('pack') ||
        title.contains('booking')) {
      return travelTickets;
    }
    if (title.contains('ሕጎች') ||
        title.contains('ደህንነት') ||
        title.contains('safety') ||
        title.contains('rules') ||
        title.contains('traffic')) {
      return travelSafety;
    }
    if (title.contains('ካርታ') ||
        title.contains('ምልክት') ||
        title.contains('map') ||
        title.contains('maps') ||
        title.contains('landmark') ||
        title.contains('direction')) {
      return travelMaps;
    }
    if (title.contains('ጥያቄዎች') ||
        title.contains('ቀላል የጉዞ') ||
        title.contains('questions') ||
        title.contains('signpost')) {
      return travelQuestions;
    }
    if (title.contains('አደጋ') ||
        title.contains('emergency') ||
        title.contains('urgent') ||
        title.contains('medical')) {
      return travelEmergency;
    }

    // 4. Personal Life & Routines
    if (title.contains('ስለራስዎ') ||
        title.contains('በዝርዝር') ||
        title.contains('about you') ||
        title.contains('profile') ||
        title.contains('myself') ||
        title.contains('introduce')) {
      return personalAboutYou;
    }
    if (title.contains('ዕለት ተዕለት') ||
        title.contains('ልማድ') ||
        title.contains('ጊዜ') ||
        title.contains('routine') ||
        title.contains('daily') ||
        title.contains('habit')) {
      return personalRoutine;
    }
    if (title.contains('ቀደሙ') ||
        title.contains('ተሞክሮ') ||
        title.contains('memories') ||
        title.contains('memory') ||
        title.contains('past') ||
        title.contains('experience')) {
      return personalMemories;
    }
    if (title.contains('መዝናኛ') ||
        title.contains('ስፖርት') ||
        title.contains('hobbies') ||
        title.contains('hobby') ||
        title.contains('entertainment') ||
        title.contains('music')) {
      return personalHobbies;
    }
    if (title.contains('ሳምንት') ||
        title.contains('እቅድ') ||
        title.contains('weekend') ||
        title.contains('plan') ||
        title.contains('plans')) {
      return personalWeekend;
    }
    if (title.contains('የማይወዷቸው') ||
        title.contains('የሚወዷቸው') ||
        title.contains('likes') ||
        title.contains('dislikes') ||
        title.contains('like')) {
      return personalLikes;
    }

    // 5. Greetings
    if (title.contains('ሰላምታ') ||
        title.contains('ራስን ማስተዋወቅ') ||
        title.contains('hello') ||
        title.contains('greeting')) {
      return greetHello;
    }
    if (title.contains('የሚኖሩበት') ||
        title.contains('ቦታ') ||
        title.contains('where you live')) {
      return greetWhereYouLive;
    }
    if (title.contains('ቤተሰብ') || title.contains('family')) {
      return greetFamily;
    }

    // 6. Public Services
    if (title.contains('ፖስታ') ||
        title.contains('post office') ||
        title.contains('mail') ||
        title.contains('letter')) {
      return publicPostOffice;
    }
    if (title.contains('መረጃ') ||
        title.contains('information') ||
        title.contains('asking for info')) {
      return publicInformation;
    }

    // 7. Contextual Fallback based on Module Topic
    if (mod.contains('ምግብ') || mod.contains('ግብይት') || mod.contains('food')) {
      final foodList = [
        foodGrocery,
        foodRestaurant,
        foodMarket,
        foodFavourite,
        foodFasting,
        foodBill,
        reviewSpeaking,
      ];
      return foodList[index % foodList.length];
    }

    if (mod.contains('ጉዞ') || mod.contains('travel')) {
      final travelList = [
        travelTransport,
        travelTickets,
        travelSafety,
        travelMaps,
        travelQuestions,
        travelEmergency,
        reviewSpeaking,
      ];
      return travelList[index % travelList.length];
    }

    if (mod.contains('ሕይወት') || mod.contains('ግል') || mod.contains('life') || mod.contains('personal')) {
      final lifeList = [
        personalAboutYou,
        personalRoutine,
        personalMemories,
        personalHobbies,
        personalWeekend,
        personalLikes,
        reviewSpeaking,
      ];
      return lifeList[index % lifeList.length];
    }

    if (mod.contains('አገልግሎት') || mod.contains('service') || mod.contains('public')) {
      final serviceList = [
        publicPostOffice,
        publicInformation,
        publicCityReview,
      ];
      return serviceList[index % serviceList.length];
    }

    if (mod.contains('ሰላምታ') || mod.contains('greeting')) {
      final greetList = [
        greetHello,
        greetWhereYouLive,
        greetFamily,
        reviewSpeaking,
      ];
      return greetList[index % greetList.length];
    }

    // 8. General deterministic fallback across all user lesson SVGs
    return _allLessons[index % _allLessons.length];
  }

  /// Resolves the module header illustration SVG using user's uploaded module SVGs.
  static String resolveModuleSvg(String? moduleName, [int sortOrder = 0]) {
    final name = (moduleName ?? '').toLowerCase();

    if (name.contains('ምግብ') || name.contains('ግብይት') || name.contains('food')) {
      return moduleFood;
    }
    if (name.contains('ጉዞ') || name.contains('travel')) {
      return moduleTravel;
    }
    if (name.contains('ግል') ||
        name.contains('ሕይወት') ||
        name.contains('personal') ||
        name.contains('life')) {
      return modulePersonalLife;
    }
    if (name.contains('አገልግሎት') ||
        name.contains('service') ||
        name.contains('public')) {
      return modulePublicServices;
    }
    if (name.contains('ሰላምታ') || name.contains('greeting')) {
      return moduleGreetings;
    }
    if (name.contains('ስራ') || name.contains('ሙያ') || name.contains('work')) {
      return moduleWork;
    }
    if (name.contains('ቤት') || name.contains('home')) {
      return moduleHome;
    }
    if (name.contains('ዕለት') || name.contains('daily')) {
      return moduleDailyLife;
    }

    final moduleCycle = [
      modulePersonalLife,
      moduleWork,
      moduleDailyLife,
      moduleTravel,
      moduleFood,
      modulePublicServices,
      moduleGreetings,
      moduleHome,
    ];

    return moduleCycle[sortOrder % moduleCycle.length];
  }
}
