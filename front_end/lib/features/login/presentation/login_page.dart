import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:flutter/material.dart';
import 'package:genix_auctions/features/homepage/components/navi_bar.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          const Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 120),
                child: SizedBox(
                  width: 1000,
                  child: Image(
                    image: AssetImage("assets/images/login_bg.jpeg"),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 120,
              left: 190,
              bottom: 120,
            ),
            child: BlurryContainer(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.3,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: const Color.fromARGB(99, 255, 199, 167),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      "Login",
                      style: TextStyle(
                        fontFamily: "Outfit-Bold",
                        fontSize: 22,
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(12),
                      child: Text(
                        "Welcome back ! Enter your credentials to \naccess your account",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: "Outfit",
                          fontSize: 14,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 40,
                        vertical: 10,
                      ),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.85,
                        child: TextField(
                          controller: emailController,
                          decoration: InputDecoration(
                              labelText: 'Enter your email',
                              labelStyle: const TextStyle(
                                fontFamily: 'Outfit',
                                fontSize: 12,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                gapPadding: 4,
                              ),
                              filled: true,
                              fillColor:
                                  const Color.fromARGB(130, 255, 212, 172)),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 40,
                        vertical: 10,
                      ),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.85,
                        child: TextField(
                          controller: passwordController,
                          obscureText: true,
                          decoration: InputDecoration(
                              labelText: 'Enter your password',
                              labelStyle: const TextStyle(
                                fontFamily: 'Outfit',
                                fontSize: 12,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                gapPadding: 4,
                              ),
                              filled: true,
                              fillColor:
                                  const Color.fromARGB(130, 255, 212, 172)),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          InkWell(
                            onTap: () {},
                            child: const Text(
                              'Forgot your password ?',
                              style: TextStyle(
                                fontFamily: 'Outfit',
                                fontSize: 13,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    InkWell(
                      onTap: () {
                        // FlutterFirebaseRepo()
                        //     .signInWithEmail(
                        //         emailController.text, passwordController.text)
                        //     .then((value) {
                        //   final snackdemo = SnackBar(
                        //     content: Text(value != '' ? value : "Error"),
                        //     backgroundColor: value == "Login Success"
                        //         ? Colors.green
                        //         : Colors.redAccent,
                        //     elevation: 10,
                        //     behavior: SnackBarBehavior.floating,
                        //     margin: const EdgeInsets.all(5),
                        //   );
                        //   ScaffoldMessenger.of(context).showSnackBar(snackdemo);
                        // });
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 90),
                        child: Container(
                          decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 255, 122, 51),
                              borderRadius: BorderRadius.circular(20)),
                          child: const Center(
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 10),
                              child: Text(
                                'Sign In',
                                style: TextStyle(
                                  fontFamily: 'Outfit',
                                  fontSize: 14,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    // Padding(
                    //   padding: const EdgeInsets.symmetric(
                    //       horizontal: 25, vertical: 20),
                    //   child: Row(
                    //     mainAxisAlignment: MainAxisAlignment.spaceAround,
                    //     children: [
                    //       Container(
                    //         width: MediaQuery.of(context).size.width * 0.08,
                    //         height: 2,
                    //         color: const Color.fromARGB(255, 201, 201, 201),
                    //       ),
                    //       const Text(
                    //         'or continue with',
                    //         style: TextStyle(
                    //             color: Color.fromARGB(255, 104, 104, 104)),
                    //       ),
                    //       Container(
                    //         width: MediaQuery.of(context).size.width * 0.08,
                    //         height: 2,
                    //         color: const Color.fromARGB(255, 201, 201, 201),
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    // Padding(
                    //   padding: const EdgeInsets.symmetric(horizontal: 60),
                    //   child: Container(
                    //     decoration: BoxDecoration(
                    //         color: const Color.fromARGB(159, 217, 217, 217),
                    //         borderRadius: BorderRadius.circular(13),
                    //         border: Border.all(
                    //             color:
                    //                 const Color.fromARGB(255, 108, 108, 108))),
                    //     width: MediaQuery.of(context).size.width * 0.85,
                    //     child: Padding(
                    //       padding: const EdgeInsets.symmetric(vertical: 13),
                    //       child: InkWell(
                    //         onTap: () {},
                    //         child: const Center(
                    //           child: Row(
                    //             mainAxisAlignment: MainAxisAlignment.center,
                    //             children: [
                    //               SizedBox(
                    //                 width: 25,
                    //                 height: 25,
                    //                 child: Image(
                    //                   image:
                    //                       AssetImage('assets/icons/google.png'),
                    //                 ),
                    //               ),
                    //               SizedBox(width: 15),
                    //               Text(
                    //                 'Sign in with Google',
                    //                 style: TextStyle(
                    //                   fontFamily: 'Outfit',
                    //                   fontSize: 14,
                    //                   color: Colors.black,
                    //                 ),
                    //               )
                    //             ],
                    //           ),
                    //         ),
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    const SizedBox(height: 40),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Don't have an account ?",
                          style: TextStyle(
                            fontFamily: 'Outfit',
                            fontSize: 14,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(width: 10),
                        InkWell(
                          onTap: () {},
                          child: const Text(
                            "Sign Up",
                            style: TextStyle(
                              fontFamily: 'Outfit-Bold',
                              fontSize: 14,
                              color: Color.fromARGB(255, 255, 122, 51),
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(10),
            child: MyNavigationBar(),
          ),
        ],
      ),
    );
  }
}
