import 'package:buildadroid/ReaciveProgramming/blocs/bloc_event_state.dart';
import 'package:buildadroid/ReaciveProgramming/blocs/bloc_init_bloc.dart';
import 'package:buildadroid/ReaciveProgramming/screens/auth_screen.dart';
// import 'package:buildadroid/ReaciveProgramming/screens/bloc_decision_screen.dart';
import 'package:buildadroid/ReaciveProgramming/widgets/app_init_state.dart';
import 'package:buildadroid/ReaciveProgramming/widgets/app_int_event.dart';
import 'package:flutter/material.dart';

class InitializationPage extends StatefulWidget {
  @override
  _InitializationPageState createState() => _InitializationPageState();
}

class _InitializationPageState extends State<InitializationPage> {
  ApplicationInitializationBloc bloc;

  @override
  void initState(){
    super.initState();
    bloc = ApplicationInitializationBloc();
    bloc.emitEvent(ApplicationInitializationEvent());
  }

  @override
  void dispose(){
    bloc?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext pageContext) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          child: Center(
            child: BlocEventStateBuilder<ApplicationInitializationEvent, ApplicationInitializationState>(
              bloc: bloc,
              builder: (BuildContext context, ApplicationInitializationState state){
                if (state.isInitialized){
                  //
                  // Once the initialization is complete, let's move to another page
                  //
                  WidgetsBinding.instance.addPostFrameCallback((_){
                    Navigator.of(context).pushReplacementNamed(AuthenticationScreen.routeName);
                  });
                }
                return Text('Initialization in progress... ${state.progress}%');
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