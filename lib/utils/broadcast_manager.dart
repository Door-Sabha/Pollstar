import 'package:rxdart/rxdart.dart';

class BroadcastNotification {
  final String type;
  final Map data;

  BroadcastNotification(this.type, this.data);
}

class BroadcastNotificationBloc {
  BroadcastNotificationBloc._internal();

  static final BroadcastNotificationBloc instance =
      BroadcastNotificationBloc._internal();

  final BehaviorSubject<BroadcastNotification> _notificationsStreamController =
      BehaviorSubject<BroadcastNotification>();

  Stream<BroadcastNotification> get notificationsStream {
    return _notificationsStreamController;
  }

  void newNotification(BroadcastNotification notification) {
    _notificationsStreamController.sink.add(notification);
  }

  void dispose() {
    _notificationsStreamController.close();
  }
}
