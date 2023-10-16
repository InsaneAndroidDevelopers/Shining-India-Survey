import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shining_india_survey/utils/app_colors.dart';
import 'package:shining_india_survey/utils/back_button.dart';
import 'package:shining_india_survey/utils/custom_button.dart';

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
    final outlineBorder = OutlineInputBorder(
      borderSide: const BorderSide(
        color: AppColors.lightBlack
      ),
      borderRadius: BorderRadius.circular(16)
    );

    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.primary,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 14),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 14),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CustomBackButton(
                      onTap: (){
                        context.pop();
                      },
                    ),
                    SizedBox(width: 16,),
                    Expanded(
                      child: Text(
                        widget.isUpdate
                          ? widget.name
                          : 'Create Surveyor',
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 28,
                            color: AppColors.black,
                            fontWeight: FontWeight.w700
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        ValueListenableBuilder(
                          valueListenable: userNameController,
                          builder: (context, value, child) {
                            return TextFormField(
                              controller: userNameController,
                              style: const TextStyle(
                                  fontSize: 14,
                                  fontFamily: 'Poppins',
                                  color: AppColors.textBlack
                              ),
                              keyboardType: TextInputType.text,
                              cursorColor: AppColors.lightBlack,
                              decoration: InputDecoration(
                                fillColor: Colors.white,
                                filled: true,
                                labelText: 'Name',
                                prefixIcon: const Icon(Icons.person_2_rounded, color: AppColors.textBlack,),
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
                              validator: (name) {
                                if (name == null || name.isEmpty) {
                                  return 'Please enter user name';
                                }
                                return null;
                              },
                            );
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
                            );
                          },
                        ),
                        SizedBox(height: 10,),
                        CustomButton(
                          onTap: (){

                          },
                          text: widget.isUpdate
                              ? 'Update'
                              : 'Create',
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
