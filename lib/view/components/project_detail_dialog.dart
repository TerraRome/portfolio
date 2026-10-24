import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_portfolio/model/project_model.dart';
import 'package:flutter_portfolio/res/constants.dart';
import 'package:flutter_portfolio/res/strings.dart';
import 'package:flutter_portfolio/view%20model/responsive.dart';

import 'actions.dart';

Future<void> showProjectDetail(BuildContext context, Project project) {
  return showDialog<void>(
    context: context,
    barrierColor: context.hermes.bg.withValues(alpha: 0.74),
    builder: (_) => ProjectDetailDialog(project: project),
  );
}

/// Radius 8, surface, level-4 shadow. Closes on X, backdrop and Escape.
class ProjectDetailDialog extends StatelessWidget {
  const ProjectDetailDialog({super.key, required this.project});

  final Project project;

  @override
  Widget build(BuildContext context) {
    final h = context.hermes;
    final theme = Theme.of(context).textTheme;
    final s = context.strings;
    final compact = Responsive.isLargeMobile(context);

    return CallbackShortcuts(
      bindings: {
        const SingleActivator(LogicalKeyboardKey.escape): () =>
            Navigator.of(context).maybePop(),
      },
      child: Focus(
        autofocus: true,
        child: Dialog(
          backgroundColor: Colors.transparent,
          elevation: 0,
          insetPadding: EdgeInsets.symmetric(
            horizontal: compact ? spacingMd : spacingXl,
            vertical: spacingXl,
          ),
          child: Container(
            constraints: BoxConstraints(
              maxWidth: 720,
              maxHeight: MediaQuery.sizeOf(context).height * 0.86,
            ),
            decoration: BoxDecoration(
              color: h.surface,
              borderRadius: modalRadius,
              border: Border.all(color: h.border),
              boxShadow: h.shadow4,
            ),
            clipBehavior: Clip.antiAlias,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(
                    spacingLg,
                    spacingLg,
                    spacingSm,
                    spacingMd,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _StatusLine(status: project.status),
                            const SizedBox(height: spacingSm),
                            Text(
                              project.name,
                              style: theme.headlineMedium?.copyWith(
                                fontSize: compact ? 22 : 26,
                                color: h.fg,
                              ),
                            ),
                            const SizedBox(height: spacingXs),
                            Text(
                              [project.role.t, project.year]
                                  .where((s) => s.isNotEmpty)
                                  .join(' · '),
                              style: theme.bodySmall?.copyWith(color: h.muted),
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        tooltip: s.modalClose,
                        onPressed: () => Navigator.of(context).maybePop(),
                        icon: const Icon(Icons.close, size: 20),
                        color: h.body,
                      ),
                    ],
                  ),
                ),
                Divider(height: 1, thickness: 1, color: h.border),
                Flexible(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(spacingLg),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (project.problem.t.isNotEmpty)
                          _Block(
                            title: s.modalProblem,
                            child: _Paragraph(project.problem.t),
                          ),
                        if (project.solution.t.isNotEmpty)
                          _Block(
                            title: s.modalSolution,
                            child: _Paragraph(project.solution.t),
                          ),
                        if (project.impact.isNotEmpty)
                          _Block(
                            title: s.modalWhatIDid,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                for (final item in project.impact)
                                  _Bullet(item.t),
                              ],
                            ),
                          ),
                        if (project.gallery.isNotEmpty)
                          _Block(
                            title: s.modalScreens,
                            last: project.techStack.isEmpty,
                            child: _Gallery(shots: project.gallery),
                          ),
                        if (project.techStack.isNotEmpty)
                          _Block(
                            title: s.modalTechStack,
                            last: project.links.isEmpty,
                            child: Wrap(
                              spacing: spacingSm,
                              runSpacing: spacingSm,
                              children: [
                                for (final t in project.techStack) TechChip(t),
                              ],
                            ),
                          ),
                        if (project.links.isNotEmpty)
                          _Block(
                            title: s.modalLinks,
                            last: true,
                            child: Wrap(
                              spacing: spacingLg,
                              runSpacing: spacingSm,
                              children: [
                                for (final link in project.links)
                                  TextLink(
                                    label: link.label.t,
                                    icon: Icons.north_east,
                                    onTap: () => openUrl(link.url),
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
          ),
        ),
      ),
    );
  }
}

class _StatusLine extends StatelessWidget {
  const _StatusLine({required this.status});

