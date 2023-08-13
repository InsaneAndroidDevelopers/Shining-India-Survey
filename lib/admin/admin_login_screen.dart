import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:shining_india_survey/surveyor/surveyor_login_screen.dart';

class AdminLoginScreen extends StatefulWidget {
  const AdminLoginScreen({super.key});

  @override
  State<AdminLoginScreen> createState() => _AdminLoginScreenState();
}

class _AdminLoginScreenState extends State<AdminLoginScreen> {

  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool isPasswordVisible = false;

  String? _validateEmail(String? email){
    if(email != null) {
      if(email.isNotEmpty && !EmailValidator.validate(email)){
        return 'Please enter correct email address';
      } else if(email.isEmpty){
        return 'Please enter email address';
      }
    }
    return null;
  }

  String? _validatePassword(String? password){
    if(password != null){
      if(password.isNotEmpty && password.length < 8){
        return 'Password must be at least 8 characters';
      } else if(password.isEmpty){
        return 'Please enter password';
      }
    }
    return null;
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextFormField(
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'you@example.com',
                        labelText: 'E-mail',
                        prefixIcon: Icon(Icons.email_rounded)
                      ),
                      validator: _validateEmail
                    ),
                    SizedBox(height: 10,),
                    TextFormField(
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
                                  isPasswordVisible = !isPasswordVisible;
                                });
                              },
                            )
                        ),
                        validator: _validatePassword
                    ),
                    SizedBox(height: 10,),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          minimumSize: Size.fromHeight(50)
                      ),
                      onPressed: (){
                        if(_formKey.currentState!.validate()){
                          debugPrint(emailController.text);
                          debugPrint(passwordController.text);
                        }
                      },
                      child: Text(
                        'Login',
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(height: 10,),
                    GestureDetector(
                      onTap: (){
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SurveyorLoginScreen()));
                      },
                      child: Text(
                        'Sign In as surveyor',
                        style: TextStyle(
                          color: Colors.deepPurple,
                          fontWeight: FontWeight.bold,
                          fontSize: 14
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
