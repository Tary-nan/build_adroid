import 'package:buildadroid/ReaciveProgramming/blocs/bloc_event_state.dart';
import 'package:flutter/foundation.dart';

class SplashState extends BlocState {

  /// considerons ses Etat or State
  /// isInitialized pour indiquer si l’initialisation est terminée
  /// isInitializing pour savoir si nous sommes en train d’initialiser
  /// 
  
  SplashState({
    @required this.isInitialized ,
    this.isInitializing : false,
    this.progess : 0
  });

  bool isInitialized;
  bool isInitializing;
  int progess;

  ///
  /// creation de plusieur constructeur en fonction de l'etat qu'on veut afficher 
  ///
  
  factory SplashState.notInitialized () => 
      SplashState(isInitialized: false);

  factory SplashState.progressing (int progression) => 
      SplashState(isInitialized: false, isInitializing: true, progess: progression);


  factory SplashState.initialized()=>
        SplashState(isInitialized: true, progess: 100);
  
}