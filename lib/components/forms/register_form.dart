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
      child: Container(
        height: double.infinity,
        width: double.infinity,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue.shade300, Colors.blue.shade800]
          )
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              
              Padding(
                padding: const EdgeInsets.only(top: 50),
                child: Row(
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
                      ' Register',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue.shade300,
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
              ),
              
              const SizedBox(
                height: 50,
              ),
              // Email
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
              //  Password
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
              // Firstname
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
                      user.firstname = value!;
                    });
                  },
                  style: const TextStyle(color: Colors.white, fontSize: 14.5),
                  obscureText: true,
                  decoration: InputDecoration(
                      prefixIconConstraints:  const BoxConstraints(minWidth: 45),
                      prefixIcon: const Icon(
                        Icons.account_circle,
                        color: Colors.white70,
                        size: 22,
                      ),
                      border: InputBorder.none,
                      hintText: 'Firstname',
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
              // Lastname
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
                      user.lastname = value!;
                    });
                  },
                  style: const TextStyle(color: Colors.white, fontSize: 14.5),
                  obscureText: true,
                  decoration: InputDecoration(
                      prefixIconConstraints:  const BoxConstraints(minWidth: 45),
                      prefixIcon: const Icon(
                        Icons.account_circle,
                        color: Colors.white70,
                        size: 22,
                      ),
                      border: InputBorder.none,
                      hintText: 'Lastname',
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
              // Country
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
                      user.country = value!;
                    });
                  },
                  style: const TextStyle(color: Colors.white, fontSize: 14.5),
                  obscureText: true,
                  decoration: InputDecoration(
                      prefixIconConstraints:  const BoxConstraints(minWidth: 45),
                      prefixIcon: const Icon(
                        Icons.pin_drop,
                        color: Colors.white70,
                        size: 22,
                      ),
                      border: InputBorder.none,
                      hintText: 'Country',
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
              // City
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
                      user.city = value!;
                    });
                  },
                  style: const TextStyle(color: Colors.white, fontSize: 14.5),
                  obscureText: true,
                  decoration: InputDecoration(
                      prefixIconConstraints:  const BoxConstraints(minWidth: 45),
                      prefixIcon: const Icon(
                        Icons.domain,
                        color: Colors.white70,
                        size: 22,
                      ),
                      border: InputBorder.none,
                      hintText: 'City',
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
              // Birthdate
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30).copyWith(bottom: 10),
                child: DateTimeField(
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
                  style: const TextStyle(color: Colors.white, fontSize: 14.5),
                  obscureText: true,
                  decoration: InputDecoration(
                      prefixIconConstraints:  const BoxConstraints(minWidth: 45),
                      prefixIcon: const Icon(
                        Icons.event,
                        color: Colors.white70,
                        size: 22,
                      ),
                      border: InputBorder.none,
                      hintText: 'Birthdate',
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
                    signInToFirebase(email, password);
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
                      Colors.blue.shade200,
                      Colors.blue.shade900
                    ])
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
                height: 50,
              ),
              
              const Text(
                'Already have account ?',
                style: TextStyle(color: Colors.white70, fontSize: 13)
              ),
              
              const SizedBox(
                height: 20,
              ),
              
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamed('/login');
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
                height: 20,
              )
            ],
          ),
        ),
      )
    );
  }
}
