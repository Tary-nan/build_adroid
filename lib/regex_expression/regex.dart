String myString = "dog   chased     warning tha     imac_18      cat";
String regex = r'\y';
var resul = RegExp(regex, caseSensitive: true).hasMatch(myString);

void main() {

  //print(Allergies.list(12));
  final List<String> result = Anagram().findAnagrams('master', <String>['stream', 'mpigeon', 'maters', 'master', 'stream']);
  print(result);
  String acro = Acronym.abbreviate('Tarpilga-Youssouf          imac_18');
  print(acro);

  /*String acro = Acronym.abbreviate('Tarpilga-Youssouf          imac_18');
  print(acro);

  var res = myString.split(' ')
  print(res);
  String acronym = '';

  for(var i = 0; i< res.length; i++ ){
    if(res[i].isNotEmpty){
      acronym += res[i].substring(0, 1);
    }
  }
  print(acronym.toUpperCase());

   */
}

class Acronym {
  static String abbreviate(final String input) {
    ///
    /// class permettant de mieux (de facon efficace) concatener une string
    ///
    StringBuffer acronymBuilder = StringBuffer();

    ///
    /// r'( )|(-)' => vide ou contenat un tiret
    ///
    RegExp separatorsExp = RegExp(r'( )|(-)');
    List<String> list = input.split(separatorsExp);

    /// [].remove => bool
    /// Tant qu'on a la possibilité de delete la condition sera true
    /// result un tableau sans valeur vide
    ///
    while (list.remove(''));

    for (String phrase in list) {
      ///
      /// delete underscore dans la phrase
      ///
      phrase = phrase.replaceAll('_', '');
      final String acronym = phrase.trim().substring(0, 1).toUpperCase();
      acronymBuilder.write(acronym);
    }
    return acronymBuilder.toString();
  }
}

class Anagram {
  List<String> findAnagrams(String subject, List<String> candidates) {
    Map<String, int> subjectCharsMap = countCharacters(subject);
    //print(subjectCharsMap);

    List<String> matchTracker = List<String>();

    for (String possible in candidates) {
      if (possible.toLowerCase() != subject.toLowerCase()) {
        Map<String, int> possibleCharMap = countCharacters(possible);
        //print(possibleCharMap);
        if (mapsMatch(subjectCharsMap, possibleCharMap)) {
          matchTracker.add(possible);
        }
        possibleCharMap.clear();
      }
    }

    return matchTracker;
  }

  Map<String, int> countCharacters(String word) {
    //print(word);
    Map<String, int> charTracker = Map<String, int>();

    for (int counter = 0; counter < word.length; counter++) {
      var key = word[counter].toLowerCase();
      charTracker[key] =
          charTracker.containsKey(key) ? charTracker[key] + 1 : 1;
    }
    //print(charTracker);

    return charTracker;
  }
}

bool mapsMatch(Map<String, int> subjectCharsMap, Map<String, int> possibleCharMap) {
  List<bool> trackingMatches = List<bool>();

  for (String key in possibleCharMap.keys) {
    if (subjectCharsMap.containsKey(key)) {
      trackingMatches.add(subjectCharsMap[key] == possibleCharMap[key]);
    } else {
      return false;
    }
  }

  for (bool result in trackingMatches) {
    if (result == false) {
      return false;
    }
  }
  return trackingMatches.length == subjectCharsMap.length;
}

class Allergies {
  static final substances = ['eggs', 'peanuts', 'shellfish', 'strawberries', 'tomatoes', 'chocolate', 'pollen', 'cats'];

  static bool allergicTo(String item, int score) {
    int index = substances.indexOf(item);
    print('///////////// INDEX ///////////////');
    print(index);
    print('///////////// SCORE >> index (score : $score \>\> index : $index = ${score >> index}) ///////////////');
    print(score >> index);
    print('///////////// SCORE >> index & 1 ///////////////');
    print(score >> index & 1);
    print('///////////// SCORE >> index & 1 ///////////////');
    print((score >> index & 1) == 1);


    return ((score >> index) & 1) == 1;
  }

  static List<String> list(int score) => substances.where((t) => allergicTo(t, score)).toList();
}

