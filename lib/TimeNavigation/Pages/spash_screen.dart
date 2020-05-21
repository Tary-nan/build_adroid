import 'package:buildadroid/ReaciveProgramming/blocs/bloc_event_state.dart';
import 'package:buildadroid/TimeNavigation/FeatureManager/event_state_manager.dart';
import 'package:buildadroid/TimeNavigation/Pages/tabs_screen.dart';
import 'package:buildadroid/TimeNavigation/Widgets/splash_event.dart';
import 'package:buildadroid/TimeNavigation/Widgets/splash_sate.dart';
import 'package:flutter/material.dart';
import 'package:sprinkle/SprinkleExtension.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final manager = context.fetch<EventStateManager>();
    manager.emitEvent(SplashEvent());

    return SafeArea(
      child: Scaffold(
        body: Container(
          child: Center(
            child: BlocEventStateBuilder<SplashEvent, SplashState>(
              bloc: manager,
              builder: (BuildContext context, SplashState state){
                if (state.isInitialized){
                  WidgetsBinding.instance.addPostFrameCallback((_){
                    Navigator.of(context).pushReplacementNamed(TabsScreen.routeName);
                  });
                }
                return Text('Initialization in progress... ${state.progess}%');
              },
            ),
          ),
        ),
      ),
    );
  }
}

typedef Widget AsyncBlocEventStateBuilder<BlocState>(BuildContext context, BlocState state);

class BlocEventStateBuilder<BlocEvent,BlocState> extends StatelessWidget {
  const BlocEventStateBuilder({
    Key key,
    @required this.builder,
    @required this.bloc,
  }): assert(builder != null),
      assert(bloc != null),
      super(key: key);

  final BlocEventStateBase<BlocEvent,BlocState> bloc;
  final AsyncBlocEventStateBuilder<BlocState> builder;

  @override
  Widget build(BuildContext context){
    return StreamBuilder<BlocState>(
      stream: bloc.state,
      initialData: bloc.initialState,
      builder: (BuildContext context, AsyncSnapshot<BlocState> snapshot){
        return builder(context, snapshot.data);
      },
    );
  }
}