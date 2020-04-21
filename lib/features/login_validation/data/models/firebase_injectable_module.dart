import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';

@registerModule
abstract class FirebaseInjectableModule {
  @lazySingleton
  FirebaseAuth get firebaseAuth => FirebaseAuth.instance;
}
