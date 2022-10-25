import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lean_bloc_bogin_demo/bloc/authentication/bloc/authentication_bloc.dart';
import 'package:lean_bloc_bogin_demo/bloc/login/bloc/login_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const HomePage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            /// todo 删除Builder包裹会怎么样?
            Builder(builder: (context) {
              final userId = context.select((AuthenticationBloc bloc) => bloc.state.user.id);
              return Text('UserId: $userId');
            }),
            Builder(builder: (context) {
              final userId = context.select((LoginBloc bloc) => bloc.state.username.value);
              return Text('username: $userId');
            }),
            ElevatedButton(
              onPressed: () => context.read<AuthenticationBloc>().add(AuthenticationLogoutRequested()),
              child: const Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }
}
