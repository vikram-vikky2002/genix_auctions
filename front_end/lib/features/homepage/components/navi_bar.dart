import 'package:flutter/material.dart';
import 'package:genix_auctions/features/homepage/components/navi_buttons.dart';

class MyNavigationBar extends StatelessWidget {
  const MyNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      color: const Color.fromARGB(255, 254, 229, 237),
      height: 70,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 140),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Row(
              children: [
                SizedBox(
                  height: 50,
                  child: Image(
                    image: AssetImage("assets/logo.png"),
                  ),
                ),
                SizedBox(width: 14),
                Text(
                  "Genix Auctions",
                  style: TextStyle(fontFamily: "Outfit", fontSize: 21),
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
                          style: TextStyle(fontFamily: "Outfit", fontSize: 14),
                        ),
                      ),
                      Icon(Icons.arrow_drop_down_outlined),
                    ],
                  ),
                ),
                const SizedBox(width: 14),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    "Login",
                    style: TextStyle(
                      color: Color.fromARGB(255, 29, 51, 255),
                      fontFamily: "Outfit-Bold",
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
                    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
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
    );
  }
}
