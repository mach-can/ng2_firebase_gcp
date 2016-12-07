import 'dart:async';
import 'package:angular2/angular2.dart';
import 'package:firebase3/firebase.dart' as firebase;
import 'package:http/browser_client.dart' as http;
import 'package:client/model/service/firebase_service.dart';
import 'package:client/model/user/user.dart';

@Injectable()
class AuthService {
  final firebase.Auth _auth;
  final StreamController<bool> _onAuthStateChangedController;

  /// Nullable. If null, it means that firebase authentication process has not been completed yet (intermediate state).
  User user;

  /// This getter doesn't care the intermediate state. Use [checkUserAuthenticated()] if that state is possibility.
  bool get isUserAuthenticated => user is AuthenticatedUser;
  Stream<bool> get onAuthStateChanged => _onAuthStateChangedController.stream;

  AuthService(FirebaseService firebaseService)
      : _auth = firebaseService.auth,
        _onAuthStateChangedController = new StreamController<bool>.broadcast() {
    _listenFirebaseOnAuthStateChanged();
  }

  // Assuming only google auth on this example.
  Future signInWithPopup() async {
    var credential =
        await _auth.signInWithPopup(new firebase.GoogleAuthProvider());
    return _runBackendAuthorization(credential);
  }

  // Assuming only google auth on this example.
  Future signInWithRedirect() {
    return _auth.signInWithRedirect(new firebase.GoogleAuthProvider());
  }

  Future handleSignInWithRedirectResult() async {
    var credential = await _auth.getRedirectResult();
    return _runBackendAuthorization(credential);
  }

  Future signOut() async {
    await _auth.signOut();
  }

  /// Check user is authenticated or not.
  Future<bool> checkUserAuthenticated() {
    return new Future.sync(() {
      // This means an onAuthStateChanged event has completed.
      if (user != null) return isUserAuthenticated;
      // Otherwise, new element of the event should come.
      // Listen the event to get only first element,
      // telling whether user is authenticated or not, then cancel.
      return onAuthStateChanged.first;
    });
  }

  void _listenFirebaseOnAuthStateChanged() {
    _auth.onAuthStateChanged.listen((firebase.AuthEvent event) {
      _handleOnAuthStateChanged(event);
      _onAuthStateChangedController.add(isUserAuthenticated);
    });
  }

  void _handleOnAuthStateChanged(firebase.AuthEvent event) {
    var u = event.user;
    user = u != null ? new AuthenticatedUser(u) : new GuestUser();
  }

  Future _runBackendAuthorization(firebase.UserCredential credential) async {
    var idToken = await credential.user.getToken();
    var client = new http.BrowserClient();
    try {
      return await client.post('http://localhost:9920/authorization',
          headers: {'Authorization': idToken});
    } catch (e) {
      print("Error on '_runBackendAuthorization': $e");
    }
  }
}
