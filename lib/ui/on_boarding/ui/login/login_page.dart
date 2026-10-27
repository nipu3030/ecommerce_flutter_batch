import 'package:ecommerce/domain/constants/app_routes.dart';
import 'package:ecommerce/ui/on_boarding/bloc/user_bloc.dart';
import 'package:ecommerce/ui/on_boarding/bloc/user_event.dart';
import 'package:ecommerce/ui/on_boarding/bloc/user_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var emailController = TextEditingController();
  var passController = TextEditingController();
  bool isLoading = false;
  bool isLogin = true;
  GlobalKey<FormState> validate = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(21),
            child: Center(
              child: Form(
                key: validate,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 40,),
                      Center(
                        child: CircleAvatar(
                          radius: 45,
                          backgroundColor: Colors.red,
                          child: Icon(
                            Icons.shopping_bag, size: 45, color: Colors.white,),
                        ),
                      ),
                      SizedBox(height: 30,),
                      Center(child: Text('Welcome Back',
                        style: TextStyle(fontSize: 28, fontWeight: FontWeight
                            .bold),)),
                      SizedBox(height: 20,),
                      Center(child: Text('Login To Continue Shopping.',
                        style: TextStyle(color: Colors.grey),)),
                      SizedBox(height: 30,),
                      Text('Email',
                        style: TextStyle(fontWeight: FontWeight.w600),),
                      SizedBox(height: 5,),
                      TextFormField(
                        controller: emailController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Enter Your Email';
                          } else {
                            return null;
                          }
                        },
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.email, color: Colors.red,),
                            hintText: 'Enter Your Email',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(21),
                                borderSide: BorderSide(color: Colors.black)
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(21),
                                borderSide: BorderSide(color: Colors.red)
                            )
                        ),
                      ),
                      SizedBox(height: 10,),
                      Text('Password',
                        style: TextStyle(fontWeight: FontWeight.w600),),
                      SizedBox(height: 5,),
                      TextFormField(
                        controller: passController,
                        obscureText: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Enter Your Password.';
                          } else if (value.length < 8) {
                            return 'Password must have at least 8 characters';
                          } else {
                            return null;
                          }
                        },
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.password, color: Colors
                                .red,),
                            hintText: 'Enter Your Password',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(21),
                                borderSide: BorderSide(color: Colors.black)
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(21),
                                borderSide: BorderSide(color: Colors.red)
                            )
                        ),
                      ),
                      SizedBox(height: 5,),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Text(
                          'Forget Password ? ', style: TextStyle(color: Colors
                            .red),),
                      ),
                      SizedBox(height: 50,),
                      InkWell(
                        splashColor: Colors.transparent,
                        onTap: () =>
                            Navigator.pushNamed(context, AppRoutes.PAGE_SIGNUP),
                        child: Center(
                          child: Text.rich(
                            TextSpan(
                                text: "Don't have an account.",
                                children: [
                                  TextSpan(
                                      text: ' Create Now.',
                                      style: TextStyle(color: Colors.red)
                                  )
                                ]
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 30,),
                      BlocConsumer<UserBloc, UserState>(
                        buildWhen: (ps, cs) => isLogin,
                        listenWhen: (ps, cs) => isLogin,
                        listener: (context, state) {
                          if (state is UserSuccessState) {
                            Navigator.pushReplacementNamed(
                                context, AppRoutes.PAGE_DASHBOARD);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text("User registered successfully!!"),
                                backgroundColor: Colors.green,
                              ),
                            );
                          } else if (state is UserFailureState) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(state.errorMsg)),
                            );
                          }
                        },
                        builder: (context, state) {
                          return SizedBox(
                            width: double.infinity,
                            height: 50,
                            child: ElevatedButton(
                                onPressed: () {
                                  if (validate.currentState!.validate()) {
                                    context.read<UserBloc>().add(
                                        LoginUserEvent(
                                            password: passController.text,
                                            email: emailController.text));
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.red),
                                child: isLoading ? Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text('Logging',
                                      style: TextStyle(color: Colors.white,fontSize: 20),),
                                    SizedBox(width: 10,),
                                    CircularProgressIndicator.adaptive()
                                  ],
                                ) : Text('Login',
                                  style: TextStyle(color: Colors.white,fontSize: 20),)
                            ),
                          );
                        },
                      )
                    ]),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
