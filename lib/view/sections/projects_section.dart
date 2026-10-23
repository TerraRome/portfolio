import 'package:flutter/material.dart';
import 'package:flutter_portfolio/model/project_model.dart';
import 'package:flutter_portfolio/res/constants.dart';
import 'package:flutter_portfolio/res/strings.dart';

import '../components/actions.dart';
import '../components/project_card.dart';
import '../components/project_detail_dialog.dart';
import '../components/section_header.dart';

/// First four of `sortedProjects` are featured; the rest sit behind a toggle.
class ProjectsSection extends StatefulWidget {
  const ProjectsSection({super.key, required this.index});

  final int index;

  @override
  State<ProjectsSection> createState() => _ProjectsSectionState();
}

class _ProjectsSectionState extends State<ProjectsSection> {
  static const int featuredCount = 4;
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    final s = context.strings;
    final all = sortedProjects(projectList);
    final visible =
        _expanded ? all : all.take(featuredCount).toList(growable: false);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeader(
          eyebrow: eyebrowLabel(widget.index, s.projectsEyebrow),
          title: s.projectsHeading,
          subtitle: s.projectsSubtitle,
        ),
        const SizedBox(height: spacingXl),
        LayoutBuilder(
          builder: (context, constraints) {
            final columns = constraints.maxWidth >= 700 ? 2 : 1;
            const gap = spacingLg;
            final cardWidth =
                (constraints.maxWidth - gap * (columns - 1)) / columns;

            return Wrap(
              spacing: gap,
              runSpacing: gap,
              children: [
                for (final project in visible)
                  SizedBox(
                    width: cardWidth,
                    child: ProjectCard(
                      project: project,
                      width: cardWidth,
                      onOpen: () => showProjectDetail(context, project),
                    ),
                  ),
              ],
            );
          },
        ),
        if (all.length > featuredCount) ...[
          const SizedBox(height: spacingMd),
          TextLink(
            label: _expanded ? s.showFeatured : s.showAllProjects(all.length),
            icon: _expanded ? Icons.expand_less : Icons.expand_more,
            onTap: () => setState(() => _expanded = !_expanded),
          ),
        ],
      ],
    );
  }
}
