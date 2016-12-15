import 'package:firebase/firebase.dart' as firebase;
import 'user.dart';

class AuthenticatedUser implements User {
  String get displayName => _firebaseUser.displayName;
  firebase.User _firebaseUser;
  AuthenticatedUser(this._firebaseUser);
}
