import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:netflux/models/user_model.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({Key? key}) : super(key: key);

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final key = GlobalKey<FormState>();
  String 
    email = '', 
    password = '', 
    errorMessage = '';

  UserModel user = UserModel(firstname: '', lastname: '', country: '', city: '', birthdate: '', image: 'https://external-content.duckduckgo.com/iu/?u=http%3A%2F%2Fwww.mycustomer.com%2Fsites%2Fall%2Fthemes%2Fpp%2Fimg%2Fdefault-user.png&f=1&nofb=1');

  void signInToFirebase(String email, String password) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) async {
            storeUserDataToFirestore(value.user!.uid);
            Navigator.of(context).pushReplacementNamed('/');
          });

    } on FirebaseException catch (error) {
      if (error.code == 'weak-password') {
        setState(() {
          errorMessage = 'weak-password';
        });
      } else if (error.code == 'email-already-in-use') {
        setState(() {
          errorMessage = 'email-already-in-use';
        });
      }
    } catch (error) {
      setState(() {
        errorMessage = error.toString();
      });
    }
  }

  void storeUserDataToFirestore(String? uid) async {
    try {
      await FirebaseFirestore
        .instance
        .collection('users')
        .doc(uid)
        .set(user.toMap())
      ;
    } catch (error) {
      setState(() {
        errorMessage = error.toString();
      });
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
            const Text('Register page'),
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
            TextFormField(
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
              onSaved: (String? value) {
                setState(() {
                  user.firstname = value!;
                });
              },
              decoration: const InputDecoration(hintText: 'Firstname'),
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
                  user.lastname = value!;
                });
              },
              decoration: const InputDecoration(hintText: 'Lastname'),
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
                  user.city = value!;
                });
              },
              decoration: const InputDecoration(hintText: 'City'),
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
                  user.country = value!;
                });
              },
              decoration: const InputDecoration(hintText: 'Country'),
            ),
            const SizedBox(
              height: 25,
            ),
            DateTimeField(
              format: DateFormat("yyyy-MM-dd"),
              onShowPicker: (context, currentValue) {
                return showDatePicker(
                    context: context,
                    firstDate: DateTime(1900),
                    initialDate: DateTime(2000),
                    lastDate: DateTime.now()
                );
              },
              validator: (DateTime? value) {
                if (value == null) {
                  return 'Please enter some text';
                }
                return null;
              },
              onSaved: (DateTime? value) {
                setState(() {
                  user.birthdate = DateFormat('dd/MM/yyyy').format(value!);
                });
              },
              decoration: const InputDecoration(hintText: 'Birthdate'),
            ),
            const SizedBox(
              height: 25,
            ),
            ElevatedButton(
              onPressed: () {
                if (key.currentState!.validate()) {
                  key.currentState!.save();
                  signInToFirebase(email, password);
                }
              },
              child: const Text('Submit'),
            ),
            const SizedBox(
              height: 25,
            ),
            if (errorMessage.isNotEmpty) Text(errorMessage),
            TextButton(
              child: const Text('Go to login'),
              onPressed: () { 
                Navigator.of(context).pushNamed('/login');
              },
            )
          ],
        ),
      ),
    );
  }
}
