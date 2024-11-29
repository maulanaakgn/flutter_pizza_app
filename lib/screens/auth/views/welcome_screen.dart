// import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_pizza_app/blocs/authentication_bloc/authentication_bloc.dart';

import '../blocs/sign_in_bloc/sign_in_bloc.dart';
import '../blocs/sign_up_bloc/sign_up_bloc.dart';
import 'sign_in_screen.dart';
import 'sign_up_screen.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with TickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    tabController = TabController(
      initialIndex: 0,
      length: 2,
      vsync: this,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  top: 90,
                  bottom: 50,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/8.png",
                      scale: 10,
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    const Text(
                      "PIZZA",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 45,
                      ),
                    ),
                  ],
                ),
              ),
              Stack(
                children: [
                  // Align(
                  //   alignment: const AlignmentDirectional(20, -1.2),
                  //   child: Container(
                  //     height: MediaQuery.of(context).size.width,
                  //     width: MediaQuery.of(context).size.width,
                  //     decoration: BoxDecoration(
                  //       shape: BoxShape.circle,
                  //       color: Theme.of(context).colorScheme.tertiary,
                  //     ),
                  //   ),
                  // ),
                  // BackdropFilter(
                  //   filter: ImageFilter.blur(
                  //     sigmaX: 100.0,
                  //     sigmaY: 100.0,
                  //   ),
                  //   child: Container(),
                  // ),
                  Align(
                    alignment: Alignment.center,
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height / 1.8,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 50.0,
                            ),
                            child: TabBar(
                              controller: tabController,
                              unselectedLabelColor:
                                  Colors.grey.shade500,
                              labelColor:
                                  Theme.of(context).colorScheme.onBackground,
                              tabs: const [
                                Padding(
                                  padding: EdgeInsets.all(
                                    12.0,
                                  ),
                                  child: Text(
                                    'Sign In',
                                    style: TextStyle(
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(
                                    12.0,
                                  ),
                                  child: Text(
                                    'Sign Up',
                                    style: TextStyle(
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: TabBarView(
                              controller: tabController,
                              children: [
                                BlocProvider<SignInBloc>(
                                  create: (context) => SignInBloc(context
                                      .read<AuthenticationBloc>()
                                      .userRepository),
                                  child: const SignInScreen(),
                                ),
                                BlocProvider<SignUpBloc>(
                                  create: (context) => SignUpBloc(context
                                      .read<AuthenticationBloc>()
                                      .userRepository),
                                  child: const SignUpScreen(),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
