import 'package:flutter/material.dart';
import 'package:lcpl_admin/theme/theme.dart';

class MulticolorProgressIndicator extends StatefulWidget {
  const MulticolorProgressIndicator({super.key});

  @override
  State<MulticolorProgressIndicator> createState() =>
      _MulticolorProgressIndicatorState();
}

class _MulticolorProgressIndicatorState
    extends State<MulticolorProgressIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Color?> _colorTween;
  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat();

    _colorTween = _controller.drive(
      TweenSequence([
        TweenSequenceItem(
          tween:
              ColorTween(begin: AppTheme.greenColor, end: AppTheme.blueColor),
          weight: 1,
        ),
        TweenSequenceItem(
          tween: ColorTween(
              begin: AppTheme.blueColor, end: AppTheme.redColor),
          weight: 1,
        ),
        TweenSequenceItem(
          tween: ColorTween(
              begin: AppTheme.redColor, end: AppTheme.greenColor),
          weight: 1,
        ),
      ]),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return CircularProgressIndicator(
          valueColor: _colorTween,
        );
      },
    );
  }
}
