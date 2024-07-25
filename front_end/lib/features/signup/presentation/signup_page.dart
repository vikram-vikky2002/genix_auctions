import 'dart:convert';

import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:flutter/material.dart';
import 'package:genix_auctions/features/homepage/components/navi_bar.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  Future<void> signupUser() async {
    final response = await http.post(
      Uri.parse('http://localhost:3000/api/v1/auth/signup'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        'name': nameController.text,
        'email': emailController.text,
        'password': passwordController.text
      }),
    );

    if (response.statusCode == 201) {
      // Navigate to the login screen after successful signup
      context.go('/login');
    } else {
      // Show error message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to signup')),
      );
    }
  }

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
              bottom: 80,
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
                      "SignUp",
                      style: TextStyle(
                        fontFamily: "Outfit-Bold",
                        fontSize: 22,
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(12),
                      child: Text(
                        "New Bidders ! as soon as you have submitted your details \nyou will be eligible to bid in the auction.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: "Outfit",
                            fontSize: 12,
                            color: Color.fromARGB(255, 98, 98, 98)),
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
                          controller: nameController,
                          decoration: InputDecoration(
                              labelText: 'Enter your name',
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
                        horizontal: 40,
                        vertical: 10,
                      ),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.85,
                        child: TextField(
                          controller: confirmPasswordController,
                          obscureText: true,
                          decoration: InputDecoration(
                              labelText: 'confirm password',
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
                    const SizedBox(height: 20),
                    InkWell(
                      onTap: signupUser,
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
                                'Sign Up',
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
                    const SizedBox(height: 40),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Already have an account ?",
                          style: TextStyle(
                            fontFamily: 'Outfit',
                            fontSize: 14,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(width: 10),
                        InkWell(
                          onTap: () => context.go('/login'),
                          child: const Text(
                            "Sign In",
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
