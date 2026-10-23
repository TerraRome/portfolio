import 'package:flutter/material.dart';
import 'package:flutter_portfolio/res/constants.dart';
import 'package:flutter_portfolio/res/strings.dart';

import '../components/section_header.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key, required this.index});

  final int index;

  @override
  Widget build(BuildContext context) {
    final h = context.hermes;
    final s = context.strings;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeader(
          eyebrow: eyebrowLabel(index, s.aboutEyebrow),
          title: s.aboutHeading,
          subtitle: s.aboutSubtitle,
        ),
        const SizedBox(height: spacingXl),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: proseMaxWidth),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (final paragraph in s.aboutParagraphs)
                Padding(
                  padding: const EdgeInsets.only(bottom: spacingMd),
                  child: Text(
                    paragraph,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: h.body,
                          height: 1.7,
                        ),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
