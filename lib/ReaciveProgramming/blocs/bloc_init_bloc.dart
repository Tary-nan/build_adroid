import 'package:buildadroid/ReaciveProgramming/blocs/bloc_event_state.dart';
import 'package:buildadroid/ReaciveProgramming/widgets/app_init_state.dart';
import 'package:buildadroid/ReaciveProgramming/widgets/app_int_event.dart';

class ApplicationInitializationBloc
    extends BlocEventStateBase<ApplicationInitializationEvent, ApplicationInitializationState> {
  ApplicationInitializationBloc()
      : super(
    initialState: ApplicationInitializationState.notInitialized(),
  );
  
  @override
  Stream<ApplicationInitializationState> eventHandler(
      ApplicationInitializationEvent event, ApplicationInitializationState currentState) async* {
    if (!currentState.isInitialized){
      yield ApplicationInitializationState.notInitialized();
    }

    if (event.type == ApplicationInitializationEventType.start) {
      for (int progress = 0; progress < 101; progress += 1){
        await Future.delayed(const Duration(milliseconds: 300));
        yield ApplicationInitializationState.progressing(progress);
      }
    }

    if (event.type == ApplicationInitializationEventType.stop){
      yield ApplicationInitializationState.initialized();
    }
  }
}