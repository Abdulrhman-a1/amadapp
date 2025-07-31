import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:amadapp/common/routing/app_router.dart';
import 'package:amadapp/common/routing/routes.dart';
import 'package:amadapp/common/theming/app_colors.dart';

class AmadApp extends StatelessWidget {
  final AppRouter appRouter;

  const AmadApp({super.key, required this.appRouter});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          onGenerateRoute: appRouter.onGenerateRoute,
          initialRoute: Routes.onBoardinScreen,
          theme: ThemeData(scaffoldBackgroundColor: AppColors.primaryColor),
          supportedLocales: [Locale('ar'), Locale('en')],
          //introduce localiztion to app widgets, icons, and material
          localizationsDelegates: [
            GlobalCupertinoLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          //define the default lang
          locale: Locale('ar'),
        );
      },
    );
  }
}
