import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_pizza_app/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:flutter_pizza_app/screens/home/blocs/get_pizza_bloc/get_pizza_bloc.dart';
import 'package:pizza_repository/pizza_repository.dart';

import 'screens/auth/blocs/sign_in_bloc/sign_in_bloc.dart';
import 'screens/auth/views/welcome_screen.dart';
import 'screens/home/views/home_screen.dart';

class MyAppView extends StatelessWidget {
  const MyAppView({super.key});

  @override
  Widget build(BuildContext context) {
    final MediaQueryData mediaQueryData = MediaQueryData.fromView(View.of(context));

    return MediaQuery(
      data: mediaQueryData.copyWith(
        textScaler: const TextScaler.linear(0.9),
      ),
      child: MaterialApp(
        title: 'Pizza Delivery',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.light(
              background: Colors.grey.shade200,
              onBackground: Colors.black,
              primary: Colors.black,
              onPrimary: Colors.white,
              secondary: Colors.blue),
        ),
        home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
          builder: (context, state) {
            if (state.status == AuthenticationStatus.authenticated) {
              return MultiBlocProvider(
                providers: [
                  BlocProvider(
                    create: (context) => SignInBloc(
                      context.read<AuthenticationBloc>().userRepository,
                    ),
                  ),
                  BlocProvider(
                    create: (context) => GetPizzaBloc(
                      FirebasePizzaRepo(),
                    )..add(GetPizza()),
                  ),
                ],
                child: const HomeScreen(),
              );
            } else {
              return const WelcomeScreen();
            }
          },
        ),
      ),
    );
  }
}
