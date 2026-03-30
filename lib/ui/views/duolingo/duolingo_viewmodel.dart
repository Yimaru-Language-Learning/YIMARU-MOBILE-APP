import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:yimaru_app/ui/common/enmus.dart';

import '../../../app/app.locator.dart';

class DuolingoViewModel extends FormViewModel {
  // Dependency injection
  final _navigationService = locator<NavigationService>();

  bool _assessmentFocus = false;

  bool get focusAssessment => _assessmentFocus;

  // Speaking state
  bool _isSpeaking = false;

  bool get isSpeaking => _isSpeaking;

  // In-app navigation
  int _currentPage = 0;

  int get currentPage => _currentPage;

  // Assessments
  Map<String, dynamic> _selectedAssessment = {
    'label': 'Speaking 01',
    'intro_title': 'Speak About the Photo',
    'type': DuolingoAssessmentType.speaking,
    'outro_title': 'Speaking Practice Completed',
    'outro_subtitle': 'You’ve finished this speaking session. Great work!',
    'intro_subtitle':
        'Prepare to speak for at least 30 seconds about the photo you are shown',
  };

  Map<String, dynamic> get selectedAssessment => _selectedAssessment;

  // Practices
  final List<Map<String, dynamic>> _assessments = [
    {
      'label': 'Speaking 01',
      'intro_title': 'Speak About the Photo',
      'type': DuolingoAssessmentType.speaking,
      'outro_title': 'Speaking Practice Completed',
      'outro_subtitle': 'You’ve finished this speaking session. Great work!',
      'intro_subtitle':
          'Prepare to speak for at least 30 seconds about the photo you are shown'
    },
    {
      'label': 'Speaking 02',
      'intro_title': 'Read, Then Speak',
      'type': DuolingoAssessmentType.speaking,
      'outro_title': 'Speaking Practice Completed',
      'intro_subtitle': 'You will speak about the given topic',
      'outro_subtitle': 'You’ve finished this speaking session. Great work!',
    },
    {
      'label': 'Speaking 03',
      'intro_title': 'Speaking Sample',
      'type': DuolingoAssessmentType.speaking,
      'outro_title': 'Speaking Practice Completed',
      'intro_subtitle': 'You’ll speak for 1–3 minutes about a given topic.',
      'outro_subtitle': 'You’ve finished this speaking session. Great work!',
    },
    {
      'label': 'Speaking 04',
      'intro_title': 'Interactive Speaking',
      'type': DuolingoAssessmentType.speaking,
      'outro_title': 'Speaking Practice Completed',
      'intro_subtitle': ' You’ll answer a series of short questions.',
      'outro_subtitle': 'You’ve finished this speaking session. Great work!',
    },
    {
      'label': 'Writing 05',
      'intro_title': 'Write About the Photo',
      'type': DuolingoAssessmentType.writing,
      'outro_title': 'Writing Practice Completed',
      'outro_subtitle': 'You’ve finished this writing session. Great work!',
      'intro_subtitle':
          'You will see a picture and write a short description based on what you observe. Focus on clear, simple sentences.'
    },
    {
      'label': 'Writing 06',
      'intro_title': 'Writing Sample',
      'type': DuolingoAssessmentType.writing,
      'outro_title': 'Writing Practice Completed',
      'outro_subtitle': 'You’ve finished this writing session. Great work!',
      'intro_subtitle':
          'You will write a longer response based on a given question. Your writing will be shared with institutions as part of your score.'
    },
    {
      'label': 'Writing 07',
      'type': DuolingoAssessmentType.writing,
      'outro_title': 'Writing Practice Completed',
      'intro_title': 'Interactive Writing Part 1',
      'outro_subtitle': 'You’ve finished this writing session. Great work!',
      'intro_subtitle':
          ' You will write short and simple sentences.  Focus on basic ideas and clear meaning.  Write naturally and manage your time.'
    },
    {
      'label': 'Writing 08',
      'type': DuolingoAssessmentType.writing,
      'intro_title': 'Interactive Writing Part 2',
      'outro_title': 'Writing Practice Completed',
      'outro_subtitle': 'You’ve finished this writing session. Great work!',
      'intro_subtitle':
          ' You will continue writing on a related idea.  Add more details using clear sentences.  Stay focused and complete your response within the time.'
    },
    {
      'label': 'Listening 09',
      'intro_title': 'Listen and Type',
      'type': DuolingoAssessmentType.listening,
      'outro_title': 'Listening Practice Completed',
      'intro_subtitle':
          'You will hear a short audio clip. Type exactly what you hear.',
      'outro_subtitle': 'You’ve finished this Listening session. Great work!',
    },
    {
      'label': 'Listening 10',
      'type': DuolingoAssessmentType.listening,
      'outro_title': 'Listening Practice Completed',
      'intro_title': 'Interactive Listening - Part 1',
      'intro_subtitle': ' Listen carefully and complete the missing words.',
      'outro_subtitle': 'You’ve finished this Listening session. Great work!',
    },
    {
      'label': 'Listening 11',
      'type': DuolingoAssessmentType.listening,
      'outro_title': 'Listening Practice Completed',
      'intro_title': 'Interactive Listening - Part 2',
      'intro_subtitle': 'Listen and choose the correct option.',
      'outro_subtitle': 'You’ve finished this Listening session. Great work!',
    },
    {
      'label': 'Assessment 12',
      'type': DuolingoAssessmentType.listening,
      'title': 'Interactive Listening - Part 3',
      'outro_title': 'Listening Practice Completed',
      'subtitle': 'Write a summary of the conversation you just had',
      'outro_subtitle': 'You’ve finished this Listening session. Great work!',
    },
    {
      'label': 'Reading 13',
      'intro_title': 'Read and Select',
      'type': DuolingoAssessmentType.reading,
      'intro_subtitle':
          'Read the sentence and select the option that correctly completes the meaning.'
    },
    {
      'label': 'Reading 14',
      'intro_title': 'Fill in the blank',
      'type': DuolingoAssessmentType.reading,
      'intro_subtitle': 'Complete the sentences by filling in the missing words'
    },
  ];

  List<Map<String, dynamic>> get assessments => _assessments;

  // Listening assessment
  String? _selectedListeningAssessment;

  String? get selectedListeningAssessment => _selectedListeningAssessment;

  final List<String> _listeningAssessments = [
    'The history of urban planning',
    'The challenge of sustainable urban development',
    'Case studies of smart cities',
  ];

  List<String> get listeningAssessments => _listeningAssessments;

  // Topics
  void setAssessmentFocus() {
    _assessmentFocus = true;
    rebuildUi();
  }

  // Speaking state
  void setSpeakingState() {
    _isSpeaking = !_isSpeaking;
    rebuildUi();
  }

  // Set assessment
  void setSelectedAssessment(
      {required int page, required Map<String, dynamic> assessment}) {
    _selectedAssessment = assessment;
    goTo(page);
  }

  // Listening assessment

  void setSelectedListeningAssessment(String value) {
    _selectedListeningAssessment = value;
    rebuildUi();
  }

  bool isSelectedListeningAssessment(String value) =>
      _selectedListeningAssessment == value;

  // In-app navigation
  void goTo(int page) {
    _currentPage = page;
    rebuildUi();
  }

  void goBack() {
    if (_currentPage == 0) {
      pop();
    } else {
      _currentPage--;
      rebuildUi();
    }
  }

  // Navigation
  void pop() => _navigationService.back();
}
