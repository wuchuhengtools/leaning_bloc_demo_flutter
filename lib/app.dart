import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lean_bloc_bogin_demo/bloc/authentication/bloc/authentication_bloc.dart';
import 'package:lean_bloc_bogin_demo/bloc/home/view/home_page.dart';
import 'package:lean_bloc_bogin_demo/bloc/login/bloc/login_bloc.dart';
import 'package:lean_bloc_bogin_demo/bloc/login/view/login_page.dart';
import 'package:lean_bloc_bogin_demo/bloc/splash/splash.dart';
import 'package:lean_bloc_bogin_demo/repositories/authentication_repository.dart';

import 'repositories/user_repository.dart';

class AppView extends StatelessWidget {
  final _navigatorKey = GlobalKey<NavigatorState>();

  AppView({super.key});

  NavigatorState get _navigator => _navigatorKey.currentState!;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: _navigatorKey,
      builder: (context, child) {
        return BlocListener<AuthenticationBloc, AuthenticationState>(
          listener: (context, state) {
            switch (state.status) {
              case AuthenticationStatus.unknown:
                break;
              case AuthenticationStatus.authenticated:
                _navigator.pushAndRemoveUntil<void>(HomePage.route(), (route) => false);
                break;
              case AuthenticationStatus.unauthenticated:
                _navigator.pushAndRemoveUntil<void>(LoginPage.route(), (route) => false);
                break;
            }
          },
          child: child,
        );
      },
      onGenerateRoute: (_) => SplashPage.route(),
    );
  }
}

class App extends StatelessWidget {
  final AuthenticationRepository authenticationRepository;
  final UserRepository userRepository;

  const App({
    super.key,
    required this.authenticationRepository,
    required this.userRepository,
  });

  @override
  Widget build(BuildContext context) {
    final child = MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => AuthenticationBloc(authenticationRepository: authenticationRepository, userRepository: userRepository)),
        BlocProvider(create: (_) => LoginBloc(authenticationRepository: authenticationRepository)),
      ],
      child: AppView(),
    );
    return RepositoryProvider<AuthenticationRepository>.value(value: authenticationRepository, child: child);
  }
}
