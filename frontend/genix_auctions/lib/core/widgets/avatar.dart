import 'package:flutter/material.dart';
import 'package:genix_auctions/profile_page.dart';

class Avatar extends StatelessWidget {
  final String imageUrl;
  final double radius;

  const Avatar({
    super.key,
    required this.imageUrl,
    this.radius = 20.0,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const ProfilePage()));
      },
      child: CircleAvatar(
          radius: radius,
          // backgroundColor: Colors.blue,
          child: const Padding(
            padding: EdgeInsets.all(5),
            child: Image(image: AssetImage('./assets/contact.png')),
          )),
    );
  }
}
