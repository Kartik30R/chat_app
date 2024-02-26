import 'package:flutter/material.dart';
import 'package:hashtag/components/my_button.dart';
import 'package:hashtag/components/my_text_field.dart';
import 'package:hashtag/services/auth/auth_service.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key,  required this.onTap});
  final void Function()? onTap;
  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmpasswordController = TextEditingController();

Future<void> signUp() async {
  if(passwordController.text != confirmpasswordController.text){
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('passwords do not match'))
    );

    return;
  }

  final authservice= Provider.of<AuthService>(context, listen: false);
  try{
    await authservice.signUpWithEmailandPassword(emailController.text, passwordController.text);
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
              const Text('Lets create an account for you!'),
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
              const SizedBox(
                height: 10,
              ),
              MyTextfield(
                  controller: confirmpasswordController,
                  hintText: 'Confirm Password',
                  obscureText: true),
                  const SizedBox(height: 25,),
                   MYButton(text: 'Sign In', onTap: signUp)
                  , 
                  const SizedBox(height: 25,),
                   Row(
                    children: [
                      Text('Already a member?'),
                       GestureDetector(onTap:widget.onTap,child: Text('Sing In', style: TextStyle(fontWeight: FontWeight.bold),))
                    ],
                  )
            ],
          ),
        )),
      ),
    );
  }
}
