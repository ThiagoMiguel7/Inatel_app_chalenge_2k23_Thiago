import 'package:inatel_app_challenge/data.dart';
import 'package:inatel_app_challenge/socket/socketServiceAbstraction.dart';
import 'package:rxdart/rxdart.dart';

abstract class DataBloc {
  BehaviorSubject<List<Data>> get listDataSubject;
  void startConnection();
  void dispose();
}

class DataBlocImpl implements DataBloc {
  final SocketService _socketService;
  final BehaviorSubject<List<Data>> _listDataSubject =
      BehaviorSubject.seeded([]);

  @override
  BehaviorSubject<List<Data>> get listDataSubject => _listDataSubject;

  DataBlocImpl(this._socketService);

  @override
  void startConnection() {
    _socketService.listenData((listData) {
      print("$listData");
      var sink = _listDataSubject.sink;
      sink.add(listData);
    });
  }

  @override
  void dispose() {
    _listDataSubject.close();
  }
}
