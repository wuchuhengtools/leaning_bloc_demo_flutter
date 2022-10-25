import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lean_bloc_bogin_demo/repositories/authentication_repository.dart';

import '../global_states/bloc/authentication_bloc.dart';
import '../global_states/login/login_bloc.dart';
import '../repositories/user_repository.dart';
import 'app_view.dart';

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
    final child = Builder(
      builder: (context) {
        final authenticationRepository = RepositoryProvider.of<AuthenticationRepository>(context);
        return MultiBlocProvider(
          providers: [
            BlocProvider(create: (_) => AuthenticationBloc(authenticationRepository: authenticationRepository, userRepository: userRepository)),
            BlocProvider(create: (_) => LoginBloc(authenticationRepository: authenticationRepository)),
          ],
          child: AppView(),
        );
      },
    );

    return RepositoryProvider<AuthenticationRepository>.value(value: authenticationRepository, child: child);
  }
}
