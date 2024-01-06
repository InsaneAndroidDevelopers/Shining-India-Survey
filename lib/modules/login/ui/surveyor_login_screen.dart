import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shining_india_survey/modules/login/core/bloc/login_bloc.dart';
import 'package:shining_india_survey/modules/login/ui/admin_login_screen.dart';
import 'package:shining_india_survey/routes/routes.dart';
import 'package:shining_india_survey/global/values/app_colors.dart';
import 'package:shining_india_survey/global/widgets/back_button.dart';
import 'package:shining_india_survey/global/widgets/custom_button.dart';
import 'package:shining_india_survey/global/widgets/custom_flushbar.dart';
import 'package:shining_india_survey/global/widgets/loader.dart';

class SurveyorLoginScreen extends StatefulWidget {
  const SurveyorLoginScreen({super.key});

  @override
  State<SurveyorLoginScreen> createState() => _SurveyorLoginScreenState();
}

class _SurveyorLoginScreenState extends State<SurveyorLoginScreen> {

  final _formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final tokenController = TextEditingController();

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
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
    tokenController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final outlineBorder = OutlineInputBorder(
        borderSide: const BorderSide(
            color: AppColors.lightBlack
        ),
        borderRadius: BorderRadius.circular(16)
    );

    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.primary,
        body: BlocConsumer<LoginBloc, LoginState>(
          listener: (context, state) {
           if (state is ErrorState) {
              CustomFlushBar(
                context: context,
                message: state.message,
                backgroundColor: Colors.red,
                icon: Icon(Icons.cancel_outlined, color: Colors.white)
              ).show();
            } else if (state is SurveyorLoginSuccessState) {
              context.go(RouteNames.surveyorHomeScreen);
            }
          },
          builder: (context, state) {
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 14, left: 14),
                    child: CustomBackButton(
                      onTap: (){
                        context.pop();
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 14),
                    child: Column(
                      children: [
                        Hero(
                            tag: 'assets/user.png',
                            child: Image.asset('assets/user.png', height: 220,)
                        ),
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Surveyor',
                            style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 26,
                                color: AppColors.black,
                                fontWeight: FontWeight.w700
                            ),
                          ),
                        ),
                        const SizedBox(height: 4,),
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Login to continue using the app',
                            style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 16,
                                color: AppColors.lightBlack,
                                fontWeight: FontWeight.w700
                            ),
                          ),
                        ),
                        const SizedBox(height: 24,),
                        Form(
                          key: _formKey,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              TextFormField(
                                  controller: emailController,
                                  style: const TextStyle(
                                      fontFamily: 'Poppins',
                                      color: AppColors.textBlack
                                  ),
                                  keyboardType: TextInputType.emailAddress,
                                  cursorColor: AppColors.lightBlack,
                                  decoration: InputDecoration(
                                    fillColor: Colors.white,
                                    filled: true,
                                    labelText: 'E-mail',
                                    prefixIcon: const Icon(Icons.email_rounded, color: AppColors.textBlack,),
                                    labelStyle: const TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 14,
                                        color: AppColors.lightBlack
                                    ),
                                    border: outlineBorder,
                                    disabledBorder: outlineBorder,
                                    errorBorder: outlineBorder,
                                    focusedBorder: outlineBorder,
                                    focusedErrorBorder: outlineBorder,
                                    enabledBorder: outlineBorder,
                                  ),
                                  autovalidateMode: AutovalidateMode.onUserInteraction,
                                  validator: _validateEmail
                              ),
                              const SizedBox(height: 10,),
                              TextFormField(
                                  controller: passwordController,
                                  keyboardType: TextInputType.text,
                                  style: const TextStyle(
                                      fontFamily: 'Poppins',
                                      color: AppColors.textBlack
                                  ),
                                  cursorColor: AppColors.lightBlack,
                                  obscureText: !isPasswordVisible,
                                  decoration: InputDecoration(
                                    fillColor: Colors.white,
                                    filled: true,
                                    labelText: 'Password',
                                    labelStyle: const TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 14,
                                        color: AppColors.lightBlack
                                    ),
                                    prefixIcon: const Icon(Icons.key_rounded, color: AppColors.textBlack,),
                                    suffixIcon: IconButton(
                                      icon: Icon(isPasswordVisible
                                          ? Icons.visibility
                                          : Icons.visibility_off, color: AppColors.textBlack,
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          isPasswordVisible =
                                          !isPasswordVisible;
                                        });
                                      },
                                    ),
                                    border: outlineBorder,
                                    disabledBorder: outlineBorder,
                                    errorBorder: outlineBorder,
                                    focusedBorder: outlineBorder,
                                    focusedErrorBorder: outlineBorder,
                                    enabledBorder: outlineBorder,
                                  ),
                                  autovalidateMode: AutovalidateMode.onUserInteraction,
                                  validator: _validatePassword
                              ),
                              const SizedBox(height: 20,),
                              CustomButton(
                                  onTap: (){
                                    if(_formKey.currentState!.validate()){
                                      context.read<LoginBloc>().add(SurveyorLoginEvent(
                                          email: emailController.text.trim(),
                                          password: passwordController.text.trim()
                                      ));
                                    }
                                  },
                                  child: state is LoadingState
                                    ? const Loader()
                                    : const Text(
                                    'Login',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontFamily: 'Poppins',
                                      color: AppColors.primary,
                                      fontWeight: FontWeight.w600
                                    ),
                                  )
                              ),
                              const SizedBox(height: 10,),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

