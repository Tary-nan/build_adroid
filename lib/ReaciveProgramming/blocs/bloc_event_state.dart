import 'package:buildadroid/ReaciveProgramming/blocs/bloc_provider.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';

abstract class BlocEvent extends Object {}
abstract class BlocState extends Object {}

abstract class BlocEventStateBase<BlocEvent, BlocState> implements BlocBase {
  PublishSubject<BlocEvent> _eventController = PublishSubject<BlocEvent>();
  BehaviorSubject<BlocState> _stateController = BehaviorSubject<BlocState>();

  ///
  /// j'accepte les event emit du type  Function(BlocEvent)
  /// example: emitEvent.add(AuthManagerEvent())
  ///
  Function(BlocEvent) get emitEvent => _eventController.sink.add;

  ///
  /// Current/Et New state
  ///
  Stream<BlocState> get state => _stateController.stream;

  /// l' event emit dans emitEvent 
  /// => declenchera une action menant à un ou plusieurs états;
  /// => eventHandler <= l'action appeler
  ///
  Stream<BlocState> eventHandler(BlocEvent event, BlocState currentState);

  ///
  /// initialState
  ///
  final BlocState initialState;

  //
  // Constructor
  //
  BlocEventStateBase({
    @required this.initialState,
  }){
    // Pour chaque event emit , nous appellons ou encore declanchons l' action [eventHandler]
    // un nouvel etat est creer
    //
    _eventController.listen((BlocEvent event){
      BlocState currentState = _stateController.value ?? initialState;
      eventHandler(event, currentState).forEach((BlocState newState){
        _stateController.sink.add(newState);
      });
    });
  }

  @override
  void dispose() {
    _eventController.close();
    _stateController.close();
  }
}