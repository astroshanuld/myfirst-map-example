part of 'repository.dart';

class AuthRepository {
  static void checkAuth(
      {required BuildContext context, ValueSetter? setUserUid}) {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        Navigator.push(context, LoginScreen.route());
      } else {
        String userUid = user.uid;
        setUserUid != null ? setUserUid(userUid) : null;
        print('Logged in!');
      }
    });
  }

  static Future<UserCredential> signIn(
      {required String email, required String password}) async {
    UserCredential response = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    return response;
  }
}
