import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shining_india_survey/modules/login/core/bloc/login_bloc.dart';
import 'package:shining_india_survey/routes/routes.dart';

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
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: BlocConsumer<LoginBloc, LoginState>(
          listener: (context, state) {
            if (state is ErrorState) {
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                      content: Text('Error occurred')
                  )
              );
            } else if (state is AdminLoginSuccessState) {
              context.go(RouteNames.adminHomeScreen);
            }
          },
          builder: (context, state) {
            if (state is LoadingState) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return Center(
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
                                      isPasswordVisible =
                                      !isPasswordVisible;
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
                          onPressed: () {
                            // if(_formKey.currentState!.validate()){
                            //   debugPrint(emailController.text);
                            //   debugPrint(passwordController.text);
                            // }
                            context.read<LoginBloc>().add(
                                AdminLoginEvent());
                          },
                          child: Text(
                            'Login',
                            textAlign: TextAlign.center,
                          ),
                        ),
                        SizedBox(height: 10,),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}