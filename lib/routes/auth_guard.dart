import 'package:auto_route/auto_route.dart';
import 'package:chatter_application/main.dart';
import 'package:chatter_application/routes/router.gr.dart';
import 'package:flutter/cupertino.dart';
import 'package:supabase_auth_ui/supabase_auth_ui.dart';

// mock auth state
var isAuthenticated = supabase.auth.currentUser != null;

class AuthGuard extends AutoRouteGuard {
  @override
  Future<void> onNavigation(
      NavigationResolver resolver, StackRouter router) async {
    //log debug
    if (isAuthenticated) {
      resolver.resolveNext(true);
    } else {
      resolver.redirect(
        LoginRoute(onLoginResult: (session) {
          // resolver.resolveNext(didLogin, reevaluateNext: false);
          if (session.event == AuthChangeEvent.signedIn) {
            isAuthenticated = true;
            resolver.resolveNext(isAuthenticated, reevaluateNext: false);
          } else {
            resolver.resolveNext(false, reevaluateNext: true);
          }
        }),
      );
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
