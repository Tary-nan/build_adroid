class ExpenseModel {

  ExpenseModel({this.name, this.price, this.date});

  final String name;
  final double price;
  final DateTime date;
}

class DataProvider {

  static final List<ExpenseModel> _data = [
    ExpenseModel(
      name: "New Shoes",
      price: 99.99,
      date: DateTime.now()
    ),
    ExpenseModel(
      name: "Old Shoes",
      price: 12.89,
      date: DateTime.now()
    ),
    ExpenseModel(
      name: "Books",
      price: 23.69,
      date: DateTime.now()
    )

  ];
  static List<ExpenseModel> get data => _data;
  
}