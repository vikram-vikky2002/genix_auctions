import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:flutter/material.dart';
import 'package:genix_auctions/core/shared_preference.dart';
import 'package:genix_auctions/features/homepage/components/navi_buttons.dart';
import 'package:genix_auctions/features/homepage/presentation/home_page.dart';
import 'package:go_router/go_router.dart';

class MyNavigationBar extends StatelessWidget {
  const MyNavigationBar({super.key, this.user});

  final String? user;

  @override
  Widget build(BuildContext context) {
    print(user);
    return Stack(
      children: [
        BlurryContainer(
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          color: const Color.fromARGB(168, 254, 229, 237),
          child: Container(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
            ),
            height: 60,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 160, vertical: 10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
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
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const NavigationButton(
                      text: "Auction",
                      subItems: ["Sub Auction 1", "Sub Auction 2"]),
                  const NavigationButton(
                      text: "Bidding",
                      subItems: ["Sub Bidding 1", "Sub Bidding 2"]),
                  const NavigationButton(text: "About us"),
                  const SizedBox(width: 14),
                  user == null
                      ? Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 15,
                              ),
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
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 8,
                                horizontal: 5,
                              ),
                              child: InkWell(
                                onTap: () => context.go('/signup'),
                                child: Container(
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
                                    padding: EdgeInsets.symmetric(
                                        vertical: 8, horizontal: 10),
                                    child: Text(
                                      "Get Started",
                                      style: TextStyle(
                                        color:
                                            Color.fromARGB(255, 255, 255, 255),
                                        fontFamily: "Outfit",
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                      : InkWell(
                          onTap: () => context.go('/profile'),
                          child: Container(
                            height: 30,
                            width: 30,
                            color: Colors.amber,
                          ),
                        )
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
