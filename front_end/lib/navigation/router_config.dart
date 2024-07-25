import 'package:genix_auctions/features/detailed_items/presentation/item_details.dart';
import 'package:genix_auctions/features/homepage/presentation/home_page.dart';
import 'package:genix_auctions/features/login/presentation/login_page.dart';
import 'package:genix_auctions/features/signup/presentation/signup_page.dart';
import 'package:go_router/go_router.dart';

class MyRouterConfig {
  final GoRouter router = GoRouter(
    routerNeglect: false,
    initialLocation: "/home",
    routes: [
      GoRoute(
        path: "/home",
        builder: (context, state) {
          return const MyHomePage(title: "Genix Auction");
        },
      ),
      GoRoute(
        path: "/login",
        builder: (context, state) {
          return const LoginPage();
        },
      ),
      GoRoute(
        path: "/signup",
        builder: (context, state) {
          return const SignUpPage();
        },
      ),
      GoRoute(
        name: 'itemDetails',
        path: "/itemDetails/:id",
        builder: (context, state) {
          return ItemDetails(
            itemId: state.pathParameters['id']!,
          );
        },
      ),
    ],
  );
}
