import 'dart:async';

mixin Validation {

  

    final validateName  = StreamTransformer<String, String>.fromHandlers(
      handleData: (String value, EventSink<String> sink){

        if(value.trim().isEmpty || value.length < 3 || RegExp(r'[!@#<>?":_`~;[\]\\|=+)(*&^%0-9-]').hasMatch(value)){
          return sink.addError("veuillez entrer un nom valid contenant au moins 3 lettre");
        }else{
          return sink.add(value.trim());
        }
      }
  );



  final validatePrice  = StreamTransformer<double, double>.fromHandlers(
      handleData: (double value, EventSink<double> sink){


        if(value is double ){
          return sink.add(value);
        }else{
          return sink.addError("ce n'est un double");
        }
      }
  );


}
