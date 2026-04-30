import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:yimaru_app/ui/widgets/custom_linear_progress_indicator.dart';
import 'package:yimaru_app/ui/widgets/download_card.dart';

import '../../common/app_colors.dart';
import '../../common/ui_helpers.dart';
import '../../widgets/custom_elevated_button.dart';
import '../../widgets/small_app_bar.dart';
import 'downloads_viewmodel.dart';

class DownloadsView extends StackedView<DownloadsViewModel> {
  const DownloadsView({Key? key}) : super(key: key);

  @override
  DownloadsViewModel viewModelBuilder(BuildContext context) =>
      DownloadsViewModel();

  @override
  Widget builder(
    BuildContext context,
    DownloadsViewModel viewModel,
    Widget? child,
  ) =>
      _buildScaffoldWrapper(viewModel);

  Widget _buildScaffoldWrapper(DownloadsViewModel viewModel) => Scaffold(
        backgroundColor: kcBackgroundColor,
        body: _buildScaffold(viewModel),
      );

  Widget _buildScaffold(DownloadsViewModel viewModel) =>
      SafeArea(child: _buildBodyWrapper(viewModel));

  Widget _buildBodyWrapper(DownloadsViewModel viewModel) =>
      _buildBody(viewModel);

  Widget _buildBody(DownloadsViewModel viewModel) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: _buildColumn(viewModel),
      );

  Widget _buildColumn(DownloadsViewModel viewModel) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: _buildColumnChildren(viewModel),
      );

  List<Widget> _buildColumnChildren(DownloadsViewModel viewModel) => [
        verticalSpaceMedium,
        _buildAppbar(viewModel),
        verticalSpaceMedium,
        _buildContentWrapper(viewModel)
      ];

  Widget _buildAppbar(DownloadsViewModel viewModel) => SmallAppBar(
        onPop: viewModel.pop,
        showBackButton: true,
        title: 'Offline Downloads',
      );

  Widget _buildContentWrapper(DownloadsViewModel viewModel) =>
      viewModel.showDownload
          ? _buildEmptyContent(viewModel)
          : _buildContent(viewModel);

  Widget _buildContent(DownloadsViewModel viewModel) => Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: _buildContentChildren(viewModel),
      );

  List<Widget> _buildContentChildren(DownloadsViewModel viewModel) => [
        verticalSpaceMedium,
        _buildStorageSection(viewModel),
        verticalSpaceLarge,
        _buildDownloads(viewModel)
      ];

  Widget _buildStorageSection(DownloadsViewModel viewModel) => Column(
        mainAxisSize: MainAxisSize.min,
        children: _buildStorageSectionChildren(viewModel),
      );

  List<Widget> _buildStorageSectionChildren(DownloadsViewModel viewModel) => [
        _buildStorageInfoWrapper(viewModel),
        _buildStorageIndicator(),
      ];

  Widget _buildStorageInfoWrapper(DownloadsViewModel viewModel) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: _buildStorageInfoChildren(viewModel),
      );

  List<Widget> _buildStorageInfoChildren(DownloadsViewModel viewModel) =>
      [_buildStorageInfo(), _buildManageButton(viewModel)];

  Widget _buildStorageInfo() => Text.rich(
        TextSpan(text: '1.2GB', style: style14P600, children: [
          TextSpan(
            text: ' used of 2GB',
            style: style14DG600,
          )
        ]),
      );

  Widget _buildManageButton(DownloadsViewModel viewModel) => TextButton(
      onPressed: viewModel.setShowDownload, child: _buildManageText());

  Widget _buildManageText() => Text(
        'Manage Storage',
        style: style14P600,
      );

  Widget _buildStorageIndicator() => const CustomLinearProgressIndicator(
        progress: 0.75,
        activeColor: kcPrimaryColor,
        backgroundColor: kcVeryLightGrey,
      );

  Widget _buildDownloads(DownloadsViewModel viewModel) => ListView.builder(
        shrinkWrap: true,
        itemCount: viewModel.downloads.length,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) => _buildDownload(
            size: viewModel.downloads[index]['size'],
            title: viewModel.downloads[index]['title'],
            duration: viewModel.downloads[index]['duration'],
            thumbnail: viewModel.downloads[index]['thumbnail']),
      );

  Widget _buildDownload(
          {required String title,
          required String size,
          required String duration,
          required String thumbnail}) =>
      DownloadCard(
        size: size,
        title: title,
        duration: duration,
        thumbnail: thumbnail,
      );

  Widget _buildEmptyContent(DownloadsViewModel viewModel) => Expanded(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: _buildEmptyContentChildren(viewModel),
        ),
      );

  List<Widget> _buildEmptyContentChildren(DownloadsViewModel viewModel) =>
      [_buildUpperEmptyContent(viewModel), _buildGoButtonWrapper(viewModel)];

  Widget _buildUpperEmptyContent(DownloadsViewModel viewModel) => Expanded(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: _buildUpperEmptyContentChildren(viewModel),
        ),
      );

  List<Widget> _buildUpperEmptyContentChildren(DownloadsViewModel viewModel) =>
      [
        verticalSpaceMassive,
        _buildEmptyIcon(),
        verticalSpaceMedium,
        _buildEmptyTitle(),
        verticalSpaceSmall,
        _buildEmptySubtitle(),
      ];

  Widget _buildEmptyIcon() => const Icon(
        Icons.hourglass_empty,
        size: 100,
        color: kcPrimaryColor,
      );

  Widget _buildEmptyTitle() => Text(
        'Looking for something to download?',
        style: style25DG600,
        textAlign: TextAlign.center,
      );

  Widget _buildEmptySubtitle() => Text(
        'Start by exploring your learning materials and save them for offline access.',
        style: style14MG400,
        textAlign: TextAlign.center,
      );

  Widget _buildGoButtonWrapper(DownloadsViewModel viewModel) => Padding(
        padding: const EdgeInsets.only(bottom: 50),
        child: _buildGoButton(viewModel),
      );
  Widget _buildGoButton(DownloadsViewModel viewModel) => CustomElevatedButton(
        height: 55,
        borderRadius: 12,
        foregroundColor: kcWhite,
        text: 'Go to Learn Section',
        backgroundColor: kcPrimaryColor,
        onTap: viewModel.setShowDownload,
      );
}
