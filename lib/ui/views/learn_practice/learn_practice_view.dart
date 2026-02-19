import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:yimaru_app/ui/views/learn_practice/screens/finish_learn_practice_screen.dart';
import 'package:yimaru_app/ui/views/learn_practice/screens/learn_practice_completion_screen.dart';
import 'package:yimaru_app/ui/views/learn_practice/screens/learn_practice_result_screen.dart';
import 'package:yimaru_app/ui/views/learn_practice/screens/listen_learn_practice_speaker_screen.dart';
import 'package:yimaru_app/ui/views/learn_practice/screens/learn_practice_intro_screen.dart';
import 'package:yimaru_app/ui/views/learn_practice/screens/speak_to_learn_practice_listener_screen.dart';
import 'package:yimaru_app/ui/views/learn_practice/screens/start_learn_practice_screen.dart';
import 'package:yimaru_app/ui/widgets/profile_image.dart';
import 'package:yimaru_app/ui/widgets/speaking_partner_image.dart';

import '../../common/app_colors.dart';
import '../../common/ui_helpers.dart';
import '../../widgets/custom_elevated_button.dart';
import '../../widgets/small_app_bar.dart';
import 'learn_practice_viewmodel.dart';

class LearnPracticeView extends StackedView<LearnPracticeViewModel> {
  final String title;
  final String subtitle;
  final String buttonLabel;

  const LearnPracticeView(
      {Key? key,
      required this.title,
      required this.subtitle,
      required this.buttonLabel})
      : super(key: key);

  @override
  LearnPracticeViewModel viewModelBuilder(BuildContext context) =>
      LearnPracticeViewModel();

  @override
  Widget builder(
    BuildContext context,
    LearnPracticeViewModel viewModel,
    Widget? child,
  ) =>
      _buildPracticeScreensWrapper(viewModel);

  Widget _buildPracticeScreensWrapper(LearnPracticeViewModel viewModel) =>
      PopScope(
          canPop: true,
          onPopInvokedWithResult: (value, data) {
            if (!value) return;
            WidgetsBinding.instance
                .addPostFrameCallback((_) => viewModel.goBack());
          },
          child: _buildScaffoldWrapper(viewModel));

  Widget _buildScaffoldWrapper(LearnPracticeViewModel viewModel) => Scaffold(
        backgroundColor: kcBackgroundColor,
        body: _buildScaffoldStack(viewModel),
      );

  Widget _buildScaffoldStack(LearnPracticeViewModel viewModel) =>
      Stack(children: [
        _buildBody(viewModel),
        //_buildLoginWithEmailState(viewModel),
        //_buildLoginWithGoogleState(viewModel)
      ]);

  Widget _buildBody(LearnPracticeViewModel viewModel) =>
      IndexedStack(index: viewModel.currentIndex, children: _buildScreens());

  List<Widget> _buildScreens() => [
        _buildLearnPracticeIntroScreen(),
        _buildStartLearnPracticeScreen(),
        _buildListenLearnPracticeSpeakerScreen(),
        _buildSpeakToLearnPracticeListenerScreen(),
        _buildFinishLearnPracticeScreen(),
        _buildLearnPracticeResultScreen(),
    _buildLearnPracticeCompletionScreen()
      ];

  Widget _buildLearnPracticeIntroScreen() => LearnPracticeIntroScreen(
        title: title,
        subtitle: subtitle,
        buttonLabel: buttonLabel,
      );

  Widget _buildStartLearnPracticeScreen() => const StartLearnPracticeScreen();

  Widget _buildListenLearnPracticeSpeakerScreen() =>
      const ListenLearnPracticeSpeakerScreen();

  Widget _buildSpeakToLearnPracticeListenerScreen() =>
      const SpeakToLearnPracticeListenerScreen();

  Widget _buildFinishLearnPracticeScreen() => const FinishLearnPracticeScreen();

  Widget _buildLearnPracticeResultScreen() => const LearnPracticeResultScreen();

  Widget _buildLearnPracticeCompletionScreen() => const LearnPracticeCompletionScreen();

}
