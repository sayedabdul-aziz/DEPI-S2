import 'dart:io';

import 'package:bookia/core/routes/app_router.dart';
import 'package:bookia/core/styles/themes.dart';
import 'package:chili_debug_view/chili_debug_view.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: AppRouter.routes,
      debugShowCheckedModeBanner: false,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      theme: AppThemes.lightTheme,
      builder: (context, child) {
        return DebugView(
          navigatorKey: navigatorKey,
          showDebugViewButton: true,
          app: MediaQuery(
            data: MediaQuery.of(
              context,
            ).copyWith(textScaler: TextScaler.linear(1.0)),
            child: SafeArea(
              top: false,
              bottom: Platform.isAndroid,
              child: child!,
            ),
          ),
        );
      },
    );
  }
}

// backend services
// 1) Firebase => No Sql => Collections(Documents) => unmanaged
// 2) Supabase => Sql ==> Tables(Rows) => Managed. => ERD

// User => Wishlist => Checkout

// 50k request read / day , 1 G download

// Backend => Auth, Database and Storage (cloudinary)

// MVP => Low Budget + Low Effort + Low Risk
// Business Model (Functionalities , Storage , Users) == More Requests / 10 G downloads

// Byte+ (Supabase) ===> (Migration) Backend 20$

// SQL (Language) => DB (Storage) (My Sql/ SqlServer/ Oracle)

// Backend Frameworks
// ASP.NET => Sql Server DB
// Laravel => MySql DB
// Java Spring => MySql DB/ Oracle / Mongo DB

// 70k = flag(Remote Config(isUpdated), "3.4.5")

// SQL VS NOSQL , ERD (PK,FK)



// Flavor (Staging/ Production)


// Deployment to Play Store
// App Name, Logo
// Signing Key (keystore)
// build appBundle