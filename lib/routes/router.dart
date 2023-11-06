import 'package:auto_route/auto_route.dart';
import 'package:chatter_application/routes/auth_guard.dart';

import 'package:chatter_application/routes/router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Page,Route')
class RootRouter extends $RootRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          page: HomeRoute.page,
          initial: true,
          path: '',
          children: [
            RedirectRoute(path: '', redirectTo: 'home'),
            AutoRoute(
                page: AccountRoute.page, path: 'login', guards: [AuthGuard()]),
            AutoRoute(
              page: ChatRoute.page,
              path: ':id',
              title: (ctx, data) {
                return 'ChatID ${data.pathParams.get('id')}';
              },
            ),
          ],
        )
      ];
}
