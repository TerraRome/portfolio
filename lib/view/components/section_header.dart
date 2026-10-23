import 'package:flutter/material.dart';
import 'package:flutter_portfolio/res/constants.dart';
import 'package:flutter_portfolio/view%20model/responsive.dart';

/// `01 — About`, numbered by visible order so hidden sections leave no gap.
String eyebrowLabel(int index, String label) =>
    '${index.toString().padLeft(2, '0')} — $label';

/// Eyebrow (`01 — About`) + Cinzel heading + one muted line. Left aligned.
class SectionHeader extends StatelessWidget {
  const SectionHeader({
    super.key,
    required this.eyebrow,
    required this.title,
    required this.subtitle,
  });

  final String eyebrow;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    final h = context.hermes;
    final theme = Theme.of(context).textTheme;
    final compact = Responsive.isLargeMobile(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          eyebrow.toUpperCase(),
          style: theme.labelSmall?.copyWith(
            fontWeight: FontWeight.w600,
            letterSpacing: 0.14,
            color: h.primaryInk,
          ),
        ),
        const SizedBox(height: spacingSm),
        Text(
          title,
          style: theme.headlineLarge?.copyWith(
            fontSize: compact ? 26 : 36,
            height: 1.1,
            color: h.fg,
          ),
        ),
        const SizedBox(height: spacingSm),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: proseMaxWidth),
          child: Text(
            subtitle,
            style: theme.bodyMedium?.copyWith(color: h.muted),
          ),
        ),
      ],
    );
  }
}

/// Page-wide content column: 1120 max, gutters that shrink on mobile.
class SectionShell extends StatelessWidget {
  const SectionShell({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final gutter =
        Responsive.isLargeMobile(context) ? spacingLg : spacingXl;
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: contentMaxWidth),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: gutter),
          child: SizedBox(width: double.infinity, child: child),
        ),
      ),
    );
  }
}
