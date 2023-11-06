import 'package:auto_route/auto_route.dart';
import 'package:chatter_application/main.dart';
import 'package:chatter_application/routes/router.gr.dart';
import 'package:flutter/cupertino.dart';
import 'package:supabase_auth_ui/supabase_auth_ui.dart';

// mock auth state
var isAuthenticated = supabase.auth.currentUser != null;

class AuthGuard extends AutoRouteGuard {
  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    if (!isAuthenticated) {
      // ignore: unawaited_futures
      router.push(
        LoginRoute(onLoginResult: (session) {
          if (session.event == AuthChangeEvent.signedIn) {
            isAuthenticated = true;
            router.markUrlStateForReplace();
            router.removeLast();
            resolver.next();
          } else {
            resolver.next(false);
          }
        }),
      );
    } else {
      resolver.next(true);
    }
  }
}

class AuthService extends ChangeNotifier {
  bool _isAuthenticated = false;

  bool get isAuthenticated => _isAuthenticated;

  set isAuthenticated(bool value) {
    _isAuthenticated = value;
    notifyListeners();
  }
}
