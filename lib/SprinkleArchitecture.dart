import 'package:buildadroid/FeatureLocatorGetIt/app_model.dart';
import 'package:buildadroid/FeatureManage/QuizzManager.dart';
import 'package:buildadroid/Models/QuizzModel.dart';
import 'package:flutter/material.dart';
import 'package:sprinkle/Observer.dart';
import 'package:sprinkle/SprinkleExtension.dart';
import 'main.dart';

class SprikleArchitecture extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ManagerQuizz manager = context.fetch<ManagerQuizz>();

        
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: ()=> sl<AppModel>().increment()),
       appBar: AppBar(title: Text("quiz bloc")),
       body: Observer(
         stream: manager.collection$,
         onSuccess: (context, List<QuizzModel> data){
           return Observer<int>(
             stream: manager.counter$,
             onSuccess: (context, index) {
               return Column(
                 children: <Widget>[
                   StreamBuilder<Object>(
                     stream: sl<AppModel>().counter$,
                     builder: (context, snapshot) {
                       return Text(snapshot.data.toString());
                     }
                   ),
                   Container(
                     margin: EdgeInsets.all(10),
                     alignment: Alignment.center, child: Text(data[index].question),),
                     ...data[index].response.map((response)=> Container(
                       width: double.infinity,
                     alignment:Alignment.center,
                     child: RaisedButton(
                       color: Colors.blue,
                       onPressed: ()=> manager.handlerQuestion(score: response.score),
                       child: Text(response.text)))
                   ).toList(),
                 ]
               );
             }
           );
         },
         onError: (context, error)=> Center(child: Column(
           children: <Widget>[
             Text(error),
             FlatButton(onPressed: manager.reset, child: Text("Reset the Game")),
             Observer<String>(
               stream: manager.score$,
               onSuccess: (context, data) {
                 return Text(data);
               }
             )
           ],
         )),
       ),
    );
  }
}
