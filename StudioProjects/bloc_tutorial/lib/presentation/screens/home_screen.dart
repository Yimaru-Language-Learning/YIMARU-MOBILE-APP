import 'package:bloc_tutorial/logic/cubit/internet_cubit.dart';
import 'package:bloc_tutorial/presentation/screens/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../constants/enums.dart';
import '../../logic/cubit/counter_cubit.dart';
import '../../logic/cubit/counter_state.dart';

class HomeScreen extends StatefulWidget {
  static const String kHomeScreen = '/';

  const HomeScreen(
      {super.key, required this.title, required this.backgroundColor});

  final String title;
  final Color backgroundColor;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void _buildCounterListener(
      {required BuildContext context, required CounterState state}) {
    if (state.wasIncremented) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Incremented'),
        ),
        snackBarAnimationStyle: AnimationStyle(
          duration: Duration(milliseconds: 50),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Decremented'),
        ),
        snackBarAnimationStyle: AnimationStyle(
          duration: Duration(milliseconds: 50),
        ),
      );
    }
  }

  void _buildConnectivityListener(
      {required BuildContext context, required InternetState state}) {
    if (state is InternetConnected &&
        state.connectionType == ConnectionType.wifi) {
      //  BlocProvider.of<CounterCubit>(context).increment();
    } else if (state is InternetConnected &&
        state.connectionType == ConnectionType.mobile) {
      //   BlocProvider.of<CounterCubit>(context).decrement();
    }
  }

  @override
  Widget build(BuildContext context) {
    return _buildBody();
  }

  Widget _buildBody() => BlocListener<InternetCubit, InternetState>(
        listener: (context, state) =>
            _buildConnectivityListener(context: context, state: state),
        child: _buildScaffold(),
      );

  Widget _buildScaffold() => Scaffold(
        appBar: _buildAppBar(),
        body: _buildColumn(),
        // This trailing comma makes auto-formatting nicer for build methods.
      );

  PreferredSizeWidget _buildAppBar() => AppBar(
        backgroundColor: widget.backgroundColor,
        title: Text(widget.title,style: TextStyle(color: Colors.white),),
      );

  Widget _buildColumn() => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _buildConnectivityState(),
            _buildCounterState(),
            _buildBuilder(),
            SizedBox(height: 5),
            _buildSelectBuilder(),
            SizedBox(height: 5),
            _buildActionButtons(),
            _buildSecondScreenButton(),
            SizedBox(height: 35),
          ],
        ),
      );

  Widget _buildConnectivityState() => BlocBuilder<InternetCubit, InternetState>(
        builder: (context, state) =>
            _buildConnectivityBuilder(context: context, state: state),
      );

  Widget _buildConnectivityBuilder(
      {required BuildContext context, required InternetState state}) {
    if (state is InternetConnected &&
        state.connectionType == ConnectionType.wifi) {
      return const Text(
        'Wifi',
      );
    } else if (state is InternetConnected &&
        state.connectionType == ConnectionType.mobile) {
      return const Text(
        'Mobile',
      );
    } else if (state is InternetDisconnected) {
      return const Text(
        'No Internet',
      );
    }
    return CircularProgressIndicator();
  }

  Widget _buildCounterState() => BlocConsumer<CounterCubit, CounterState>(
        builder: (BuildContext context, state) => _buildCounterValue(state),
        listener: (context, state) =>
            _buildCounterListener(context: context, state: state),
      );

  Widget _buildBuilder() => Builder(builder: (context) {
    final CounterState counterState = context.watch<CounterCubit>().state;
    final InternetState internetState = context.watch<InternetCubit>().state;
      if(internetState is InternetConnected && internetState.connectionType == ConnectionType.wifi){
        return Text('Counter:${counterState.counterValue} Internet: Wifi');
      }else   if(internetState is InternetConnected && internetState.connectionType == ConnectionType.mobile){
        return Text('Counter:${counterState.counterValue} Internet: Mobile');
      }else   if(internetState is InternetConnected && internetState.connectionType == ConnectionType.vpn){
        return Text('Counter:${counterState.counterValue} Internet: Vpn');
      }else{
        return Text('Counter:${counterState.counterValue} Internet: Disconnected');
      }

  });

  Widget _buildSelectBuilder() => Builder(builder: (context) {
    final int counterValue = context.select<CounterCubit,int>((CounterCubit cubit) => cubit.state.counterValue);

      return Text('Counter: $counterValue');


  });

  Widget _buildCounterValue(CounterState state) => Text(
        state.counterValue < 0 ? '0' : '${state.counterValue}',
        style: Theme.of(context).textTheme.headlineMedium,
      );

  Widget _buildActionButtons() => Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildMinusButton(),
          _buildAddButton(),
        ],
      );

  Widget _buildMinusButton() => FloatingActionButton(
    heroTag: 'Minus',
        onPressed: () => context.read<CounterCubit>().decrement(),
        child: Icon(Icons.remove),
      );

  Widget _buildAddButton() => FloatingActionButton(
    heroTag: 'Add',
        onPressed: () => context.read<CounterCubit>().increment(),
        child: Icon(Icons.add),
      );

  Widget _buildSecondScreenButton() => ElevatedButton(

        onPressed: () =>
            Navigator.pushNamed(context, SettingsScreen.kSettingsScreen),
        child: Text('Second Screen'),
      );
}
