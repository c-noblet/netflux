import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final key = GlobalKey<FormState>();
  String email = '', password = '', errorMessage = '';

  void logInToFirebase(String email, String password) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password)
          .then(
            (value) => Navigator.of(context).pushReplacementNamed('/'),
          );

    } on FirebaseException catch (error) {
      if (error.code == 'invalid-email') {
        setState(() { errorMessage = 'Invalid email'; });
      } else if (error.code == 'user-disabled') {
        setState(() { errorMessage = 'User disabled'; });
      } else if (error.code == 'user-not-found') {
        setState(() { errorMessage = 'User not found'; });
      } else if (error.code == 'wrong-password') {
        setState(() { errorMessage = 'Wrong password'; });
      }
    } catch (error) {
      setState(() { errorMessage = error.toString(); });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: key,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 20,
          horizontal: 20,
        ),
        child: Column(
          children: <Widget>[
            const Text('Login page'),
            const SizedBox(
              height: 25,
            ),
            TextFormField(
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
              onSaved: (String? value) {
                setState(() {
                  email = value!;
                });
              },
              decoration: const InputDecoration(
                hintText: 'Email',
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            TextFormField(
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
              onSaved: (String? value) {
                setState(() {
                  password = value!;
                });
              },
              decoration: const InputDecoration(hintText: 'Password'),
            ),
            const SizedBox(
              height: 25,
            ),
            ElevatedButton(
              onPressed: () {
                if (key.currentState!.validate()) {
                  key.currentState!.save();
                  logInToFirebase(email, password);
                }
              },
              child: const Text('Submit'),
            ),
            const SizedBox(
              height: 25,
            ),
            if (errorMessage.isNotEmpty) Text(errorMessage),
            TextButton(
              child: const Text('Go to register'),
              onPressed: () { 
                Navigator.of(context).pushNamed('/register');
              },
            )
          ],
        ),
      ),
    );
  }
}
