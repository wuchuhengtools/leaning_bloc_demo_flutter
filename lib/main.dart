import 'package:flutter/material.dart';
import 'package:lean_bloc_bogin_demo/app.dart';

import 'repositories/authentication_repository.dart';
import 'repositories/user_repository.dart';

void main() {
  runApp(
    App(
      authenticationRepository: AuthenticationRepository(),
      userRepository: UserRepository(),
    ),
  );
}
