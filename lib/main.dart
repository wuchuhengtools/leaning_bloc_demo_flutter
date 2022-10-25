import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lean_bloc_bogin_demo/app/app.dart';
import 'package:lean_bloc_bogin_demo/global_states/global_state_observer.dart';

import 'repositories/authentication_repository.dart';
import 'repositories/user_repository.dart';

void main() {
  Bloc.observer = GlobalStateObserver();
  runApp(
    App(
      authenticationRepository: AuthenticationRepository(),
      userRepository: UserRepository(),
    ),
  );
}
