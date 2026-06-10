import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:yimaru_app/ui/views/duolingo/duolingo_view.form.dart';


import '../../common/app_colors.dart';
import '../../common/validators/form_validator.dart';
import 'duolingo_viewmodel.dart';

@FormView(fields: [
  FormTextField(name: 'assessment', validator: FormValidator.validateForm),
])
class DuolingoView extends StackedView<DuolingoViewModel> with $DuolingoView {
  const DuolingoView({Key? key}) : super(key: key);



  @override
  DuolingoViewModel viewModelBuilder(BuildContext context) =>
      DuolingoViewModel();

  @override
  Widget builder(
    BuildContext context,
    DuolingoViewModel viewModel,
    Widget? child,
  ) =>
      _buildScaffoldWrapper(viewModel);

  Widget _buildScaffoldWrapper(DuolingoViewModel viewModel) => PopScope(
      canPop: true,
      onPopInvokedWithResult: (value, data) {
        if (!value) return;
        WidgetsBinding.instance.addPostFrameCallback((_) => viewModel.goBack());
      },
      child: _buildScaffold(viewModel));

  Widget _buildScaffold(DuolingoViewModel viewModel) => Scaffold(
        backgroundColor: kcBackgroundColor,
        body: _buildBody(viewModel),
      );

  Widget _buildBody(DuolingoViewModel viewModel) => IndexedStack(
      index: viewModel.currentPage, children: _buildScreens(viewModel));

  List<Widget> _buildScreens(DuolingoViewModel viewModel) => [
        // _buildDuolingoAssessmentsScreen(),
        // _buildDuolingoIntroScreen(viewModel),
        // _buildDuolingoQuestionScreen(viewModel),
        // _buildDuolingoAnswerScreen(viewModel),
        // _buildDuolingoReviewScreen(viewModel),
        // _buildDuolingoRetakeScreen(viewModel),
        // _buildDuolingoFinishScreen(viewModel),
      ];

  // Widget _buildDuolingoAssessmentsScreen() =>
  //     const DuolingoAssessmentsScreens();
  //
  // Widget _buildDuolingoIntroScreen(DuolingoViewModel viewModel) =>
  //     DuolingoIntroScreen(
  //         type: viewModel.selectedAssessment['type'],
  //         title: viewModel.selectedAssessment['intro_title'],
  //         subtitle: viewModel.selectedAssessment['intro_subtitle']);
  //
  // Widget _buildDuolingoQuestionScreen(DuolingoViewModel viewModel) =>
  //     _buildQuestionScreen(viewModel);
  //
  // Widget _buildDuolingoAnswerScreen(DuolingoViewModel viewModel) =>
  //     _buildAnswerScreen(viewModel);
  //
  // Widget _buildDuolingoReviewScreen(DuolingoViewModel viewModel) =>
  //     _buildReviewScreen(viewModel);
  //
  // Widget _buildDuolingoRetakeScreen(DuolingoViewModel viewModel) =>
  //     DuolingoRetakeScreen(
  //         title: viewModel.selectedAssessment['outro_title'],
  //         subtitle: viewModel.selectedAssessment['outro_subtitle']);
  //
  // Widget _buildDuolingoFinishScreen(DuolingoViewModel viewModel) =>
  //     DuolingoFinishScreen(
  //         title: viewModel.selectedAssessment['outro_title'],
  //         subtitle: viewModel.selectedAssessment['outro_subtitle']);
}
