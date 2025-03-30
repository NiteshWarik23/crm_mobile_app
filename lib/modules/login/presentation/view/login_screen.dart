import 'package:crm_mobile_app/config/routes/routes.dart';
import 'package:crm_mobile_app/core/dependency%20injection/dependency_injection.dart';
import 'package:crm_mobile_app/modules/login/presentation/view_model/login_bloc/login_bloc.dart';
import 'package:crm_mobile_app/modules/login/presentation/view_model/login_bloc/login_event.dart';
import 'package:crm_mobile_app/modules/login/presentation/view_model/login_bloc/login_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>(); // Form Key
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscurePassword = true; // Toggle password visibility
  bool isDisabledValue = false;
  final LoginBloc loginBloc = locator<LoginBloc>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocProvider(
        create: (context) => loginBloc,
        child: BlocListener<LoginBloc, LoginState>(
          listener: (BuildContext context, LoginState state) {
            print("New State Emitted: $state"); // Debugging

            if (state is LoginLoadingState) {
              Fluttertoast.showToast(msg: 'Logging in..');
            } else if (state is LoginSuccessState) {
              // Navigate to home screen or dashboard
              Navigator.pushNamed(context, AppRoutes.dashboardRoute);
              Fluttertoast.showToast(msg: '"Welcome ${state.username}');
            } else if (state is LoginFailureState) {
              Fluttertoast.showToast(msg: state.errorMessage.toString());
            }
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Center(
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Logo
                      Image.asset(
                        'assets/images/logo.png', // Replace with your logo asset path
                        height: 80,
                      ),
                      const SizedBox(height: 20),

                      // Title Text
                      const Text(
                        "Login to OmniCRM",
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 30),

                      // Email Field
                      TextFormField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(
                            Icons.email,
                            color: Colors.black,
                          ),
                          labelText: "Email ID",
                          labelStyle: const TextStyle(color: Colors.black),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        keyboardType: TextInputType.emailAddress,
                        onChanged: (value) {
                          loginBloc.add(LoginCheckEvent(
                              userEnteredEmailId: _emailController.text,
                              userEnteredPassword: _passwordController.text));
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Email is required";
                          } else if (!RegExp(
                                  r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$")
                              .hasMatch(value)) {
                            return "Enter a valid email";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 15),

                      // Password Field
                      TextFormField(
                        controller: _passwordController,
                        obscureText: _obscurePassword,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(
                            Icons.lock,
                            color: Colors.black,
                          ),
                          labelText: "Password",
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscurePassword
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                            ),
                            onPressed: () {
                              setState(() {
                                _obscurePassword = !_obscurePassword;
                              });
                            },
                          ),
                        ),
                        onChanged: (value) {
                          loginBloc.add(LoginCheckEvent(
                              userEnteredEmailId: _emailController.text,
                              userEnteredPassword: _passwordController.text));
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Password is required";
                          } else if (value.length < 6) {
                            return "Password must be at least 6 characters";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 10),

                      // Forgot Password
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {
                            // Handle forgot password
                          },
                          child: const Text("Forgot Password?"),
                        ),
                      ),
                      const SizedBox(height: 10),

                      // Login Button
                      BlocBuilder<LoginBloc, LoginState>(
                        builder: (context, state) {
                          if (state is LoginCheckStatusState) {
                            isDisabledValue = state.buttonStatus;
                          }
                          return loginButtonWidget(context, isDisabledValue);
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget loginButtonWidget(BuildContext context, bool isDisabledValue) {
    print(isDisabledValue);
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        onPressed: isDisabledValue
            ? () {
                if (_formKey.currentState!.validate()) {
                  // context.read<LoginBloc>().add(LoginCheckEvent(
                  //     userEnteredEmailId: _emailController.text,
                  //     userEnteredPassword: _passwordController.text));
                  loginBloc.add(OnLoginClickEvent(
                      userEmailId: _emailController.text,
                      password: _passwordController.text));
                  // If validation passes, handle login
                  // ScaffoldMessenger.of(context).showSnackBar(
                  //   const SnackBar(content: Text("Logging in...")),
                  // );
                  print("🚀 Event dispatched to Bloc!");
                }
              }
            : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: isDisabledValue
              ? Colors.black
              : Colors.black, //Colors.grey.shade400,
          foregroundColor: isDisabledValue ? Colors.white : Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: const Text(
          "Login",
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
