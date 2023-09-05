import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

class AdminCreateUpdateSurveyorScreen extends StatefulWidget {
  final bool isUpdate;
  final String name;
  const AdminCreateUpdateSurveyorScreen({super.key, required this.isUpdate, required this.name});

  @override
  State<AdminCreateUpdateSurveyorScreen> createState() => _AdminCreateUpdateSurveyorScreenState();
}

class _AdminCreateUpdateSurveyorScreenState extends State<AdminCreateUpdateSurveyorScreen> {

  final _formKey = GlobalKey<FormState>();

  final userNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool isPasswordVisible = false;

  String? _validateEmail(String? email) {
    if (email != null) {
      if (email.isNotEmpty && !EmailValidator.validate(email)) {
        return 'Please enter correct email address';
      } else if (email.isEmpty) {
        return 'Please enter email address';
      }
    }
    return null;
  }

  String? _validatePassword(String? password) {
    if (password != null) {
      if (password.isNotEmpty && password.length < 8) {
        return 'Password must be at least 8 characters';
      } else if (password.isEmpty) {
        return 'Please enter password';
      }
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.isUpdate
            ? widget.name
            : 'Create Surveyor'
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 14),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  ValueListenableBuilder(
                    valueListenable: userNameController,
                    builder: (context, value, child) {
                      return TextFormField(
                        controller: userNameController,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'User name',
                            prefixIcon: Icon(Icons.person)),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (name) {
                          if (name == null || name.isEmpty) {
                            return 'Please enter user name';
                          }
                          return null;
                        },
                      );
                    },
                  ),
                  SizedBox(height: 10,),
                  ValueListenableBuilder(
                    valueListenable: emailController,
                    builder: (context, value, child) {
                      return TextFormField(
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'E-mail',
                              prefixIcon: Icon(Icons.email_rounded)
                          ),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: _validateEmail
                      );
                    },
                  ),
                  SizedBox(height: 10,),
                  ValueListenableBuilder(
                    valueListenable: passwordController,
                    builder: (context, value, child) {
                      return TextFormField(
                          controller: passwordController,
                          keyboardType: TextInputType.text,
                          obscureText: !isPasswordVisible,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Password',
                              prefixIcon: Icon(Icons.key_rounded),
                              suffixIcon: IconButton(
                                icon: Icon(isPasswordVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off),
                                onPressed: () {
                                  setState(() {
                                    isPasswordVisible =
                                    !isPasswordVisible;
                                  });
                                },
                              )
                          ),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: _validatePassword
                      );
                    },
                  ),
                  SizedBox(height: 10,),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        minimumSize: Size.fromHeight(50)
                    ),
                    onPressed: () {
                    },
                    child: Text(
                      widget.isUpdate
                        ? 'Update'
                        : 'Create',
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
