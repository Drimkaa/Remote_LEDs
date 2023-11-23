import 'package:flutter/material.dart';

enum ConnectStatus {
  connected,
  error,
  progress,
  empty,
}

class ConnectPageModel with ChangeNotifier {
  ConnectStatus _status = ConnectStatus.empty;
  ConnectStatus get status => _status;
  set status(ConnectStatus status) {
    if(_status == status){return;}
    _status = status;
    notifyListeners();}
  String get textStatus {
    switch (_status){
      case ConnectStatus.connected:
        return"Подключение выполнено";
      case ConnectStatus.error:
        return"Подключение не удалось, попробуйте еще раз";
      case ConnectStatus.progress:
        return"Подключение выполняется";
      case ConnectStatus.empty:
        return"Подключиться к ленте";
    }
  }
}