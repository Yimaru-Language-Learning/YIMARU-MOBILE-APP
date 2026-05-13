import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'course_unit_viewmodel.dart';

class CourseUnitView extends StackedView<CourseUnitViewModel> {
  const CourseUnitView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    CourseUnitViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Container(
        padding: const EdgeInsets.only(left: 25.0, right: 25.0),
        child: const Center(child: Text("CourseUnitView")),
      ),
    );
  }

  @override
  CourseUnitViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      CourseUnitViewModel();
}
