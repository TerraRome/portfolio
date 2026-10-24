import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_portfolio/model/project_model.dart';
import 'package:flutter_portfolio/res/constants.dart';
import 'package:flutter_portfolio/res/strings.dart';

import 'actions.dart';

/// Fixed 16:9 media + fixed body height, so every card in a row is identical
/// with or without a screenshot. `width` is supplied by the grid.
class ProjectCard extends StatefulWidget {
  const ProjectCard({
    super.key,
    required this.project,
    required this.width,
    required this.onOpen,
  });

  final Project project;
  final double width;
  final VoidCallback onOpen;

  /// Tall enough for 2-line name + 2-line summary + one action row.
  static const double bodyHeight = 264;

  @override
  State<ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<ProjectCard> {
  bool _hovered = false;
  bool _focused = false;

  @override
  Widget build(BuildContext context) {
    final h = context.hermes;
    final p = widget.project;
    final mediaHeight = widget.width * 9 / 16;

    return Semantics(
      button: true,
      label: '${p.name}. ${p.status.label}. ${p.summary.t}',
      onTap: widget.onOpen,
      child: FocusableActionDetector(
        mouseCursor: SystemMouseCursors.click,
        onShowHoverHighlight: (v) {
          if (v != _hovered) setState(() => _hovered = v);
        },
        onShowFocusHighlight: (v) {
          if (v != _focused) setState(() => _focused = v);
        },
        shortcuts: const {
          SingleActivator(LogicalKeyboardKey.enter): ActivateIntent(),
          SingleActivator(LogicalKeyboardKey.space): ActivateIntent(),
        },
        actions: {
          ActivateIntent: CallbackAction<ActivateIntent>(
            onInvoke: (_) {
              widget.onOpen();
              return null;
            },
          ),
        },
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: widget.onOpen,
          child: AnimatedContainer(
            duration: MediaQuery.disableAnimationsOf(context)
                ? Duration.zero
                : motionFast,
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              color: h.surface,
              borderRadius: modalRadius,
              border: Border.all(
                color: _hovered ? h.borderStrong : h.border,
              ),
            ),
            foregroundDecoration: _focused
                ? BoxDecoration(
                    borderRadius: modalRadius,
                    border: Border.all(color: h.primaryInk, width: 2),
                  )
                : null,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
                  height: mediaHeight,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      _media(context, p, mediaHeight),
                      Positioned(
                        left: spacingMd,
                        top: spacingMd,
                        child: _StatusBadge(status: p.status),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: ProjectCard.bodyHeight,
                  child: Padding(
                    padding: const EdgeInsets.all(spacingMd),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 46,
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              p.name,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge
                                  ?.copyWith(fontSize: 20, color: h.fg),
                            ),
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          [p.role.t, p.year]
                              .where((s) => s.isNotEmpty)
                              .join(' · '),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.copyWith(color: h.muted),
                        ),
                        const SizedBox(height: spacingSm + 2),
                        SizedBox(
                          height: 42,
                          child: Text(
                            p.summary.t,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.copyWith(color: h.body, height: 1.55),
                          ),
                        ),
                        const SizedBox(height: spacingSm),
                        SizedBox(
                          height: 28,
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            physics: const NeverScrollableScrollPhysics(),
                            child: Row(
                              children: [
                                for (final t in p.techStack.take(3))
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      right: spacingSm,
                                    ),
                                    child: TechChip(t),
                                  ),
                              ],
                            ),
                          ),
                        ),
                        const Spacer(),
                        // One row, always: two stacked 44px buttons would push
                        // past the fixed body height at 375.
                        Row(
                          children: [
                            Flexible(
                              child: TextLink(
                                label: context.strings.caseStudy,
                                icon: Icons.arrow_forward,
                                onTap: widget.onOpen,
                              ),
                            ),
                            for (final link in p.links)
                              Flexible(
                                child: TextLink(
                                  label: link.label.t,
                                  icon: Icons.north_east,
                                  onTap: () => openUrl(link.url),
                                ),
                              ),
                          ],
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

  /// Image if it exists, snippet if it was written, designed panel otherwise.
  /// Never a broken-image icon, never an empty box.
  Widget _media(BuildContext context, Project p, double height) {
    if (p.image != null) {
      // `contain` so a wide banner is never cropped; 16:9 screenshots fill the
      // slot exactly. The Volta banner is authored with a transparent
      // background, so the backing colour decides how it sits in the card.
      return ColoredBox(
        color: Colors.white,
        child: Image.asset(
          p.image!,
          fit: BoxFit.contain,
          cacheWidth: (widget.width * 2).round(),
          errorBuilder: (_, __, ___) => _FallbackPanel(project: p),
        ),
      );
    }
    if (p.preview != null) return _PreviewPanel(preview: p.preview!);
    return _FallbackPanel(project: p, height: height);
  }
}

class _StatusBadge extends StatelessWidget {
  const _StatusBadge({required this.status});

  final ProjectStatus status;

  @override
  Widget build(BuildContext context) {
    final h = context.hermes;
    final color = switch (status) {
      ProjectStatus.live => h.success,
      ProjectStatus.inProgress => h.warning,
      ProjectStatus.comingSoon => h.muted,
    };

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: spacingSm, vertical: 3),
      decoration: BoxDecoration(
        // Opaque blend of surface + 8% status, so badge text keeps its measured
        // contrast even when it sits over a photograph.
        color: Color.alphaBlend(color.withValues(alpha: 0.08), h.surface),
        border: Border.all(color: color.withValues(alpha: 0.45)),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        status.label.toUpperCase(),
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
              fontSize: 10.5,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.08,
              color: color,
              height: 1.3,
            ),
      ),
    );
  }
}

/// Gradient + first tech as a monogram + project name. Deliberate, not empty.
class _FallbackPanel extends StatelessWidget {
  const _FallbackPanel({required this.project, this.height});

  final Project project;
  final double? height;

  @override
  Widget build(BuildContext context) {
    final h = context.hermes;
    return Container(
      height: height,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [h.surface, h.surfaceHover],
        ),
      ),
      child: Stack(
        children: [
          Positioned.fill(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: spacingMd),
                child: Text(
                  project.techStack.isEmpty ? project.name : project.techStack.first,
                  maxLines: 1,
                  overflow: TextOverflow.clip,
                  style: Theme.of(context).textTheme.displaySmall?.copyWith(
                        color: h.primaryInk.withValues(alpha: 0.85),
                        fontSize: 34,
                        letterSpacing: 0.08,
                      ),
                ),
              ),
            ),
          ),
          Positioned(
            left: spacingMd,
            right: spacingMd,
            bottom: 14,
            child: Text(
              project.name.toUpperCase(),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: h.muted,
                    letterSpacing: 0.14,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Hand-tinted, no highlighting package. Clips instead of overflowing.
class _PreviewPanel extends StatelessWidget {
  const _PreviewPanel({required this.preview});

  final ProjectPreview preview;

  @override
  Widget build(BuildContext context) {
    final h = context.hermes;
    final lines = preview.code.split('\n').take(10).join('\n');

    return ColoredBox(
      color: h.surface,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(spacingMd, spacingMd, spacingSm, 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              preview.caption.t,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    fontSize: 11,
                    color: h.muted,
                  ),
            ),
            const SizedBox(height: spacingSm),
            Expanded(
              child: ClipRect(
                child: SingleChildScrollView(
                  physics: const NeverScrollableScrollPhysics(),
                  child: Text(
                    lines,
                    softWrap: false,
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 11,
                      height: 1.5,
                      color: h.body,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
