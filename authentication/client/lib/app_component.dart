// Copyright (c) 2016, ntaoo. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.
import 'dart:async';
import 'package:angular2/angular2.dart';
import 'package:angular2/router.dart';
import 'check_authenticated.dart';
import 'home_component.dart';
import 'some_component.dart';
import 'sign_in/sign_in_component.dart';
import 'model/service/auth_service.dart';
import 'model/service/firebase_service.dart';

@Component(
    selector: 'my-app',
    templateUrl: 'app_component.html',
    providers: const [
      ROUTER_PROVIDERS,
      AuthService,
      FirebaseService
    ],
    directives: const [
      ROUTER_DIRECTIVES,
    ])
@RouteConfig(const [
  const Route(
      path: '/', name: 'Home', component: HomeComponent, useAsDefault: true),
  const Route(path: '/some', name: 'Some', component: SomeComponent),
  const Route(path: '/sign-in', name: 'SignIn', component: SignInComponent),
])
class AppComponent {
  final Router _router;
  final AuthService _authService;
  AppComponent(this._router, this._authService, Injector _injector) {
    setInjector(_injector);
    _authService.onAuthStateChanged.listen((bool authenticated) {
      if (!authenticated) _handleUnauthenticated();
    });
  }

  Future<Null> signOut() async {
    await _authService.signOut();
  }

  bool get isSignedIn => _authService.isUserAuthenticated;

  void _handleUnauthenticated() {
    _router.navigate(['SignIn']);
  }
}
