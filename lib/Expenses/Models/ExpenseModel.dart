class ExpenseModel {

  ExpenseModel({ this.id,this.name, this.price, this.date});
  final String id;
  final String name;
  final double price;
  final DateTime date;
}

class DataProvider {

  static final List<ExpenseModel> _data = [
    ExpenseModel(
      id: 'id-1',
      name: "New Shoes",
      price: 99.99,
      date: DateTime.now()
    ),
    ExpenseModel(
      id: 'id-2',
      name: "Old Shoes",
      price: 12.89,
      date: DateTime.now()
    ),
    ExpenseModel(
      id: 'id-3',
      name: "Books",
      price: 23.69,
      date: DateTime.now()
    )

  ];
  static List<ExpenseModel> get data => _data;
  
}