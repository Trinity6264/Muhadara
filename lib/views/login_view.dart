import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:muhadara/shared/collor_pallet.dart';
import 'package:muhadara/shared/input_dec.dart';
import 'package:muhadara/view_models/authentication_view_model.dart';
import 'package:muhadara/views/login_view.form.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';

@FormView(fields: [
  FormTextField(name: 'email'),
  FormTextField(name: 'password', isPassword: true),
])
class LoginView extends StatelessWidget with $LoginView {
  LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AuthenticationViewModel>.reactive(
      builder: (context, model, child) {
        return Scaffold(
          backgroundColor: primaryColor,
          body: Center(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Login',
                    style: TextStyle(
                      color: secColor,
                      fontWeight: FontWeight.w700,
                      fontSize: 40,
                    ),
                  ),
                  const SizedBox(height: 40),
                  TextField(
                    decoration: inputDec.copyWith(
                      hintText: 'Email',
                      prefixIcon: const Icon(Icons.email),
                    ),
                    controller: emailController,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 30),
                  TextField(
                    decoration: inputDec.copyWith(
                      hintText: 'Password',
                      prefixIcon: const Icon(Icons.lock),
                    ),
                    controller: passwordController,
                    textInputAction: TextInputAction.done,
                    keyboardType: TextInputType.visiblePassword,
                  ),
                  const SizedBox(height: 30),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: secColor,
                      ),
                      onPressed: () {},
                      child: const Text(
                        'Login',
                        style: TextStyle(
                          color: primaryColor,
                          fontSize: 16.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  RichText(
                    text: TextSpan(children: [
                      const TextSpan(
                        text: 'Don\'t Have An Account?   ',
                      ),
                      TextSpan(
                        text: 'Sign Up',
                        style: const TextStyle(
                          color: secColor,
                          fontSize: 18.0,
                          fontWeight: FontWeight.w600,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () => model.toRegister(),
                      ),
                    ]),
                  ),
                ],
              ),
            ),
          ),
        );
      },
      viewModelBuilder: () => AuthenticationViewModel(),
    );
  }
}