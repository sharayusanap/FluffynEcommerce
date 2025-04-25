import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import '../providers/theme_provider.dart';

class ThemeSwitch extends StatelessWidget {
  final bool inAppBar;

  const ThemeSwitch({Key? key, this.inAppBar = true}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDarkMode = themeProvider.isDarkMode;

    return GestureDetector(
      onTap: () {
        themeProvider.toggleTheme();
      },
      child: Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: isDarkMode ? Colors.grey[800] : Colors.grey[200],
          borderRadius: BorderRadius.circular(20),
        ),
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          transitionBuilder: (Widget child, Animation<double> animation) {
            return ScaleTransition(
              scale: animation,
              child: FadeTransition(opacity: animation, child: child),
            );
          },
          child:
              isDarkMode
                  ? Icon(
                    Icons.dark_mode_rounded,
                    key: const ValueKey('dark'),
                    color: inAppBar ? Colors.white : Colors.amber,
                    size: 24,
                  ).animate().scale(duration: 300.ms, curve: Curves.easeOutBack)
                  : Icon(
                    Icons.light_mode_rounded,
                    key: const ValueKey('light'),
                    color: inAppBar ? Colors.white : Colors.orange,
                    size: 24,
                  ).animate().scale(
                    duration: 300.ms,
                    curve: Curves.easeOutBack,
                  ),
        ),
      ),
    );
  }
}
