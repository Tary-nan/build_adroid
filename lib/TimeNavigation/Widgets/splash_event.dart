import 'package:buildadroid/ReaciveProgramming/blocs/bloc_event_state.dart';

enum EventType{
  start,
  stop,
}

class SplashEvent extends BlocEvent {

 SplashEvent({this.type : EventType.start}) : assert( type != null);
 EventType type;
}