  final ProjectStatus status;

  @override
  Widget build(BuildContext context) {
    final h = context.hermes;
    final color = switch (status) {
      ProjectStatus.live => h.success,
      ProjectStatus.inProgress => h.warning,
      ProjectStatus.comingSoon => h.muted,
    };
    return Row(
      children: [
        Container(
          width: 6,
          height: 6,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: spacingSm),
        Text(
          status.label.toUpperCase(),
          style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: color,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.14,
              ),
        ),
      ],
    );
  }
}

class _Block extends StatelessWidget {
  const _Block({
    required this.title,
    required this.child,
    this.last = false,
  });

  final String title;
  final Widget child;
  final bool last;

  @override
  Widget build(BuildContext context) {
    final h = context.hermes;
    return Padding(
      padding: EdgeInsets.only(bottom: last ? 0 : spacingLg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontSize: 15,
                  color: h.primaryInk,
                  letterSpacing: 0.04,
                ),
          ),
          const SizedBox(height: spacingSm),
          child,
        ],
      ),
    );
  }
}

/// Horizontal strip of phone screenshots. Tap opens one at full size.
class _Gallery extends StatelessWidget {
  const _Gallery({required this.shots});

  final List<ProjectShot> shots;

  @override
  Widget build(BuildContext context) {
    final h = context.hermes;
    final theme = Theme.of(context).textTheme;

    return SizedBox(
      height: 300,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: shots.length,
        separatorBuilder: (_, __) => const SizedBox(width: spacingMd),
        itemBuilder: (context, i) {
          final shot = shots[i];
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Semantics(
                  button: true,
                  label: shot.label.t,
                  child: InkWell(
                    onTap: () => _openFullSize(context, shot),
                    borderRadius: BorderRadius.circular(radiusButton),
                    child: Container(
                      width: 132,
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                        color: h.surfaceHover,
                        borderRadius: BorderRadius.circular(radiusButton),
                        border: Border.all(color: h.border),
                      ),
                      child: Image.asset(
                        shot.asset,
                        fit: BoxFit.cover,
                        alignment: Alignment.topCenter,
                        cacheWidth: 264,
                        errorBuilder: (_, __, ___) => const SizedBox.shrink(),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: spacingSm),
              SizedBox(
                width: 132,
                child: Text(
                  shot.label.t,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: theme.labelSmall?.copyWith(color: h.muted),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  void _openFullSize(BuildContext context, ProjectShot shot) {
    showDialog<void>(
      context: context,
      barrierColor: context.hermes.bg.withValues(alpha: 0.88),
      builder: (dialogContext) => CallbackShortcuts(
        bindings: {
          const SingleActivator(LogicalKeyboardKey.escape): () =>
              Navigator.of(dialogContext).maybePop(),
        },
        child: Focus(
          autofocus: true,
          child: Dialog(
            backgroundColor: Colors.transparent,
            elevation: 0,
            insetPadding: const EdgeInsets.all(spacingLg),
            child: GestureDetector(
              onTap: () => Navigator.of(dialogContext).maybePop(),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Flexible(
                    child: ClipRRect(
                      borderRadius: modalRadius,
                      child: Image.asset(shot.asset, fit: BoxFit.contain),
                    ),
                  ),
                  const SizedBox(height: spacingSm),
                  Text(
                    shot.label.t,
                    style: Theme.of(dialogContext)
                        .textTheme
                        .labelSmall
                        ?.copyWith(color: dialogContext.hermes.fg),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _Paragraph extends StatelessWidget {
  const _Paragraph(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    final h = context.hermes;
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: proseMaxWidth),
      child: Text(
        text,
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: h.body,
              height: 1.65,
            ),
      ),
    );
  }
}

class _Bullet extends StatelessWidget {
  const _Bullet(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    final h = context.hermes;
    return Padding(
      padding: const EdgeInsets.only(bottom: spacingSm),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 7, right: spacingSm),
            child: Container(
              width: 4,
              height: 4,
              decoration: BoxDecoration(color: h.primary, shape: BoxShape.circle),
            ),
          ),
          Expanded(
            child: Text(
              text,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: h.body,
                    height: 1.6,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
