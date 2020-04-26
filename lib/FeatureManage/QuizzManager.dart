import 'dart:async';

import 'package:buildadroid/Models/QuizzModel.dart';
import 'package:sprinkle/Manager.dart';
import 'package:rxdart/rxdart.dart';

class ManagerQuizz implements Manager{

  BehaviorSubject<List<QuizzModel>>  _collectionSubject = BehaviorSubject<List<QuizzModel>>();
  BehaviorSubject<int>  _counterSubject = BehaviorSubject<int>();
  BehaviorSubject<int>  _totalScore = BehaviorSubject<int>();
  BehaviorSubject<int>  _curent = BehaviorSubject<int>.seeded(0);

  Stream<List<QuizzModel>> get collection$ => _collectionSubject.stream;
  int get curentIndex$ => _curent.value;

  Stream<int> get counter$ => _curent.stream;
  Stream<int> get counterCollection$ => _curent.stream;
  Stream<String> get score$ => _totalScore.stream.transform(validationScore);

  int scoreTotal = 0;

     final validationScore  = StreamTransformer<int, String>.fromHandlers(
      handleData: (int value, EventSink<String> sink){
        if( value < 5){
          sink.add(" Resultat : $value vous etes nulle");
        }else if(value > 10){
          sink.add(" Resultat : $value vous etes aussi nulle");
        }
      }
  );

  void reset(){
    List<QuizzModel> data = FournisseurOfData.data;
    _curent.add(0);
    _collectionSubject.add(data);
  }

  void handlerQuestion({int score}){
    _curent.add( curentIndex$ + 1);
    scoreTotal += score;
    _totalScore.add(scoreTotal);

    if(curentIndex$ < _counterSubject.value){
      print("more element");
    }else{
      print("moin d ellement");
      _collectionSubject.addError("Le Quizz est terminer");
    }

  }

  ManagerQuizz(){
    List<QuizzModel> data = FournisseurOfData.data;
    _collectionSubject.sink.add(data);
    _collectionSubject.listen((element)=> _counterSubject.add(element.length));
  }

  @override
  void dispose() {
     _collectionSubject.close();
     _counterSubject.close();
     _curent.close();
     _totalScore.close();
  }
}