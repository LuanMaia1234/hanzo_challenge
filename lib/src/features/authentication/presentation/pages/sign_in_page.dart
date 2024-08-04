import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/routes/app_routes.dart';
import '../../../../core/utils/validators/validator.dart';
import '../../../authentication/presentation/bloc/auth_bloc.dart';
import '../../../authentication/presentation/bloc/auth_event.dart';
import '../../../authentication/presentation/bloc/auth_state.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  final _formKey = GlobalKey<FormState>();

  bool get _isFormValid => _formKey.currentState?.validate() ?? false;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
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
        title: const Text('Login'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
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
                                SignInEvent(
                                  email: _emailController.text,
                                  password: _passwordController.text,
                                ),
                              );
                            }
                          },
                    child: state is AuthLoadingState
                        ? const CircularProgressIndicator()
                        : const Text('Entrar'),
                  );
                },
              ),
              const SizedBox(height: 16),
              Align(
                alignment: Alignment.center,
                child: InkWell(
                  child: Text(
                    'Ainda não tem um conta? Cadastrar-se',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Theme.of(context).primaryColor),
                  ),
                  onTap: () {
                    navigatorKey.currentState!.pushReplacementNamed(
                      AppRoutes.signUp,
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
