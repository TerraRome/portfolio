import 'package:flutter/material.dart';
import 'package:flutter_portfolio/model/profile.dart';
import 'package:flutter_portfolio/res/constants.dart';
import 'package:flutter_portfolio/res/strings.dart';
import 'package:flutter_portfolio/view%20model/responsive.dart';

import '../components/actions.dart';
import '../components/section_header.dart';

class HeroSection extends StatelessWidget {
  const HeroSection({super.key, required this.onContact});

  final VoidCallback onContact;

  @override
  Widget build(BuildContext context) {
    final h = context.hermes;
    final theme = Theme.of(context).textTheme;
    final s = context.strings;
    final compact = Responsive.isLargeMobile(context);

    final copy = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          displayName,
          style: theme.displayLarge?.copyWith(
            fontSize: compact ? 36 : 56,
            height: 1.05,
            color: h.fg,
          ),
        ),
        const SizedBox(height: spacingSm + 4),
        Text(
          s.heroRole,
          style: theme.titleMedium?.copyWith(
            fontSize: compact ? 16 : 18,
            fontWeight: FontWeight.w500,
            letterSpacing: 0.02,
            color: h.primaryInk,
          ),
        ),
        const SizedBox(height: spacingMd + 4),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: proseMaxWidth),
          child: Text(
            s.heroValueProp,
            style: theme.bodyLarge?.copyWith(color: h.body, height: 1.65),
          ),
        ),
        const SizedBox(height: spacingLg + 4),
        Wrap(
          spacing: spacingSm + 4,
          runSpacing: spacingSm + 4,
          children: [
            PrimaryButton(
              label: s.heroCv,
              icon: Icons.download_outlined,
              onTap: () => openUrl(cvUrl),
            ),
            GhostButton(label: s.heroContact, onTap: onContact),
          ],
        ),
        const SizedBox(height: spacingLg + 4),
        _ProofRow(
          points: [s.proofYears, s.proofProjects, s.proofStack],
        ),
      ],
    );

    final portrait = _Portrait(size: compact ? 168 : 248);

    return Stack(
      children: [
        Positioned.fill(
          child: IgnorePointer(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  center: const Alignment(1.15, -0.9),
                  radius: 1.1,
                  colors: [
                    h.primary.withValues(alpha: 0.07),
                    h.primary.withValues(alpha: 0),
                  ],
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
            top: compact ? spacingXl : spacing3xl + spacingSm,
            bottom: compact ? spacingXl : spacing3xl,
          ),
          child: SectionShell(
            child: compact
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      copy,
                      const SizedBox(height: spacingXl),
                      Center(child: portrait),
                    ],
                  )
                : Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(flex: 3, child: copy),
                      const SizedBox(width: spacing2xl),
                      portrait,
                    ],
                  ),
          ),
        ),
      ],
    );
  }
}

class _ProofRow extends StatelessWidget {
  const _ProofRow({required this.points});

  final List<String> points;

  @override
  Widget build(BuildContext context) {
    final h = context.hermes;
    final style = Theme.of(context).textTheme.labelSmall?.copyWith(
          color: h.muted,
          letterSpacing: 0.06,
        );

    return Wrap(
      spacing: spacingSm + 2,
      runSpacing: spacingSm,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        for (var i = 0; i < points.length; i++) ...[
          if (i > 0) Text('·', style: style?.copyWith(color: h.primaryInk)),
          Text(points[i], style: style),
        ],
      ],
    );
  }
}

/// Gold ring + portrait. Float stops when the OS asks for reduced motion.
class _Portrait extends StatefulWidget {
  const _Portrait({required this.size});

  final double size;

  @override
  State<_Portrait> createState() => _PortraitState();
}

class _PortraitState extends State<_Portrait>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 4),
  );
  late final Animation<double> _offset = Tween<double>(begin: -6, end: 6)
      .animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (MediaQuery.disableAnimationsOf(context)) {
      _controller.stop();
      _controller.value = 0.5;
    } else if (!_controller.isAnimating) {
      _controller.repeat(reverse: true);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final h = context.hermes;
    final size = widget.size;

    return AnimatedBuilder(
      animation: _offset,
      builder: (context, child) => Transform.translate(
        offset: Offset(0, _offset.value),
        child: child,
      ),
      child: Container(
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: h.primary.withValues(alpha: 0.55)),
          boxShadow: h.halo,
        ),
        child: ClipOval(
          child: Image.asset(
            'assets/images/profile.png',
            width: size,
            height: size,
            fit: BoxFit.cover,
            cacheWidth: (size * 3).round(),
            errorBuilder: (_, __, ___) => Container(
              width: size,
              height: size,
              color: h.surfaceHover,
              alignment: Alignment.center,
              child: Text(
                'TA',
                style: Theme.of(context).textTheme.displaySmall?.copyWith(
                      color: h.primaryInk,
                    ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
