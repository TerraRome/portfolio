import 'package:flutter/material.dart';
import 'package:flutter_portfolio/model/profile.dart';
import 'package:flutter_portfolio/res/constants.dart';
import 'package:flutter_portfolio/res/strings.dart';

import '../components/actions.dart';
import '../components/section_header.dart';

/// Contact rows + footer. Only rows with real data are rendered.
class ContactSection extends StatelessWidget {
  const ContactSection({super.key, required this.index});

  final int index;

  @override
  Widget build(BuildContext context) {
    final h = context.hermes;
    final s = context.strings;
    final links = contactLinks.where((l) => l.url.isNotEmpty).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeader(
          eyebrow: eyebrowLabel(index, s.contactEyebrow),
          title: s.contactHeading,
          subtitle: s.contactSubtitle,
        ),
        const SizedBox(height: spacingLg),
        if (email.isNotEmpty) ...[
          _ContactRow(
            label: s.emailLabel,
            detail: email,
            onTap: () => openUrl('mailto:$email'),
          ),
          Divider(height: 1, thickness: 1, color: h.border),
        ],
        for (final link in links) ...[
          _ContactRow(
            label: link.label,
            detail: Uri.parse(link.url).host,
            onTap: () => openUrl(link.url),
          ),
          Divider(height: 1, thickness: 1, color: h.border),
        ],
        _ContactRow(
          label: s.navCv,
          detail: 'PDF',
          onTap: () => openUrl(cvUrl),
        ),
        Divider(height: 1, thickness: 1, color: h.border),
        const SizedBox(height: spacingLg),
        Text(
          '© ${DateTime.now().year} $displayName · ${s.footerNote}',
          style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: h.muted,
                letterSpacing: 0.04,
              ),
        ),
      ],
    );
  }
}

class _ContactRow extends StatelessWidget {
  const _ContactRow({required this.label, required this.onTap, this.detail});

  final String label;
  final String? detail;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final h = context.hermes;
    final theme = Theme.of(context).textTheme;

    return TextButton(
      onPressed: onTap,
      style: TextButton.styleFrom(
        alignment: Alignment.centerLeft,
        minimumSize: const Size(double.infinity, 56),
        padding: const EdgeInsets.symmetric(horizontal: spacingXs),
        foregroundColor: h.fg,
        overlayColor: h.primary.withValues(alpha: 0.06),
        shape: const RoundedRectangleBorder(borderRadius: buttonRadius),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: theme.titleMedium?.copyWith(color: h.fg),
            ),
          ),
          if (detail != null)
            Flexible(
              child: Text(
                detail!,
                textAlign: TextAlign.right,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: theme.bodySmall?.copyWith(color: h.muted),
              ),
            ),
          const SizedBox(width: spacingSm),
          Icon(Icons.north_east, size: 16, color: h.primaryInk),
        ],
      ),
    );
  }
}
