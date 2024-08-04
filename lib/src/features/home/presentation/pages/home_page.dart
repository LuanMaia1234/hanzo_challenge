import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/routes/app_routes.dart';
import '../../../authentication/presentation/bloc/auth_bloc.dart';
import '../../../authentication/presentation/bloc/auth_event.dart';
import '../../../authentication/presentation/bloc/auth_state.dart';
import '../bloc/todo_bloc.dart';
import '../bloc/todo_state.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        centerTitle: true,
        actions: <Widget>[
          BlocListener<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is SignedOutState) {
                navigatorKey.currentState!.pushNamedAndRemoveUntil(
                  AppRoutes.signIn,
                  (_) => false,
                );
              }
              if (state is AuthErrorState) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      state.message,
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                );
              }
            },
            child: PopupMenuButton<String>(
              onSelected: (item) => {
                if (item == 'signOut')
                  BlocProvider.of<AuthBloc>(context).add(const SignOutEvent())
              },
              itemBuilder: (context) => [
                const PopupMenuItem(value: 'signOut', child: Text('Sair')),
              ],
            ),
          ),
        ],
      ),
      body: BlocConsumer<TodoBloc, TodoState>(
        listener: (context, state) {
          if (state is TodoErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  state.message,
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is TodoLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is TodoSuccessState) {
            if (state.todos.isEmpty) return _emptyState();
            return ListView.separated(
              separatorBuilder: (_, __) => const Divider(),
              itemCount: state.todos.length,
              itemBuilder: (context, index) {
                final todo = state.todos[index];
                return CheckboxListTile(
                  title: Text(todo.title),
                  value: todo.completed,
                  onChanged: (_) {},
                );
              },
            );
          }
          return _emptyState();
        },
      ),
    );
  }

  Widget _emptyState() {
    return const Center(
      child: Text(
        'Nenhuma tarefa encontrada',
        style: TextStyle(fontSize: 16),
      ),
    );
  }
}
