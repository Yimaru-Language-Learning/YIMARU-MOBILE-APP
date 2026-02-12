import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:yimaru_app/ui/views/learn_practice/screens/listen_speaker_screen.dart';
import 'package:yimaru_app/ui/views/learn_practice/screens/practice_intro_screen.dart';
import 'package:yimaru_app/ui/views/learn_practice/screens/start_practice_screen.dart';
import 'package:yimaru_app/ui/widgets/profile_image.dart';
import 'package:yimaru_app/ui/widgets/speaking_partner_image.dart';

import '../../common/app_colors.dart';
import '../../common/ui_helpers.dart';
import '../../widgets/custom_elevated_button.dart';
import '../../widgets/small_app_bar.dart';
import 'learn_practice_viewmodel.dart';

class LearnPracticeView extends StackedView<LearnPracticeViewModel> {
  const LearnPracticeView({Key? key}) : super(key: key);

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



  Widget _buildPracticeScreensWrapper(LearnPracticeViewModel viewModel) => PopScope(
      canPop: true,
      onPopInvokedWithResult: (value, data) {
        if (!value) return;
        WidgetsBinding.instance.addPostFrameCallback((_) => viewModel.goBack());
      },
      child: _buildScaffoldWrapper(viewModel));

  Widget _buildScaffoldWrapper(LearnPracticeViewModel viewModel) => Scaffold(
    backgroundColor: kcBackgroundColor,
    body: _buildScaffoldStack(viewModel),
  );

  Widget _buildScaffoldStack(LearnPracticeViewModel viewModel) => Stack(children: [
    _buildBody(viewModel),
    //_buildLoginWithEmailState(viewModel),
    //_buildLoginWithGoogleState(viewModel)
  ]);




  Widget _buildBody(LearnPracticeViewModel viewModel) =>
      IndexedStack(

          index: viewModel.currentIndex, children: _buildScreens());

  List<Widget> _buildScreens() => [
    _buildPracticeIntroScreen(),
    _buildStartPracticeScreen(),
    _buildListenSpeakerScreen()
  ];

  Widget _buildPracticeIntroScreen() => const PracticeIntroScreen();

  Widget _buildStartPracticeScreen() => const StartPracticeScreen();

  Widget _buildListenSpeakerScreen() => const ListenSpeakerScreen();


}
