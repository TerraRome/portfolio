import 'package:flutter/material.dart';
import 'package:flutter_portfolio/model/certificate_model.dart';
import 'package:flutter_portfolio/model/profile.dart';
import 'package:flutter_portfolio/res/constants.dart';
import 'package:flutter_portfolio/res/strings.dart';
import 'package:flutter_portfolio/view%20model/responsive.dart';

import '../components/actions.dart';
import '../components/section_header.dart';

/// Scannable rows, not a grid: title, org, date, skills, credential link.
class EducationSection extends StatelessWidget {
  const EducationSection({super.key, required this.index});

  final int index;

  @override
  Widget build(BuildContext context) {
    final h = context.hermes;
    final s = context.strings;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeader(
          eyebrow: eyebrowLabel(index, s.educationEyebrow),
          title: s.educationHeading,
          subtitle: s.educationSubtitle,
        ),
        const SizedBox(height: spacingLg),
        for (final entry in educationList) ...[
          _EducationRow(entry: entry),
          Divider(height: 1, thickness: 1, color: h.border),
        ],
        for (final certificate in certificateList) ...[
          _CertificateRow(certificate: certificate),
          Divider(height: 1, thickness: 1, color: h.border),
        ],
      ],
    );
  }
}

class _EducationRow extends StatelessWidget {
  const _EducationRow({required this.entry});

  final Education entry;

  @override
  Widget build(BuildContext context) {
    final h = context.hermes;
    final theme = Theme.of(context).textTheme;
    final compact = Responsive.isLargeMobile(context);

    final title = Text(
      entry.school,
      style: theme.titleLarge?.copyWith(fontSize: 18, color: h.fg),
    );
    final degree = Padding(
      padding: const EdgeInsets.only(top: 3),
      child: Text(
        entry.degree,
        style: theme.bodySmall?.copyWith(color: h.copperInk),
      ),
    );
    final note = entry.note.isEmpty
        ? const SizedBox.shrink()
        : Padding(
            padding: const EdgeInsets.only(top: 3),
            child: Text(
              entry.note,
              style: theme.bodySmall?.copyWith(color: h.muted),
            ),
          );
    final period = Text(
      entry.period,
      style: theme.labelSmall?.copyWith(letterSpacing: 0.12, color: h.muted),
    );

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: spacingMd),
      child: compact
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(child: title),
                    const SizedBox(width: spacingMd),
                    period,
                  ],
                ),
                degree,
                note,
              ],
            )
          : Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [title, degree, note],
                  ),
                ),
                const SizedBox(width: spacingLg),
                period,
              ],
            ),
    );
  }
}

class _CertificateRow extends StatelessWidget {
  const _CertificateRow({required this.certificate});

  final CertificateModel certificate;

  @override
  Widget build(BuildContext context) {
    final h = context.hermes;
    final theme = Theme.of(context).textTheme;
    final compact = Responsive.isLargeMobile(context);

    final title = Text(
      certificate.name,
      style: theme.titleLarge?.copyWith(fontSize: 18, color: h.fg),
    );
    final org = Padding(
      padding: const EdgeInsets.only(top: 3),
      child: Text(
        certificate.organization,
        style: theme.bodySmall?.copyWith(color: h.copperInk),
      ),
    );
    final skills = Padding(
      padding: const EdgeInsets.only(top: 3),
      child: Text(
        certificate.skills,
        style: theme.bodySmall?.copyWith(color: h.muted),
      ),
    );
    final date = Text(
      certificate.date,
      style: theme.labelSmall?.copyWith(
        letterSpacing: 0.12,
        color: h.muted,
      ),
    );
    final credential = TextLink(
      label: context.strings.credentials,
      icon: Icons.north_east,
      onTap: () => openUrl(certificate.credential),
    );

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: spacingMd),
      child: compact
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(child: title),
                    const SizedBox(width: spacingMd),
                    date,
                  ],
                ),
                org,
                skills,
                Align(alignment: Alignment.centerLeft, child: credential),
              ],
            )
          : Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [title, org, skills],
                  ),
                ),
                const SizedBox(width: spacingLg),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [date, credential],
                ),
              ],
            ),
    );
  }
}
