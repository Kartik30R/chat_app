import 'package:flutter/material.dart';
import 'package:hashtag/components/my_button.dart';
import 'package:hashtag/components/my_text_field.dart';
import 'package:hashtag/services/auth/auth_service.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key,required this.onTap});
  final void Function()?  onTap;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void signIn() async{

    final authService = Provider.of<AuthService>(context,listen: false);
    try{
      await authService.sighInWithEmailandPassword(emailController.text, passwordController.text);
    }catch (e){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
             
              Icon(
                Icons.message,
                size: 80,
                color: Colors.grey[800],
              ),
              const SizedBox(
                height: 50,
              ),
              const Text('Welcome back You have been missed'),
              const SizedBox(
                height: 25,
              ),
              MyTextfield(
                  controller: emailController,
                  hintText: 'Email',
                  obscureText: false),
              const SizedBox(
                height: 10,
              ),
              MyTextfield(
                  controller: passwordController,
                  hintText: 'Password',
                  obscureText: true),
                  const SizedBox(height: 25,),
                  MYButton(text: 'Sign In', onTap:signIn)
                  , 
                  const SizedBox(height: 25,),
                   Row(
                    children: [
                      Text('Not a member?'),
                       GestureDetector(onTap: widget.onTap,child: Text('Register now', style: TextStyle(fontWeight: FontWeight.bold),))
                    ],
                  )
            ],
          ),
        )),
      ),
    );
  }
}
