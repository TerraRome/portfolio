import 'package:flutter/material.dart';
import 'package:flutter_portfolio/model/profile.dart';
import 'package:flutter_portfolio/res/constants.dart';
import 'package:flutter_portfolio/res/strings.dart';

import '../components/section_header.dart';

/// Hidden entirely while [experienceList] is empty. Filling the list is the
/// only step needed — no other change.
class ExperienceSection extends StatelessWidget {
  const ExperienceSection({super.key, required this.index});

  final int index;

  @override
  Widget build(BuildContext context) {
    if (experienceList.isEmpty) return const SizedBox.shrink();
    final h = context.hermes;
    final s = context.strings;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeader(
          eyebrow: eyebrowLabel(index, s.experienceEyebrow),
          title: s.experienceHeading,
          subtitle: s.experienceSubtitle,
        ),
        const SizedBox(height: spacingXl),
        for (var i = 0; i < experienceList.length; i++)
          _TimelineEntry(
            entry: experienceList[i],
            isLast: i == experienceList.length - 1,
            lineColor: h.border,
          ),
      ],
    );
  }
}

class _TimelineEntry extends StatelessWidget {
  const _TimelineEntry({
    required this.entry,
    required this.isLast,
    required this.lineColor,
  });

  final Experience entry;
  final bool isLast;
  final Color lineColor;

  @override
  Widget build(BuildContext context) {
    final h = context.hermes;
    final theme = Theme.of(context).textTheme;

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            width: 24,
            child: Column(
              children: [
                const SizedBox(height: 6),
                Container(
                  width: 9,
                  height: 9,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: h.primary, width: 1.5),
                  ),
                ),
                if (!isLast)
                  Expanded(
                    child: Container(width: 1, color: lineColor),
                  ),
              ],
            ),
          ),
          const SizedBox(width: spacingMd),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(bottom: isLast ? 0 : spacingXl),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    entry.period.t.toUpperCase(),
                    style: theme.labelSmall?.copyWith(
                      letterSpacing: 0.14,
                      color: h.muted,
                    ),
                  ),
                  const SizedBox(height: spacingXs),
                  Text(
                    entry.position.t,
                    style: theme.titleLarge?.copyWith(
                      fontSize: 20,
                      color: h.fg,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    entry.company,
                    style: theme.bodySmall?.copyWith(color: h.copperInk),
                  ),
                  const SizedBox(height: spacingSm + 2),
                  for (final bullet in entry.bullets)
                    Padding(
                      padding: const EdgeInsets.only(bottom: spacingSm),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 8, right: 10),
                            child: Container(
                              width: 4,
                              height: 4,
                              decoration: BoxDecoration(
                                color: h.primary,
                                shape: BoxShape.circle,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              bullet.t,
                              style: theme.bodyMedium?.copyWith(
                                color: h.body,
                                height: 1.6,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
