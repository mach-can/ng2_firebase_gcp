import 'dart:async';
import 'package:angular2/angular2.dart';
import 'package:angular2/router.dart';
import 'model/service/auth_service.dart';

Injector injector;

void setInjector(Injector _injector) {
  injector = _injector;
}

Future<bool> checkAuthenticated(
    ComponentInstruction _, ComponentInstruction __) async {
  bool isAuthenticated =
      await injector.get(AuthService).checkUserAuthenticated();
  if (!isAuthenticated) injector.get(Router).navigate(['SignIn']);
  return isAuthenticated;
}
