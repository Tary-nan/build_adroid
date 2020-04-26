import 'package:flutter/material.dart';
import 'package:sprinkle/Manager.dart';
import '../main.dart';
import 'package:rxdart/rxdart.dart';

abstract class AppModel with ChangeNotifier {

  Stream<int> get counter$ ;
  int get curentIndex$;
  void increment();
  void azer();
  int get desc;

}

class AppModelImplementation extends AppModel implements Manager{

  BehaviorSubject<int>  _curent = BehaviorSubject<int>.seeded(0);

  int _dec = 0;

  @override
  int get desc => _dec;

  @override
  void azer(){
    _dec++;
    notifyListeners();
    print(desc);

  }


  @override
  void increment() => _curent.add(curentIndex$ + 1);

  AppModelImplementation(){
    Future.delayed(Duration(seconds: 3)).then((_) => getIt.signalReady(this));
  }

  @override
  Stream<int> get counter$ =>  _curent.stream;

  @override
  int get curentIndex$ => _curent.value;

}