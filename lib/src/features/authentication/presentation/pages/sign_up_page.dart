import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/routes/app_routes.dart';
import '../../../../core/utils/validators/validator.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/auth_event.dart';
import '../bloc/auth_state.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  late final TextEditingController _confirmPasswordController;

  final _formKey = GlobalKey<FormState>();

  bool get _isFormValid => _formKey.currentState?.validate() ?? false;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastro'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'E-mail',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Campo E-mail é obrigatório';
                  }
                  if (!Validator.validateEmail(value)) {
                    return 'Digite um E-mail válido';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Senha',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Campo Senha é obrigatório';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _confirmPasswordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Confirmar Senha',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Campo Confirmar Senha é obrigatório';
                  } else if (value != _passwordController.text) {
                    return 'As senhas não coincidem';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              BlocConsumer<AuthBloc, AuthState>(
                listener: (context, state) {
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

                  if (state is AuthSuccessState) {
                    navigatorKey.currentState!.pushNamedAndRemoveUntil(
                      AppRoutes.home,
                      (_) => false,
                    );
                  }
                },
                builder: (context, state) {
                  return FilledButton(
                    style: FilledButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                    onPressed: state is AuthLoadingState
                        ? null
                        : () {
                            if (_isFormValid) {
                              BlocProvider.of<AuthBloc>(context).add(
                                SignUpEvent(
                                  email: _emailController.text,
                                  password: _passwordController.text,
                                ),
                              );
                            }
                          },
                    child: state is AuthLoadingState
                        ? const CircularProgressIndicator()
                        : const Text('Cadastrar'),
                  );
                },
              ),
              const SizedBox(height: 16),
              Align(
                alignment: Alignment.center,
                child: InkWell(
                  child: Text(
                    'Já tem uma conta? Entrar',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Theme.of(context).primaryColor),
                  ),
                  onTap: () {
                    navigatorKey.currentState!.pushReplacementNamed(
                      AppRoutes.signIn,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
