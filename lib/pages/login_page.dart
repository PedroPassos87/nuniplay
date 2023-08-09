import 'package:animated_background/animated_background.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:uniplay/components/my_button.dart';
import 'package:uniplay/components/my_textfield.dart';
import 'package:uniplay/components/square_tile.dart';
import 'package:uniplay/services/auth_service.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key, required this.onTap}) : super(key: key);

  final Function()? onTap;
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with TickerProviderStateMixin {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  //sign user in method
  void signUserIn() async {
    //show loading circle ---> in the future change for an animation
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: SpinKitPouringHourGlassRefined(color: Colors.white,size: 50,),
        );
      },
    );

    //try sign in
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      //pop the loading circle
      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      //pop the loading circle
      Navigator.pop(context);
      showErrorMessage('Email ou senha invalidos.');
    }
  }

  //wrong email or password popup
  void showErrorMessage(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Color.fromARGB(255, 13, 254, 0),
          title: Center(
            child: Text(
              message,
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 3, 173, 240),
      body: AnimatedBackground(
        behaviour: RandomParticleBehaviour(
          options: const ParticleOptions(
            spawnMaxRadius: 30,
            spawnMinSpeed: 10.00,
            particleCount: 60,
            spawnMaxSpeed: 50.00,
            minOpacity: 0.1,
            spawnOpacity: 0.3,
            
            image: Image(image: AssetImage('assets/images/spaceinvader.png')),            
          )
        ),
        vsync: this,
        child: SafeArea(
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    //logo
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/logouni.png',
                          height: 175,
                        ),
                      ],
                    ),
        
                    const SizedBox(height: 14),
                    //welcome user
                    const Text(
                      'GOOD TO SEE YOU AGAIN', //escolher uma mensagem melhor
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                    ),
        
                    const SizedBox(height: 20),
        
                    //email textfield
                    MyTextField(
                      controller: emailController,
                      hintText: 'E-mail',
                      obscureText: false,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
        
                    //password textfield
                    MyTextField(
                      controller: passwordController,
                      hintText: 'Password',
                      obscureText: true,
                    ),
        
                    const SizedBox(
                      height: 5,
                    ),
        
                    //forgot password
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 25.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            'Forgot Password?',
                            style: TextStyle(
                                color: Colors.white, fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
        
                    const SizedBox(
                      height: 25,
                    ),
        
                    //sign in
                    MyButton(
                      onTap: signUserIn,
                      text: 'Sign in',
                    ),
        
                    const SizedBox(
                      height: 10,
                    ),
        
                    //continue with
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: Row(
                        children: [
                          Expanded(
                            child: Divider(
                              thickness: 0.7,
                              color: Colors.lightBlue[900],
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: Text(
                              'Or continue with',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          Expanded(
                            child: Divider(
                              thickness: 0.7,
                              color: Colors.lightBlue[900],
                            ),
                          ),
                        ],
                      ),
                    ),
        
                    const SizedBox(height: 25),
        
                    //google sign
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        //google button
                        SquareTile(
                          onTap: () => AuthService().signInWithGoogle(),
                          imagePath: 'assets/images/google.png',
                          ),
        
                        const SizedBox(width: 10),
        
                        //future buttons
                      ],
                    ),
        
                    const SizedBox(
                      height: 25,
                    ),
                    //not a member? register now
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Not a member?',
                          style: TextStyle(color: Colors.white),
                        ),
                        const SizedBox(
                          width: 4,
                        ),
                        GestureDetector(
                          onTap: widget.onTap,
                          child: const Text(
                            'Register now',
                            style: TextStyle(
                                color: Colors.amber, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
      ),
      );
  }
}
