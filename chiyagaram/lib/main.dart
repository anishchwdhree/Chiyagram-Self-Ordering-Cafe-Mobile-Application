import 'package:chiyagaram/screens/auth/auth_wrapper.dart';
import 'package:chiyagaram/services/notification_service.dart';
import 'package:chiyagaram/services/notification_provider.dart';
import 'package:chiyagaram/services/connectivity_provider.dart';
import 'package:chiyagaram/screens/no_internet_screen.dart';
import 'package:chiyagaram/theme/app_theme.dart';
import 'package:chiyagaram/theme/theme_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:chiyagaram/models/cart_model.dart';
import 'package:chiyagaram/services/navigation_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Ensure Firebase is initialized before calling other Firebase services
  await Firebase.initializeApp();
  await NotificationService().init();

  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CartModel()),
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
        ChangeNotifierProvider(create: (context) => NotificationProvider()),
        ChangeNotifierProvider(create: (context) => ConnectivityProvider()),
        ChangeNotifierProvider(create: (context) => NavigationProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        final isDark = themeProvider.isDarkMode;

        SystemChrome.setSystemUIOverlayStyle(
          SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: isDark
                ? Brightness.light
                : Brightness.dark,
            systemNavigationBarColor: Colors.transparent,
            systemNavigationBarIconBrightness: isDark
                ? Brightness.light
                : Brightness.dark,
          ),
        );

        return Consumer<ConnectivityProvider>(
          builder: (context, connectivityProvider, child) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Chiya Ki Tapari',
              theme: AppTheme.lightTheme,
              darkTheme: AppTheme.darkTheme,
              themeMode: themeProvider.themeMode,
              home: const AuthWrapper(),
              builder: (context, child) {
                return Stack(
                  children: [
                    if (child != null) child,
                    if (!connectivityProvider.isOnline)
                      const NoInternetScreen(),
                  ],
                );
              },
            );
          },
        );
      },
    );
  }
}
