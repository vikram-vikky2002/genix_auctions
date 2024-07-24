import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:flutter/material.dart';
import 'package:genix_auctions/features/homepage/components/navi_buttons.dart';
import 'package:genix_auctions/features/login/presentation/login_page.dart';
import 'package:go_router/go_router.dart';

class MyNavigationBar extends StatelessWidget {
  const MyNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlurryContainer(
      borderRadius: const BorderRadius.all(Radius.circular(20)),
      color: const Color.fromARGB(168, 254, 229, 237),
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
        ),
        height: 70,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 160),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const SizedBox(
                    height: 50,
                    child: Image(
                      image: AssetImage("assets/logo.png"),
                    ),
                  ),
                  const SizedBox(width: 14),
                  InkWell(
                    onTap: () => context.go('/home'),
                    child: const Text(
                      "Genix Auctions",
                      style: TextStyle(fontFamily: "Outfit", fontSize: 21),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const NavigationButton(text: "Auction"),
                  const NavigationButton(text: "Bidding"),
                  const NavigationButton(text: "About us"),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      children: [
                        Icon(Icons.translate_rounded, size: 20),
                        Padding(
                          padding: EdgeInsets.only(left: 5),
                          child: Text(
                            "English",
                            style:
                                TextStyle(fontFamily: "Outfit", fontSize: 14),
                          ),
                        ),
                        Icon(Icons.arrow_drop_down_outlined),
                      ],
                    ),
                  ),
                  const SizedBox(width: 14),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: InkWell(
                      onTap: () => context.go('/login'),
                      child: const Text(
                        "Login",
                        style: TextStyle(
                          color: Color.fromARGB(255, 29, 51, 255),
                          fontFamily: "Outfit-Bold",
                        ),
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        begin: Alignment.bottomLeft,
                        end: Alignment.topRight,
                        colors: [
                          Color.fromARGB(255, 87, 71, 255),
                          Color.fromARGB(255, 80, 179, 255),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(3),
                    ),
                    child: const Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                      child: Text(
                        "Get Started",
                        style: TextStyle(
                          color: Color.fromARGB(255, 255, 255, 255),
                          fontFamily: "Outfit",
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
