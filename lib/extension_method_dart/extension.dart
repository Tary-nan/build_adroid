///
/// lorsqu'on  utilise une classe
///
class StringUtil{
  static bool isValidEmail(String str){
    return RegExp(r"^[a-zA-Z-0-9]+@[a-zA-Z-0-9]+\.[a-z]+").hasMatch(str);
  }
}

///*****************************
///
/// extension method
/// on Class String
///
/// can be getter or method and operator

extension StringExtensions on String{
  /// getter or properties
  bool get isValidEmail{
    return RegExp(r"^[a-zA-Z-0-9]+@[a-zA-Z-0-9]+\.[a-z]+").hasMatch(this);
  }
  /// methods
  String concatWithSpace(String other){
    return '$this $other';
  }
  /// Operators
  String operator &(String other) => '$this $other';

  String get firstChar => substring(0, 1);

}


extension IntExtensions on int{
  int get  addTwo => this + 2;
}

extension DoubleExtensions on double{
  double get  addTwo => this + 2;
}
/// je souhait une ecrire une propriete qui a joute 2 a int , double , num
///

extension TypeExtension<T extends num> on T {
  T get addTwoAll => this + 2;
}

extension TypeOtherExtension<T> on num {
  num addTo<T>() => this + 2;
}

extension on bool {
  int get asInteger => this == true ? 1 : 0;
}

///
/// EXAMPLE 2
///


extension Silly on String {
  void scream() => print(toUpperCase());
}

extension Sillier on int {
  void times(Function f) {
    for (var i = 0; i < this; i++) {
      f();
    }
  }
}

extension Silliest on Object {
  int nah() => hashCode + 42;
  String stop(String x) => toString() + x;
  Type please() => runtimeType;
  bool notAgain(Object other) => this != other;
}

///
///
///
///
///
///


final betty = Person('Betty Holberton', DateTime(1917, 3, 7));

final jean = Person('Jean Bartik', DateTime(1924, 12, 27));

final kay = Person('Kay Antonelli', DateTime(1921, 2, 12));

final marlyn = Person('Marlyn Meltzer', DateTime(1922));

Group getTeam() => Group({jean, betty, kay, marlyn});

class Group {
  final Set<Person> people;

  const Group(this.people);

  @override
  String toString() => people.map((p) => p.name).join(', ');
}

class Person {
  final String name;
  final DateTime dayOfBirth;

  const Person(this.name, this.dayOfBirth);
}

extension on Group {
  void removeYoungest() {
    var sorted = people.toList()
      ..sort((a, b) => a.dayOfBirth.compareTo(b.dayOfBirth));
    var youngest = sorted.last;
    people.remove(youngest);
  }

  void show() => print(this);
}


void main(){
  Group team = getTeam();
  print(team.toString());
  team
    ..removeYoungest()
    ..show();

  //print(team.people.toList().map((f)=> print(f.dayOfBirth)));


  /*print('Dash'.firstChar);
  //print(StringUtil.isValidEmail('youss@gmail.com'));
  print('tary@gmail.com'.isValidEmail ? 'email correct' : 'email Incorrect');
  print('first'.concatWithSpace('second'));
  print('premier' & 'c');
  //print(2.0.addTo<double>());
  //int store = 3.0.addTwoAll; error

  var warning = 'Extensions are here!';
  warning.scream(); // prints "EXTENSIONS ARE HERE!"

  // Extension methods ¯\_(ツ)_/¯
  5.times(() => print('hello'));

  print(null.stop('!!!')); // prints null!!!

   */

}