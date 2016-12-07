import 'package:angular2/angular2.dart';
import 'package:firebase3/firebase.dart' as firebase;

@Injectable()
class FirebaseService {
  final firebase.Auth auth;

  factory FirebaseService() {
    firebase.initializeApp(
        apiKey: " AIzaSyCIQNJV-TFRl9BK_9hVuS8lkgMxD69_Z0A",
        authDomain: "ng2-firebase-gcp.firebaseapp.com",
        databaseURL: "https://ng2-firebase-gcp.firebaseio.com",
        storageBucket: "ng2-firebase-gcp.appspot.com");
    return new FirebaseService._(firebase.auth());
  }
  FirebaseService._(this.auth);
}
