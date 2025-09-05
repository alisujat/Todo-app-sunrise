import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/core/utils/media_query.dart';
import 'package:todo_app/core/widets/custom_spacer.dart';
import 'package:todo_app/core/widets/loader.dart';
import 'package:todo_app/core/widets/reusable_text.dart';
import 'package:todo_app/feature/auth/presentation/bloc/auth_bloc.dart';
import 'package:todo_app/feature/presentation/screens/todo.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});
  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: SizeUtils.screenHeight(context) * 0.18,
            horizontal: 32,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Height(height: SizeUtils.screenHeight(context) * 0.1),
              Image.asset(
                'assets/logo.png',
                height: SizeUtils.screenHeight(context) * 0.15,
              ),
              const Height(),
              BlocConsumer<AuthBloc, AuthState>(
                listener: (context, state) async {
                  if (state is AuthFailure) {
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(SnackBar(content: Text(state.message)));
                  } else if (state is AuthSuccess) {
                    if (!mounted) return;
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => const AddTodoItems(),
                      ),
                    );
                  }
                },
                builder: (context, state) {
                  if (state is AuthLoading) {
                    return const Center(child: Loader());
                  }
                  return Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Height(),

                        const Height(),
                        SizedBox(
                          width: SizeUtils.screenWidth(context),
                          child: ElevatedButton(
                            onPressed: () {
                              // your action here
                              context.read<AuthBloc>().add(AuthSignInGoogle());
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,
                              foregroundColor: Colors.white,
                              textStyle: const TextStyle(fontSize: 16),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  'assets/google.png',
                                  height: 24,
                                  width: 24,
                                ),
                                const SizedBox(width: 16),
                                const ReusableText(
                                  text: 'Sign In with Google',
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  // color: Colors.white,
                                ),
                              ],
                            ),
                          ),
                        ),
                        const Height(),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const AddTodoItems(),
                              ),
                            );
                          },
                          child: const Text(
                            "Don't have an account? Continue as Guest",
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
