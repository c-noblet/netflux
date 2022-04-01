import 'package:flutter/material.dart';
import 'package:netflux/components/forms/register_form.dart';


class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: RegisterForm(),
      ),
    );
  }
}