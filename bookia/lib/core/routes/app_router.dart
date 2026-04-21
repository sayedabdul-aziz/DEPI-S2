import 'package:bookia/core/routes/routes.dart';
import 'package:bookia/feature/auth/presentation/cubit/auth_cubit.dart';
import 'package:bookia/feature/auth/presentation/forget_password/page/forgot_password_screen.dart';
import 'package:bookia/feature/auth/presentation/login_register/page/login_screen.dart';
import 'package:bookia/feature/auth/presentation/login_register/page/register_screen.dart';
import 'package:bookia/feature/details/page/details_screen.dart';
import 'package:bookia/feature/home/data/model/best_seller_response/product.dart';
import 'package:bookia/feature/main/main_app_screen.dart';
import 'package:bookia/feature/splash/cubit/splash_cubit.dart';
import 'package:bookia/feature/splash/page/splash_screen.dart';
import 'package:bookia/feature/welcome/welcome_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

// Person p = Person();
// p.name="mohamed";
// p.display();
// Person p = Person()..name="mohamed"...display();

class AppRouter {
  static final routes = GoRouter(
    routes: [
      GoRoute(
        path: Routes.splash,
        builder: (context, state) => BlocProvider(
          create: (context) {
            // return SplashCubit()..getInitData();
            var cubit = SplashCubit();
            cubit.getInitData();
            return cubit;
          },
          child: const SplashScreen(),
        ),
      ),
      GoRoute(
        path: Routes.welcome,
        builder: (context, state) => const WelcomeScreen(),
      ),
      GoRoute(
        path: Routes.login,
        builder: (context, state) => BlocProvider(
          create: (context) => AuthCubit(),
          child: const LoginScreen(),
        ),
      ),
      GoRoute(
        path: Routes.register,
        builder: (context, state) => BlocProvider(
          create: (context) => AuthCubit(),
          child: const RegisterScreen(),
        ),
      ),
      GoRoute(
        path: Routes.forgotPassword,
        builder: (context, state) {
          return ForgotPasswordScreen(email: state.extra as String);
        },
      ),
      GoRoute(
        path: Routes.main,
        builder: (context, state) {
          return MainAppScreen();
        },
      ),
      GoRoute(
        path: Routes.details,
        builder: (context, state) {
          return DetailsScreen(model: state.extra as Product,);
        },
      ),
    ],
  );
}
