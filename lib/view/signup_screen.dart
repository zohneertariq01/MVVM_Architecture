import 'package:clear_view_model/res/colors.dart';
import 'package:clear_view_model/utils/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../res/components/round_button.dart';
import '../utils/utils.dart';
import '../view_model/auth_view_model.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  FocusNode emailFocus = FocusNode();
  FocusNode passwordFocus = FocusNode();
  ValueNotifier<bool> obscurePassword = ValueNotifier<bool>(true);
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
    emailFocus.dispose();
    passwordFocus.dispose();
    obscurePassword.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AuthViewModel>(context);
    final height = MediaQuery.of(context).size.height * 1;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Text('Sign Up Page'),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            TextFormField(
              focusNode: emailFocus,
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                hintText: 'Email',
                prefixIcon: Icon(Icons.email),
                label: Text('Email'),
              ),
              onFieldSubmitted: (value) {
                Utils.changeNotifierField(context, emailFocus, passwordFocus);
              },
            ),
            SizedBox(height: height * .01),
            ValueListenableBuilder(
              valueListenable: obscurePassword,
              builder: (context, value, child) {
                return TextFormField(
                  focusNode: passwordFocus,
                  obscureText: obscurePassword.value,
                  controller: passwordController,
                  obscuringCharacter: "*",
                  decoration: InputDecoration(
                    hintText: 'Password',
                    prefixIcon: Icon(
                      obscurePassword.value
                          ? Icons.lock
                          : Icons.lock_open_outlined,
                    ),
                    label: Text('Password'),
                    suffixIcon: InkWell(
                      onTap: () {
                        obscurePassword.value = !obscurePassword.value;
                      },
                      child: Icon(
                        obscurePassword.value
                            ? Icons.visibility_off
                            : Icons.visibility,
                      ),
                    ),
                  ),
                );
              },
            ),
            SizedBox(height: height * .085),
            RoundButton(
              title: 'Sign Up',
              colors: AppColors.orangeColor,
              loading: provider.signupLoading,
              onPress: () {
                if (emailController.text.isEmpty) {
                  Utils.toastMessage('Please! enter email');
                } else if (passwordController.text.isEmpty) {
                  Utils.toastMessage('Please! enter your password');
                } else if (passwordController.text.length < 6) {
                  Utils.toastMessage('Please! enter 6 digits password');
                } else {
                  Map data = {
                    'email': emailController.text.toString(),
                    'password': passwordController.text.toString(),
                  };
                  provider.signupApiProvider(data, context);
                }
              },
            ),
            SizedBox(height: height * .085),
            InkWell(
              onTap: () {
                Navigator.pushNamed(context, RoutesName.login);
              },
              child: Text("Already have an account? Login"),
            ),
          ],
        ),
      ),
    );
  }
}
