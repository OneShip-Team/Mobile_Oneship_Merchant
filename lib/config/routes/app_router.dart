import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oneship_merchant_app/presentation/page/home/home_page.dart';
import 'package:oneship_merchant_app/presentation/page/login/login_page.dart';
import 'package:oneship_merchant_app/presentation/page/on_boarding/on_boarding_page.dart';
import 'package:oneship_merchant_app/presentation/page/welcome/welcome_page.dart';

import '../../presentation/page/register/register_page.dart';

class AppRoutes {
  static const String splash = '/splash';
  static const String welcome = '/welcome';
  static const String onBoardingPage = '/onBoardingPage';
  static const String homepage = '/homepage';
  static const String loginPage = '/loginPage';
  static const String registerpage = '/registerpage';
  static final routes = [
    GetPage(
      name: AppRoutes.welcome,
      page: () => const WelcomePage(),
    ),
    GetPage(
      name: AppRoutes.onBoardingPage,
      page: () => const OnBoardingPage(),
    ),
    // GetPage with custom transitions and bindings
    GetPage(
      name: AppRoutes.homepage,
      page: () => const HomePage(),
      transitionDuration: Duration.zero,
      transition: Transition.noTransition,
    ),
    GetPage(
      name: AppRoutes.loginPage,
      page: () => const LoginPage(),
      transitionDuration: Duration.zero,
      // transition: Transition.noTransition,
    ),

    GetPage(
        name: AppRoutes.registerpage,
        page: () => const RegisterPage(),
        transitionDuration: const Duration(milliseconds: 300),
        transition: Transition.rightToLeft,
        curve: Curves.easeOutExpo)
  ];
}