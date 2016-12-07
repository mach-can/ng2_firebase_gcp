import 'dart:html';
import 'dart:async';
import 'package:angular2/angular2.dart';
import 'package:angular2/router.dart';
import 'package:client/model/service/auth_service.dart';

@Component(selector: 'sign-in', templateUrl: 'sign_in.html')
class SignInComponent implements OnInit {
  final AuthService _authService;
  final Router _router;
  String _willRedirectKey = 'willRedirectFromFirebase';
  bool _redirectedFromFirebase() =>
      window.sessionStorage.containsKey(_willRedirectKey);
  bool get loading => _redirectedFromFirebase();

  SignInComponent(this._authService, this._router);

  Future ngOnInit() {
    return new Future.sync(() async {
      if (_redirectedFromFirebase()) {
        await _authService.handleSignInWithRedirectResult();
        window.sessionStorage.remove(_willRedirectKey);
        if (await _authService.checkUserAuthenticated()) {
          _router.navigate(['Some']);
        }
      }
    });
  }

  Future<Null> signInWithPopup() async {
    await _authService.signInWithPopup();
    if (await _authService.checkUserAuthenticated()) _router.navigate(['Some']);
  }

  Future<Null> signInWithRedirect() {
    window.sessionStorage[_willRedirectKey] = 'true';
    return _authService.signInWithRedirect();
  }
}
