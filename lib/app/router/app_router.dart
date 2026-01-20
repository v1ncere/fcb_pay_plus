import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../models/ModelProvider.dart';
import '../../pages/account_add/account_add.dart';
import '../../pages/account_viewer/account_viewer.dart';
import '../../pages/bottom_navbar/bottom_navbar.dart';
import '../../pages/dynamic_viewer/dynamic_viewer.dart';
import '../../pages/forgot_password/forgot_password.dart';
import '../../pages/local_authentication/local_authentication.dart';
import '../../pages/login/login.dart';
import '../../pages/merchant_add/merchant_add.dart';
import '../../pages/notifications/notifications.dart';
import '../../pages/notifications_viewer/notifications_viewer.dart';
import '../../pages/receipt/views/receipt_page.dart';
import '../../pages/scanner/scanner.dart';
import '../../pages/scanner_transaction/scanner_transaction.dart';
import '../../pages/settings/settings.dart';
import '../../pages/sign_up/sign_up.dart';
import '../../pages/update_password/update_password.dart';
import '../../pages/walk_through/walk_through.dart';
import '../../splash/splash.dart';
import '../../utils/utils.dart';
import '../app.dart';
import '../widgets/widgets.dart';

class AppRouter {
  static GoRouter router(BuildContext context) {
    final appBloc = BlocProvider.of<AppBloc>(context);
    return GoRouter(
      initialLocation: '/splash',
      routes: [
        // splash
        GoRoute(
          name: RouteName.splash,
          path: '/splash',
          builder: (context, state) => const Splash(),
        ),
        // walkthrough
        GoRoute(
          name: RouteName.walkThrough,
          path: '/walkThrough',
          builder: (context, state) => const WalkThroughPage(),
        ),
        // login
        GoRoute(
          name: RouteName.login,
          path: '/login',
          builder: (context, state) => const LoginPage(),
          routes: [
            GoRoute(
              name: RouteName.signUp,
              path: 'signUp',
              builder: (context, state) => SignupRoute(),
            ),
            GoRoute(
              name: RouteName.signupPitakard,
              path: 'signupPitakard',
              builder: (context, state) => SignupRoute(),
            ),
          ]
        ),
        ShellRoute(
          builder: (context, state, child) => ForgotPasswordPage(child: child),
          routes: [
            GoRoute(
              path: '/reset/email',
              builder: (context, state) => EmailStep(),
            ),
            GoRoute(
              path: '/reset/code',
              builder: (context, state) => CodeStep(),
            ),
            GoRoute(
              path: '/reset/new_password',
              builder: (context, state) => NewPasswordStep(),
            )
          ]
        ),
        // authentication
        GoRoute(
          name: RouteName.authPin,
          path: '/',
          builder: (context, state) => const AuthPinPage(),
          routes: [
            GoRoute(
              name: RouteName.createPin,
              path: 'createPin',
              builder: (context, state) => const CreatePinPage()
            ),
            GoRoute(
              name: RouteName.updatePin,
              path: 'updatePin',
              builder: (context, state) => const UpdatePinPage()
            )
          ]
        ),
        // bottom navbar
        GoRoute(
          name: RouteName.bottomNavbar,
          path: '/bottomNavbar',
          builder: (context, state) => const BottomNavbarPage(),
          routes: [
            // (lvl1) account viewer page
            GoRoute(
              name: RouteName.account,
              path: 'account',
              builder: (context, state) {
                Account account = state.extra as Account;
                return AccountViewerPage(account: account);
              }
            ),
            // (lvl1) notification page
            GoRoute(
              name: RouteName.notification,
              path: 'notification',
              builder: (context, state) => const NotificationPage(),
              routes: [
                GoRoute(
                  name: RouteName.notificationViewer,
                  path: 'notificationViewer/:id',
                  builder: (context, state) => NotificationsViewerPage(id: state.pathParameters['id']),
                )
              ]
            ),
            // (lvl1) scanner page
            GoRoute(
              name: RouteName.scanner,
              path: 'scanner',
              builder: (context, state) => const ScannerPage(),
              routes: [
                GoRoute(
                  name: RouteName.scannerTransaction,
                  path: 'scannerTransaction',
                  builder: (context, state) => const ScannerTransactionPage(),
                )
              ]
            ),
            // (lvl last) receipt page
            GoRoute( // TODO: change from receipt to Transactions
              name: RouteName.receipt,
              path: 'receipt/:receiptId',
              builder: (context, state) => ReceiptPage(
                accountNumber: state.pathParameters['accountNumber'],
                referenceId: state.pathParameters['referenceId'],
                transCode: state.pathParameters['transCode'],
                transDate: state.pathParameters['transDate'] as TemporalDate,
              ),
            ),
            // (lvl2) dynamic page viewer
            GoRoute(
              name: RouteName.dynamicViewer,
              path: 'dynamicViewer/:accountNumber',
              builder: (context, state) {
                Button button = state.extra as Button;
                return DynamicViewerPage(accountNumber: state.pathParameters['accountNumber'], button: button,);
              }
            ),
            // (lvl 2) add account page
            GoRoute(
              name: RouteName.addAccount,
              path: 'addAccount',
              builder: (context, state) => const AccountAddPage()
            ),
            GoRoute(
              name: RouteName.addMerchant,
              path: 'addMerchant',
              builder: (context, state) => const MerchantAddPage()
            ),
            // (lvl 1) settings page
            GoRoute(
              name: RouteName.settings,
              path: 'settings',
              builder: (context, state) => const SettingsPage(),
            ),
            // (lvl 2) update password page
            GoRoute(
              name: RouteName.updatePassword,
              path: 'updatePassword',
              builder: (context, state) => const UpdatePasswordPage(),
            )
          ]
        )
      ],
      refreshListenable: StreamToListenable(appBloc.stream),
      redirect: (context, state) {
        final status = appBloc.state.status;
        final location = state.matchedLocation;
        
        final isSplash = location == '/splash';
        // final isLogin = location == '/login';

        // Define protected routes
        // final protectedPaths = ['/dashboard', '/profile', '/settings'];

        // Check if the current route is a protected route
        // final isProtectedRoute = protectedPaths.contains(state.matchedLocation);

        // Handle unauthenticated users on protected routes
        // if (isUnauthenticated && isProtectedRoute) {
        //   return '/login?redirect=${state.matchedLocation}';
        // }

        // ❌ Not logged in
        if (status.isUnauthenticated && isSplash) {
          return '/login';
        }

        // ✅ Logged in
        if (status.isAuthenticated && isSplash) {
          return '/';
        }
        
        return null;
      },
      observers: [MyNavigatorObserver()]
    );
  }
}
