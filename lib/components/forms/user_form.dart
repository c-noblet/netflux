import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:netflux/models/user_model.dart';
import 'package:fluttertoast/fluttertoast.dart';

class UserForm extends StatefulWidget {
  const UserForm({Key? key, required this.user}) : super(key: key);

  final UserModel user;

  @override
  State<UserForm> createState() => _UserFormState();
}

class _UserFormState extends State<UserForm> {
  final key = GlobalKey<FormState>();
  String 
    email = '', 
    password = '', 
    errorMessage = '';


  void updateUserDatas(UserModel user) async {
    try {
      await FirebaseFirestore
        .instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update(widget.user.toMap())
      ;

      Fluttertoast.showToast(
        msg: 'Profile updated !',
        gravity: ToastGravity.TOP
      );

      Navigator.pop(context);
    } catch (error) {
      setState(() {
        errorMessage = error.toString();
      });
    }
  }

  DateTime convertBirthdate(String birthdate) {
    var dateFormat = DateFormat('dd/MM/yyyy');

    return dateFormat.parse(birthdate);
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
              
              Padding(
                padding: const EdgeInsets.only(top: 50),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Edit',
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
                      ' Profile',
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
                      widget.user.firstname = value!;
                    });
                  },
                  initialValue: widget.user.firstname,
                  style: const TextStyle(color: Colors.white, fontSize: 14.5),
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
                      widget.user.lastname = value!;
                    });
                  },
                  initialValue: widget.user.lastname,
                  style: const TextStyle(color: Colors.white, fontSize: 14.5),
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
                      widget.user.country = value!;
                    });
                  },
                  initialValue: widget.user.country,
                  style: const TextStyle(color: Colors.white, fontSize: 14.5),
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
                      widget.user.city = value!;
                    });
                  },
                  initialValue: widget.user.city,
                  style: const TextStyle(color: Colors.white, fontSize: 14.5),
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
                      widget.user.birthdate = DateFormat('dd/MM/yyyy').format(value!);
                    });
                  },
                  initialValue: convertBirthdate(widget.user.birthdate),
                  style: const TextStyle(color: Colors.white, fontSize: 14.5),
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
                      widget.user.image = value!;
                    });
                  },
                  initialValue: widget.user.image,
                  style: const TextStyle(color: Colors.white, fontSize: 14.5),
                  decoration: InputDecoration(
                      prefixIconConstraints:  const BoxConstraints(minWidth: 45),
                      prefixIcon: const Icon(
                        Icons.image,
                        color: Colors.white70,
                        size: 22,
                      ),
                      border: InputBorder.none,
                      hintText: 'Image',
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
                    updateUserDatas(widget.user);
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
                  child: Text('Edit',
                    style: TextStyle(
                      color: Theme.of(context).brightness == Brightness.light ? Colors.white.withOpacity(.8) : Colors.white,
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
