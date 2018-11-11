import 'package:cv/src/blocs/bloc_provider.dart';
import 'package:rxdart/rxdart.dart';

enum TabType {
  HOME_TAB,
  ACCOUNT_TAB,
}

class MainBloc extends BlocBase {
  MainBloc() : super() {
    _tabController.add(TabType.HOME_TAB);
  }

  // Reactive variables
  final _tabController = BehaviorSubject<TabType>();

  // Streams
  Observable<TabType> get tabStream => _tabController.stream;

  // Sinks
  Sink<TabType> get tab => _tabController.sink;

  /* Functions */

  // Human function
  Function(TabType) get changeTab => tab.add;

  @override
  void dispose() {
    _tabController.close();
  }
}
