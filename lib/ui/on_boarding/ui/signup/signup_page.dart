import 'package:ecommerce/domain/constants/app_routes.dart';
import 'package:ecommerce/ui/on_boarding/bloc/user_bloc.dart';
import 'package:ecommerce/ui/on_boarding/bloc/user_event.dart';
import 'package:ecommerce/ui/on_boarding/bloc/user_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var mobileController = TextEditingController();
  var passwordController = TextEditingController();
  var confirmPasswordController = TextEditingController();
  bool isLoading = false;
  bool isPassHidden = true;
  GlobalKey<FormState> validateKey = GlobalKey();
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
                key: validateKey,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: CircleAvatar(
                          radius: 45,
                          backgroundColor: Colors.red,
                          child: Icon(Icons.shopping_bag,size: 45,color: Colors.white,),
                        ),
                      ),
                      SizedBox(height: 30,),
                      Center(child: Text('Create Account',style: TextStyle(fontSize: 28,fontWeight: FontWeight.bold),)),
                      SizedBox(height: 20,),
                      Center(child: Text('Signup in Shoppy',style: TextStyle(color: Colors.grey),)),
                      SizedBox(height: 20,),
                      Text('Name',style: TextStyle(fontWeight: FontWeight.w600),),
                      SizedBox(height: 5,),
                      TextFormField(
                        controller: nameController,
                        validator: (value){
                          if(value == null || value.isEmpty){
                            return 'Enter Your Name';
                          } else{
                            return null;
                          }
                        },
                        decoration: InputDecoration(
                           prefixIcon: Icon(Icons.person,color: Colors.red,),
                            hintText: 'Enter Your Name',
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
                      Text('Email',style: TextStyle(fontWeight: FontWeight.w600),),
                      SizedBox(height: 5,),
                      TextFormField(
                        controller: emailController,
                        validator: (value){
                          if(value == null || value.isEmpty){
                            return 'Enter Your Email';
                          } else{
                            return null;
                          }
                        },
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.email,color: Colors.red,),
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
                      Text('Mobile',style: TextStyle(fontWeight: FontWeight.w600),),
                      SizedBox(height: 5,),
                      TextFormField(
                        controller: mobileController,
                        validator: (value){
                          if(value == null || value.isEmpty){
                            return 'Enter Your Mobile';
                          } else{
                            return null;
                          }
                        },
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.phone,color: Colors.red,),
                            hintText: 'Enter Your Mobile Number',
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
                      Text('Password',style: TextStyle(fontWeight: FontWeight.w600),),
                      SizedBox(height: 5,),
                      TextFormField(
                        controller: passwordController,
                        obscureText: isPassHidden,
                        validator: (value){
                          if(value == null || value.isEmpty){
                            return 'Enter Your Password.';
                          } else if(value.length<8){
                            return 'Password must have at least 8 characters';
                          }else{
                            return null;
                          }
                        },
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                              onPressed: (){
                                isPassHidden = !isPassHidden;
                                setState(() {});
                              },
                              icon: isPassHidden ? Icon(Icons.visibility_off) : Icon(Icons.visibility_off)),
                            prefixIcon: Icon(Icons.password,color: Colors.red,),
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
                      SizedBox(height: 10,),
                      Text('Confirm Password',style: TextStyle(fontWeight: FontWeight.w600),),
                      SizedBox(height: 5,),
                      TextFormField(
                        controller: confirmPasswordController,
                        obscureText: isPassHidden,
                        decoration: InputDecoration(
                            suffixIcon: IconButton(
                                onPressed: (){
                                  isPassHidden = !isPassHidden;
                                  setState(() {});
                                },
                                icon: isPassHidden ? Icon(Icons.visibility) : Icon(Icons.visibility_off)),
                            prefixIcon: Icon(Icons.password,color: Colors.red,),
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
                      SizedBox(height: 30,),
                      InkWell(
                        splashColor: Colors.transparent,
                        onTap: (){
                          Navigator.pushReplacementNamed(context, AppRoutes.PAGE_LOGIN);
                        },
                        child: Center(
                          child: Text.rich(
                            TextSpan(
                                text: "Already have an account.",
                                children: [
                                  TextSpan(
                                      text: ' Login Now.',
                                      style: TextStyle(color: Colors.red)
                                  )
                                ]
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 30,),
                      BlocConsumer<UserBloc,UserState>(
                        listener: (context,state){
                          if(state is UserLoadingState){
                           isLoading = true;
                          }
                         if(state is UserSuccessState){
                           isLoading = false;
                          Navigator.pop(context);
                           ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Account Created Successfully.'),backgroundColor: Colors.green,));
                         }
                         if(state is UserFailureState){
                           isLoading = false;
                           ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.errorMsg,),backgroundColor: Colors.red,));
                         }
                        },
                        builder: (context,state){
                          return SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: (){
                              if(validateKey.currentState!.validate()){
                                context.read<UserBloc>().add(RegisterUserEvent(
                                    name: nameController.text,
                                    email: emailController.text,
                                    password: passwordController.text,
                                    mobNo: mobileController.text));
                              }
                            },
                            child: isLoading ? Row(
                              children: [
                                SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator.adaptive(),
                                ),
                                SizedBox(width: 10,),
                                Text('Please Wait!!',style: TextStyle(fontSize: 18,color: Colors.white),)
                              ],
                            ) : Text('Signup'),
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red
                            ),),
                        );
                        }
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
