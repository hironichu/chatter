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
          path: '/',
          guards: [AuthGuard()],
          children: [
            AutoRoute(
                page: AccountRoute.page,
                path: 'account',
                guards: [AuthGuard()]),
            AutoRoute(
              page: ChatRoute.page,
              path: ':id',
              title: (ctx, data) {
                return 'ChatID ${data.pathParams.get('id')}';
              },
            ),
          ],
        ),
        AutoRoute(path: '/login', page: LoginRoute.page)
      ];
}
