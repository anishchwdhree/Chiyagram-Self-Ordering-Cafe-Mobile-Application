import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:chiyagaram/theme/theme_provider.dart';
import 'package:chiyagaram/theme/app_colors.dart';

class BackgroundScaffold extends StatelessWidget {
  final Widget body;
  final PreferredSizeWidget? appBar;
  final Widget? bottomNavigationBar;
  final Widget? floatingActionButton;
  final bool extendBody;
  final bool extendBodyBehindAppBar;

  const BackgroundScaffold({
    super.key,
    required this.body,
    this.appBar,
    this.bottomNavigationBar,
    this.floatingActionButton,
    this.extendBody = false,
    this.extendBodyBehindAppBar = false,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, _) {
        final isDark = themeProvider.isDarkMode;
        return Scaffold(
          extendBody: extendBody,
          extendBodyBehindAppBar: extendBodyBehindAppBar,
          appBar: appBar,
          bottomNavigationBar: bottomNavigationBar,
          floatingActionButton: floatingActionButton,
          backgroundColor: Colors.transparent,
          body: Stack(
            children: [
              // Background Gradient
              RepaintBoundary(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: AppColors.getBackgroundGradient(isDark),
                    ),
                  ),
                  child: const SizedBox.expand(),
                ),
              ),
              // Body
              body,
            ],
          ),
        );
      },
    );
  }
}
