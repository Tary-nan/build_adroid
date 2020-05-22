import 'package:buildadroid/ReaciveProgramming/blocs/bloc_event_state.dart';
import 'package:buildadroid/TimeNavigation/Widgets/splash_event.dart';
import 'package:buildadroid/TimeNavigation/Widgets/splash_sate.dart';
import 'package:sprinkle/Manager.dart';

class EventStateManager extends BlocEventStateBase<SplashEvent, SplashState> implements Manager {
  EventStateManager(): super(initialState: SplashState.notInitialized());



  @override
  void dispose() {
    super.dispose();
  }

  @override
  Stream<SplashState> eventHandler(SplashEvent event, SplashState currentState)async* {
    // implement eventHandler

    if(!currentState.isInitialized) yield SplashState.notInitialized();

    if(event.type ==  EventType.start){
      for (var progression = 0;  progression < 101; progression += 10) {
        await Future.delayed(Duration(milliseconds: 300));
        yield SplashState.progressing(progression);
      }
      event.type = EventType.stop;
    }


    if(event.type ==  EventType.stop){
      await Future.delayed(Duration(milliseconds: 300));
      yield SplashState.initialized();
    }

  }

  
}