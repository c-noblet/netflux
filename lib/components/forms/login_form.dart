import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

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
            (value) => {
              showToastMessage('Logged with success !'),
              Navigator.of(context).pushReplacementNamed('/')
            },
          );

    } on FirebaseException catch (error) {
      if (error.code == 'invalid-email') {
        showToastMessage('Invalid email');
      } else if (error.code == 'user-disabled') {
        showToastMessage('User disabled');
      } else if (error.code == 'user-not-found') {
        showToastMessage('User not found');
      } else if (error.code == 'wrong-password') {
        showToastMessage('Wrong password');
      }
    } catch (error) {
      showToastMessage(error.toString());
    }
  }

  void showToastMessage(String message) {
    Fluttertoast.showToast(
      msg: message,
      gravity: ToastGravity.TOP
    );
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: key,
      child: Container(
        height: double.infinity,
        width: double.infinity,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Theme.of(context).brightness == Brightness.light ? Colors.blue.shade300 : Colors.grey, 
              Theme.of(context).brightness == Brightness.light ? Colors.blue.shade800 : Colors.grey.shade900, 
            ]
          )
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Let\'s',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      shadows: [
                        Shadow(
                          color: Colors.black45,
                          offset: Offset(1, 1),
                          blurRadius: 5
                        )
                      ]
                    ),
                  ),
                  Text(
                    ' Login',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).brightness == Brightness.light ? Colors.blue.shade300 : Colors.grey.shade500,
                      shadows: const [
                        Shadow(
                          color: Colors.black45,
                          offset: Offset(1, 1),
                          blurRadius: 5
                        )
                      ]
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 50,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30).copyWith(bottom: 10),
                child: TextFormField(
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
                  style: const TextStyle(color: Colors.white, fontSize: 14.5),
                  decoration: InputDecoration(
                      prefixIconConstraints: const BoxConstraints(minWidth: 45),
                      prefixIcon: const Icon(
                        Icons.email,
                        color: Colors.white70,
                        size: 22,
                      ),
                      border: InputBorder.none,
                      hintText: 'Email',
                      hintStyle: const TextStyle(color: Colors.white60, fontSize: 14.5),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(100),
                        borderSide: const BorderSide(color: Colors.white38)
                      ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(100),
                      borderSide:  const BorderSide(color: Colors.white70)
                    )
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30).copyWith(bottom: 10),
                child: TextFormField(
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
                  style: const TextStyle(color: Colors.white, fontSize: 14.5),
                  obscureText: true,
                  decoration: InputDecoration(
                      prefixIconConstraints:  const BoxConstraints(minWidth: 45),
                      prefixIcon: const Icon(
                        Icons.lock,
                        color: Colors.white70,
                        size: 22,
                      ),
                      border: InputBorder.none,
                      hintText: 'Password',
                      hintStyle: const TextStyle(color: Colors.white60, fontSize: 14.5),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(100),
                        borderSide: const BorderSide(color: Colors.white38)
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(100),
                        borderSide: const BorderSide(color: Colors.white70))
                      ),
                ),
              ),
              const SizedBox(
                height: 40,
              ),

              GestureDetector(
                onTap: () {
                  if (key.currentState!.validate()) {
                    key.currentState!.save();
                    logInToFirebase(email, password);
                  }
                },
                child: Container(
                  height: 53,
                  width: double.infinity,
                  margin: const EdgeInsets.symmetric(horizontal: 30),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 4,
                        color: Colors.black12.withOpacity(.2),
                        offset: const Offset(2, 2)
                      )
                    ],
                    borderRadius: BorderRadius.circular(100),
                    gradient: LinearGradient(colors: [
                      Theme.of(context).brightness == Brightness.light ? Colors.blue.shade200 : Colors.grey.shade300,
                      Theme.of(context).brightness == Brightness.light ? Colors.blue.shade900 : Colors.black,
                    ])
                  ),
                  child: Text('Login',
                    style: TextStyle(
                      color: Colors.white.withOpacity(.8),
                      fontSize: 15,
                      fontWeight: FontWeight.bold
                    )
                  ),
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              const Text(
                'No account yet ?',
                style: TextStyle(color: Colors.white70, fontSize: 13)
              ),
              const SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamed('/register');
                },
                child: Container(
                  height: 53,
                  width: double.infinity,
                  margin: const EdgeInsets.symmetric(horizontal: 30),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white60),
                    borderRadius: BorderRadius.circular(100),                
                  ),                
                  child: Text('Register',                
                    style: TextStyle(                
                      color: Colors.white.withOpacity(.8),                
                      fontSize: 15,                
                      fontWeight: FontWeight.bold
                    )
                  ),                
                ),
              ),
              const SizedBox(
                height: 20,
              )
            ],
          ),
        ),
      )
    );
  }
}
