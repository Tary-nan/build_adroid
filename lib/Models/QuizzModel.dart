class QuizzModel {
  QuizzModel({this.question, this.response});
  final String question;
  final List<Response> response;
}

class Response {
  Response({this.text, this.score});
  final String text;
  final int score;
}



class FournisseurOfData {

  static  List<QuizzModel> _data = [
    QuizzModel(
      question: "Quelle est votre nom",
      response: [
        Response(text: "Julien",score: 3),
        Response(text: "Damso",score: 0),
        Response(text: "Ninho",score: 10),
      ]
    ),
    QuizzModel(
      question: "Quelle est Age as tu",
      response: [
        Response(text: "13 ans ",score: 13),
        Response(text: "23 ans ",score: 30),
        Response(text: "66 ans ",score: 10),
      ]
    ),
    QuizzModel(
      question: "Quelle est votre nom",
      response: [
        Response(text: "Julien",score: 3),
        Response(text: "Damso",score: 0),
        Response(text: "Ninho",score: -10),
      ]
    )

  ];

  static List<QuizzModel> get data => _data;
}


