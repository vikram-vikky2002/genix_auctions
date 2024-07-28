import 'dart:convert';

import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:flutter/material.dart';
import 'package:genix_auctions/core/shared_preference.dart';
import 'package:genix_auctions/features/homepage/components/navi_bar.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future<void> loginUser() async {
    final response = await http.post(
      Uri.parse('http://localhost:3000/api/v1/auth/login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
          {'email': emailController.text, 'password': passwordController.text}),
    );

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      final token = jsonResponse['token'];
      // print("name : ${response.body}");
      // Decode the token to get user ID
      Map<String, dynamic> decodedToken = JwtDecoder.decode(token);
      String userId = decodedToken['_id'];
      // print("userID : $userId");

      // Save the token and user ID for future use
      await saveUserCredentials(token, userId, jsonResponse['userName']);
      // Save the token for authenticated requests and navigate to the main screen
      // Save token in shared_preferences or similar
      context.go('/home');
    } else {
      // Show error message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to login')),
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
                        "Welcome back ! Enter your credentials to access your account",
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
                      onTap: loginUser,
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
                          onTap: () => context.go('/signup'),
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
