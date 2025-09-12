import 'package:ecomm_395/ui/bloc/user_bloc/user_bloc.dart';
import 'package:ecomm_395/ui/bloc/user_bloc/user_state.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../utils/app_routes.dart';
import '../../bloc/user_bloc/user_event.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool isPasswordVisible = true;
  bool isLoading = false;
  bool isLogin = false;

  Future<void> _submitLogin() async {
    FocusScope.of(context).unfocus();
    if (!formKey.currentState!.validate()) return;
    isLogin = true;

    String email = emailController.text;
    String pass = passController.text;

    context.read<UserBloc>().add(LoginUserEvent(email: email, password: pass));

    /*
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: pass
      );

      if(credential.user != null){
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString(AppConstants.prefUserIdKey, credential.user!.displayName.toString());

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('You are logged in successfully!!')),
        );


        Navigator.pushReplacementNamed(context, AppRoutes.home);
      }

    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    } catch (e) {
      print(e);
    }
*/

    setState(() => isLoading = true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withAlpha(230),

      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 30),
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(height: 150),
                    Text(
                      'Login here!',
                      style: TextStyle(
                        fontSize: 35,
                        color: Color(0XFF6D7ED2),
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    SizedBox(height: 10),

                    ///email
                    TextFormField(
                      validator: (value) {
                        RegExp emailRegex = RegExp(
                          r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$",
                        );
                        if (value == null || value.isEmpty) {
                          return 'Please enter email here..';
                        } else if (!emailRegex.hasMatch(value)) {
                          return 'Please enter valid email';
                        } else {
                          return null;
                        }
                      },
                      keyboardType: TextInputType.text,
                      controller: emailController,
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        enabled: true,
                        hintText: "Phone number, username or email address",
                        hintStyle: TextStyle(color: Colors.black38),
                        border: OutlineInputBorder(),

                        /*prefixText: "Mr./Miss ",*/

                        /*prefix: Icon(Icons.abc),*/
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                      ),
                      /*onChanged: (value){
                      ///search or filter
                      print(value);
                    },*/
                    ),

                    SizedBox(height: 10),

                    ///password
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter password..';
                        } else {
                          return null;
                        }
                      },
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: isPasswordVisible,
                      obscuringCharacter: "*",
                      controller: passController,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        suffixIcon: InkWell(
                          onTap: () {
                            isPasswordVisible = !isPasswordVisible;
                            setState(() {});
                          },
                          child: Icon(
                            isPasswordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                        ),
                        hintText: "Password",
                        hintStyle: TextStyle(color: Colors.black38),
                        border: OutlineInputBorder(),
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                      ),
                      /*onChanged: (value){
                      ///search or filter
                      print(value);
                    },*/
                    ),
                    SizedBox(height: 10),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          "Forgotten Password?",
                          style: TextStyle(
                            color: Colors.blue[700],
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),

                    BlocConsumer<UserBloc, UserState>(
                      listenWhen: (ps, cs) {
                        return isLogin;
                      },

                      buildWhen: (ps, cs) {
                        return isLogin;
                      },

                      listener: (_, state) {
                        if (state is UserLoadingState) {
                          isLoading = true;
                        }

                        if (state is UserFailureState) {
                          isLoading = false;
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Login Failed : ${state.errorMsg}'),
                              backgroundColor: Colors.red,
                            ),
                          );
                          print("ErrorMsg ${state.errorMsg}");
                        }

                        if (state is UserSuccessState) {
                          isLoading = false;
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Log in Success !!'),
                              backgroundColor: Colors.green,
                            ),
                          );
                          Navigator.pushReplacementNamed(
                            context,
                            AppRoutes.dashboard_page,
                          );
                        }
                      },
                      builder: (_, state) {
                        return SizedBox(
                          height: 40,
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: isLoading ? null : _submitLogin,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue, // Button color
                              foregroundColor: Colors.white, // Text/icon color
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.zero, // Rounded corners
                              ),
                              // elevation: 5, // Shadow
                            ),
                            child: isLoading
                                ? Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      CircularProgressIndicator(
                                        color: Colors.white,
                                      ),
                                      SizedBox(width: 10),
                                      Text(
                                        'Logging in...',
                                        style: TextStyle(
                                          fontSize: 22,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  )
                                : Text(
                                    'Log In',
                                    style: TextStyle(
                                      fontSize: 22,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                          ),
                        );
                      },
                    ),

                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(height: 1, width: 130, color: Colors.grey),
                        Text("OR", style: TextStyle()),
                        Container(height: 1, width: 130, color: Colors.grey),
                      ],
                    ),
                    SizedBox(height: 30),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.facebook, color: Colors.blue[700]),
                        Text(
                          "Log in with Facebook",
                          style: TextStyle(
                            color: Colors.blue[700],
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 230),
            SizedBox(
              height: 80,
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    height: 1,
                    width: double.infinity,
                    color: Colors.grey,
                  ),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "Don't have an account?",
                          style: TextStyle(color: Colors.black38),
                        ),
                        TextSpan(
                          text: "Sign Up",
                          style: TextStyle(
                            color: Colors.blue[700],
                            fontWeight: FontWeight.bold,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              isLogin = false;
                              Navigator.pushNamed(context, AppRoutes.signup);
                            },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
