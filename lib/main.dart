import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:notetakingapp/Provider/PinNoteProvider.dart';

import 'package:notetakingapp/Provider/timeProvider.dart';
import 'package:notetakingapp/Screens/HomeScreen.dart';
import 'package:notetakingapp/Screens/LoginScreen.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: "AIzaSyDWZ6V_r7gjk7L6XIsEXlQ0KQlCuvtgius",
            authDomain: "notes-26431.firebaseapp.com",
            projectId: "notes-26431",
            storageBucket: "notes-26431.appspot.com",
            messagingSenderId: "309682316182",
            appId: "1:309682316182:web:6d1a52705e6b1335e0f3b7"));
  } else {
    await Firebase.initializeApp();
  }
  runApp(const MyApp());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => TimeProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => PinnedNoteProvider(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.active) {
              if (snapshot.hasData) {
                return HomePage();
              } else if (snapshot.hasError) {
                return Center(
                  child: Text("${snapshot.error}"),
                );
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                    child: CircularProgressIndicator(
                  color: Colors.white,
                ));
              }
            }

            return const LoginScreen();
          },
        ),
      ),
    );
  }
}
