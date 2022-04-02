import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:netflux/routes/routes.dart';
import 'package:netflux/services/theme_builder.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  final _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
      builder: ((context, snapshot) {
        if (snapshot.hasError) {
          return const MaterialApp(
            home: Scaffold(
              body: SafeArea(
                child: Center(
                  child: Text('Error'),
                ),
              ),
            ),
          );
        }

        if (snapshot.connectionState == ConnectionState.done) {
          return ThemeBuilder(
            defaultBrightness: Brightness.light,
            builder: (context, _brightness) {
              return MaterialApp(
                title: 'Flutter',
                theme: ThemeData(primarySwatch: Colors.blue, brightness: _brightness),
                debugShowCheckedModeBanner: false,
                routes: routes,
                initialRoute: FirebaseAuth.instance.currentUser != null ? '/' : '/login',
              );
            },
          );
        }

        return Container();
      }),
    );
  }
}
