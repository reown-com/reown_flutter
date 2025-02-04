enum WebsocketMethod {
  account,
  logs,
  program,
  signature,
  slot,
  ;

  String get subscribe => '${name}Subscribe';

  String get unsubscribe => '${name}Unsubscribe';
}
