import 'package:buildadroid/ReaciveProgramming/blocs/bloc_event_state.dart';

class TemplateEventStateBloc extends BlocEventStateBase<BlocEvent, BlocState> {
  /*TemplateEventStateBloc()
      : super(
    initialState: BlocState.notInitialized(),
  );

   */

  @override
  Stream<BlocState> eventHandler( BlocEvent event, BlocState currentState) async* {
    //yield BlocState.notInitialized();
  }
}