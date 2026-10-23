import 'package:flutter/material.dart';
import 'package:flutter_portfolio/res/constants.dart';
import 'package:url_launcher/url_launcher.dart';

/// Opens external links; empty URLs are filtered before they get here.
Future<void> openUrl(String url) async {
  if (url.isEmpty) return;
  await launchUrl(Uri.parse(url));
}

/// Quiet gold text action: "Case study →", "Credentials ↗", "Show all".
/// Real button, so keyboard activation and focus come for free.
class TextLink extends StatelessWidget {
  const TextLink({
    super.key,
    required this.label,
    required this.onTap,
    this.icon,
  });

  final String label;
  final VoidCallback onTap;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    final h = context.hermes;
    return TextButton(
      onPressed: onTap,
      style: TextButton.styleFrom(
        foregroundColor: h.primaryInk,
        minimumSize: const Size(minTapTarget, minTapTarget),
        padding: const EdgeInsets.symmetric(horizontal: spacingSm),
        overlayColor: h.primary.withValues(alpha: 0.08),
        shape: const RoundedRectangleBorder(borderRadius: buttonRadius),
        textStyle: Theme.of(context).textTheme.labelLarge?.copyWith(
              letterSpacing: 0.04,
            ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
            child: Text(label, maxLines: 1, overflow: TextOverflow.ellipsis),
          ),
          if (icon != null) ...[
            const SizedBox(width: spacingXs + 2),
            Icon(icon, size: 14),
          ],
        ],
      ),
    );
  }
}

/// Gold fill for the one primary action per view.
class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    required this.label,
    required this.onTap,
    this.icon,
  });

  final String label;
  final VoidCallback onTap;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    final h = context.hermes;
    return FilledButton(
      onPressed: onTap,
      style: FilledButton.styleFrom(
        backgroundColor: h.primary,
        foregroundColor: h.onPrimary,
        minimumSize: const Size(0, minTapTarget),
        padding: const EdgeInsets.symmetric(horizontal: spacingLg),
        shape: const RoundedRectangleBorder(borderRadius: buttonRadius),
        textStyle: Theme.of(context).textTheme.labelLarge?.copyWith(
              letterSpacing: 0.04,
            ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
            child: Text(label, maxLines: 1, overflow: TextOverflow.ellipsis),
          ),
          if (icon != null) ...[
            const SizedBox(width: spacingSm),
            Icon(icon, size: 16),
          ],
        ],
      ),
    );
  }
}

/// Hairline border, no fill. Never competes with the primary action.
class GhostButton extends StatelessWidget {
  const GhostButton({
    super.key,
    required this.label,
    required this.onTap,
    this.icon,
  });

  final String label;
  final VoidCallback onTap;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    final h = context.hermes;
    return OutlinedButton(
      onPressed: onTap,
      style: OutlinedButton.styleFrom(
        foregroundColor: h.primaryInk,
        minimumSize: const Size(0, minTapTarget),
        padding: const EdgeInsets.symmetric(horizontal: spacingLg),
        side: BorderSide(color: h.borderStrong),
        overlayColor: h.primary.withValues(alpha: 0.06),
        shape: const RoundedRectangleBorder(borderRadius: buttonRadius),
        textStyle: Theme.of(context).textTheme.labelLarge?.copyWith(
              letterSpacing: 0.04,
            ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
            child: Text(label, maxLines: 1, overflow: TextOverflow.ellipsis),
          ),
          if (icon != null) ...[
            const SizedBox(width: spacingSm),
            Icon(icon, size: 15),
          ],
        ],
      ),
    );
  }
}

/// Small non-pill tag. Not interactive.
class TechChip extends StatelessWidget {
  const TechChip(this.label, {super.key});

  final String label;

  @override
  Widget build(BuildContext context) {
    final h = context.hermes;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: h.surface,
        border: Border.all(color: h.border),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        label,
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: h.body,
              fontSize: 12.5,
              height: 1.2,
            ),
      ),
    );
  }
}
