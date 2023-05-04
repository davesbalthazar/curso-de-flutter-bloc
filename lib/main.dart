import 'dart:math';

import 'package:aula_bloc/bloc/user_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(
    const MaterialApp(
      home: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Aula Bloc'),
        ),
        body: SizedBox.expand(
          child: BlocProvider(
            create: (context) => UserBloc(),
            child: BlocBuilder<UserBloc, UserState>(
              builder: (context, state) {
                /*
                // Depois de 5 segundos emite o state novo
                if (state is UserInitial) {
                  Future.delayed(Duration(seconds: 3)).then((value) {
                    context.read<UserBloc>().add(const UserLogin('1', 'Daves'));
                  });
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                */

                if (state is UserInitial) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Usuário não logado'),
                      const SizedBox(height: 32),
                      ElevatedButton(
                        onPressed: () => context.read<UserBloc>().add(
                              const UserLogin('1', 'Daves'),
                            ),
                        child: const Text('Login'),
                      ),
                    ],
                  );
                }
                if (state is UserLoogedIn) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Id Usuario: ${state.userId}',
                        style: const TextStyle(fontSize: 20),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Nome: ${state.userName}',
                        style: const TextStyle(fontSize: 20),
                      ),
                      const SizedBox(height: 32),
                      ElevatedButton(
                        onPressed: () {
                          var rng = Random();

                          // Opção A
                          // BlocProvider.of<UserBloc>(context).add(UserLogin(
                          //     Random().nextInt(100).toString(), 'Pedro'));

                          // Opção B
                          context.read<UserBloc>().add(
                                UserLogin(
                                  rng.nextInt(100).toString(),
                                  'Pedro',
                                ),
                              );
                        },
                        child: const Text('Mudar Valor'),
                      ),
                    ],
                  );
                }

                return const SizedBox();
              },
            ),
          ),
        ));
  }
}
