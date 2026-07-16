import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:yimaru_app/ui/common/app_colors.dart';
import 'package:yimaru_app/ui/common/helper_functions.dart';
import 'package:yimaru_app/ui/widgets/custom_circular_progress_indicator.dart';

import '../../common/enmus.dart';
import 'pdf_viewmodel.dart';

class PdfView extends StackedView<PdfViewModel> {
  final String url;

  const PdfView({Key? key, required this.url}) : super(key: key);

  @override
  void onViewModelReady(PdfViewModel viewModel) async {
    super.onViewModelReady(viewModel);
  }

  @override
  PdfViewModel viewModelBuilder(BuildContext context) => PdfViewModel();

  @override
  Widget builder(
    BuildContext context,
    PdfViewModel viewModel,
    Widget? child,
  ) =>
      _buildScaffoldWrapper(viewModel);

  Widget _buildScaffoldWrapper(PdfViewModel viewModel) => Scaffold(
        backgroundColor: kcBackgroundColor,
        body: _buildScaffoldStack(viewModel),
      );

  Widget _buildScaffoldStack(PdfViewModel viewModel) => Stack(
        children: [
          _buildPdfViewerWrapper(viewModel),
          _buildSafeBackButton(viewModel),
        ],
      );

  Widget _buildSafeBackButton(PdfViewModel viewModel) => SafeArea(
        child: _buildBackButtonWrapper(viewModel),
      );

  Widget _buildBackButtonWrapper(PdfViewModel viewModel) => Padding(
        padding: const EdgeInsets.all(15),
        child: _buildBackButton(viewModel),
      );

  Widget _buildBackButton(PdfViewModel viewModel) => BackButton(
        onPressed: viewModel.pop,
        color: kcPrimaryColor,
      );

  Widget _buildPdfViewerWrapper(PdfViewModel viewModel) =>
      SafeArea(child: _buildPdfViewerState(viewModel));

  Widget _buildPdfViewerState(PdfViewModel viewModel) =>
      viewModel.busy(StateObjects.openPdf)
          ? _buildLoadingIndicator()
          : _buildPdfViewer(viewModel);

  Widget _buildLoadingIndicator() => const Center(
        child: CustomCircularProgressIndicator(color: kcPrimaryColor),
      );

  Widget _buildPdfViewer(PdfViewModel viewModel) => SfPdfViewer.network(getReadableUrl(url) ?? '');
}
