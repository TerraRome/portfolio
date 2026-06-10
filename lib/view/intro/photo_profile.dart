import 'package:flutter/material.dart';

import '../../../res/constants.dart';
import '../../../view model/responsive.dart';

class AnimatedProfileCircle extends StatefulWidget {
  const AnimatedProfileCircle({
    super.key,
    this.size,
  });

  final double? size;

  @override
  State<AnimatedProfileCircle> createState() => _AnimatedProfileCircleState();
}

class _AnimatedProfileCircleState extends State<AnimatedProfileCircle>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  double _getSize(BuildContext context) {
    if (widget.size != null) return widget.size!;

    if (Responsive.isExtraLargeScreen(context)) {
      return 420;
    }

    if (Responsive.isDesktop(context)) {
      return 360;
    }

    if (Responsive.isTablet(context)) {
      return 300;
    }

    if (Responsive.isLargeMobile(context)) {
      return 240;
    }

    return 200;
  }

  @override
  Widget build(BuildContext context) {
    final size = _getSize(context);

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(
            0,
            (_controller.value - 0.5) * 10,
          ),
          child: Container(
            width: size,
            height: size,
            padding: const EdgeInsets.all(defaultPadding / 4),
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [
                  Colors.pinkAccent,
                  Colors.blue,
                ],
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.pinkAccent,
                  blurRadius: 30,
                  spreadRadius: 2,
                ),
                BoxShadow(
                  color: Colors.blue,
                  blurRadius: 30,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: Container(
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.black,
              ),
              child: ClipOval(
                child: Image.asset(
                  'assets/images/profile.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
