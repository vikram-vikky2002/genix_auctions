import 'package:genix_auctions/features/homepage/presentation/home_page.dart';
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
    ],
  );
}
