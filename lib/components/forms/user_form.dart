import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:netflux/models/user_model.dart';

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
                  widget.user.firstname = value!;
                });
              },
              initialValue: widget.user.firstname,
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
                  widget.user.lastname = value!;
                });
              },
              initialValue: widget.user.lastname,
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
                  widget.user.city = value!;
                });
              },
              initialValue: widget.user.city,
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
                  widget.user.country = value!;
                });
              },
              initialValue: widget.user.country,
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
                  widget.user.birthdate = DateFormat('dd/MM/yyyy').format(value!);
                });
              },
              initialValue: convertBirthdate(widget.user.birthdate),
              decoration: const InputDecoration(hintText: 'Birthdate'),
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
                  widget.user.image = value!;
                });
              },
              initialValue: widget.user.image,
              decoration: const InputDecoration(hintText: 'Image'),
            ),
            const SizedBox(
              height: 25,
            ),
            ElevatedButton(
              onPressed: () {
                if (key.currentState!.validate()) {
                  key.currentState!.save();
                  updateUserDatas(widget.user);
                }
              },
              child: const Text('Submit'),
            )
          ],
        ),
      ),
    );
  }
}
