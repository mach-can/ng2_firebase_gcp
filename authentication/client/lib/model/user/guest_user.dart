import 'user.dart';

class GuestUser implements User {
  String get displayName => 'Guest';
  GuestUser();
}
