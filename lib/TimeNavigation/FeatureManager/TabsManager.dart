import 'package:rxdart/rxdart.dart';
import 'package:sprinkle/Manager.dart';

class TabsManager implements Manager {

  BehaviorSubject<int> _subject = BehaviorSubject.seeded(0);
  Stream<int> get curent$ => _subject.stream;

  void handlerSelectTabs(int selectPageIndex){
    _subject.sink.add(selectPageIndex);
  }


  @override
  void dispose() {
    _subject.close();
  }
}