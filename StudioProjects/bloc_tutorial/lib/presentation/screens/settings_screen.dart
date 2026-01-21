import 'package:bloc_tutorial/presentation/screens/third_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../logic/cubit/counter_cubit.dart';
import '../../logic/cubit/counter_state.dart';
import '../../logic/cubit/settings_cubit.dart';

class SettingsScreen extends StatefulWidget {
  static const String kSettingsScreen = '/settings_screen';

  final String title;
  final Color backgroundColor;

  const SettingsScreen(
      {super.key, required this.title, required this.backgroundColor});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) => _buildScaffold();

  Widget _buildScaffold() => BlocListener<SettingsCubit, SettingsState>(
  listener: (context, state) {
      if(state is SettingsLoaded ){
        if(state.appNotifications && !state.emailNotifications){
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('App Notifications Enabled, Email Notifications Disabled'),
            ),);
        }else if (!state.appNotifications && state.emailNotifications){
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('App Notifications Disabled, Email Notifications Enabled'),
            ),);
        }else if( state.emailNotifications && state.appNotifications){
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('App Notifications and Email Notifications are Enabled'),
            ),);
        }else if(!state.appNotifications && !state.emailNotifications){
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('App Notifications and Email Notifications Disabled'),
            ),);
        }
      }

  },
  child: Scaffold(
        appBar: _buildAppBar(),
        body: _buildBody(),
      ),
);

  PreferredSizeWidget _buildAppBar() => AppBar(
        title: Text(
          widget.title,
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: widget.backgroundColor,
        iconTheme: IconThemeData(color: Colors.white),
      );

  Widget _buildBody() => BlocBuilder<SettingsCubit, SettingsState>(
        builder: (context, state) {
          if (state is SettingsLoaded) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: _buildBodyChildren(state),
            );
          }
          return Center(child: CircularProgressIndicator());
        },
      );

  List<Widget> _buildBodyChildren(SettingsLoaded state) =>
      [_buildAppNotification(state), _buildEmailNotification(state)];

  Widget _buildEmailNotification(SettingsLoaded state) => SwitchListTile(
      value: state.emailNotifications,
      title: Text('Email Notifications'),
      onChanged: (value) =>
          context.read<SettingsCubit>().toggleEmailNotifications(value));

  Widget _buildAppNotification(SettingsLoaded state) => SwitchListTile(
      value: state.appNotifications,
      title: Text('App Notifications'),
      onChanged: (value) =>
          context.read<SettingsCubit>().toggleAppNotifications(value));
}
