import 'package:go_router/go_router.dart';
import 'package:govt_billing/view/invoices/invoice_detail_screen.dart';
import 'package:govt_billing/view/landing_screen.dart';

final goRoutes = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const LandingScreen(),
    ),
    GoRoute(
      path: '/invoice',
      builder: (context, state) => InvoiceDetailScreen(id: state.queryParameters['id'] ?? ""),
    ),
  ],
);