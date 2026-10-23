import 'package:flutter/material.dart';
import 'package:flutter_portfolio/model/profile.dart';
import 'package:flutter_portfolio/res/constants.dart';
import 'package:flutter_portfolio/res/strings.dart';

import '../components/actions.dart';
import '../components/section_header.dart';

class SkillsSection extends StatelessWidget {
  const SkillsSection({super.key, required this.index});

  final int index;

  @override
  Widget build(BuildContext context) {
    final h = context.hermes;
    final s = context.strings;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeader(
          eyebrow: eyebrowLabel(index, s.skillsEyebrow),
          title: s.skillsHeading,
          subtitle: s.skillsSubtitle,
        ),
        const SizedBox(height: spacingXl),
        for (final group in skillGroups)
          Padding(
            padding: const EdgeInsets.only(bottom: spacingLg),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  (s.skillGroupTitles[group.title] ?? group.title)
                      .toUpperCase(),
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        fontSize: 11.5,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.14,
                        color: h.muted,
                      ),
                ),
                const SizedBox(height: spacingSm + 2),
                Wrap(
                  spacing: spacingSm,
                  runSpacing: spacingSm,
                  children: [for (final skill in group.skills) TechChip(skill)],
                ),
              ],
            ),
          ),
      ],
    );
  }
}
