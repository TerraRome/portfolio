import 'dart:ui';

import 'package:flutter/material.dart';

import '../../../model/project_model.dart';

class ProjectDetailModal extends StatelessWidget {
  final int index;

  const ProjectDetailModal({
    super.key,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    final project = projectList[index];

    return Material(
      color: Colors.transparent,
      child: Stack(
        children: [
          /// BACKDROP
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: 15,
                sigmaY: 15,
              ),
              child: Container(
                color: Colors.black.withValues(alpha: .6),
              ),
            ),
          ),

          /// MODAL
          Center(
            child: Hero(
              tag: 'project_$index',
              child: Material(
                color: Colors.transparent,
                child: Container(
                  width: 900,
                  constraints: const BoxConstraints(
                    maxHeight: 800,
                  ),
                  margin: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(32),
                    border: Border.all(
                      color: Colors.white.withValues(alpha: .1),
                    ),
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Colors.white.withValues(alpha: .08),
                        Colors.white.withValues(alpha: .03),
                      ],
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(32),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(
                        sigmaX: 25,
                        sigmaY: 25,
                      ),
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.all(32),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _Header(project: project),
                            const SizedBox(height: 32),
                            _Section(
                              title: "Overview",
                              child: Text(
                                project.summary,
                                style: _contentStyle,
                              ),
                            ),
                            const SizedBox(height: 24),
                            _Section(
                              title: "Problem",
                              child: Text(
                                project.problem,
                                style: _contentStyle,
                              ),
                            ),
                            const SizedBox(height: 24),
                            _Section(
                              title: "Solution",
                              child: Text(
                                project.solution,
                                style: _contentStyle,
                              ),
                            ),
                            const SizedBox(height: 24),
                            _Section(
                              title: "My Contributions",
                              child: Column(
                                children: project.contributions
                                    .map(
                                      (e) => _Bullet(
                                        icon: Icons.check_circle,
                                        text: e,
                                      ),
                                    )
                                    .toList(),
                              ),
                            ),
                            const SizedBox(height: 24),
                            _Section(
                              title: "Technical Challenges",
                              child: Column(
                                children: project.challenges
                                    .map(
                                      (e) => _Bullet(
                                        icon: Icons.bolt,
                                        text: e,
                                      ),
                                    )
                                    .toList(),
                              ),
                            ),
                            const SizedBox(height: 24),
                            _Section(
                              title: "Tech Stack",
                              child: Wrap(
                                spacing: 8,
                                runSpacing: 8,
                                children: project.techStack
                                    .map(
                                      (e) => _Tag(text: e),
                                    )
                                    .toList(),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

const _contentStyle = TextStyle(
  color: Colors.white70,
  height: 1.7,
  fontSize: 15,
);

class _Header extends StatelessWidget {
  final Project project;

  const _Header({
    required this.project,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                project.name,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              _Tag(
                text: project.role,
                isRole: true,
              ),
            ],
          ),
        ),
        IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            Icons.close,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}

class _Section extends StatelessWidget {
  final String title;
  final Widget child;

  const _Section({
    required this.title,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: .04),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          child,
        ],
      ),
    );
  }
}

class _Tag extends StatelessWidget {
  final String text;
  final bool isRole;

  const _Tag({
    required this.text,
    this.isRole = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 14,
        vertical: 8,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: isRole
            ? Colors.blue.withValues(alpha: .15)
            : Colors.white.withValues(alpha: .08),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }
}

class _Bullet extends StatelessWidget {
  final IconData icon;
  final String text;

  const _Bullet({
    required this.icon,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            size: 18,
            color: Colors.white70,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: _contentStyle,
            ),
          ),
        ],
      ),
    );
  }
}
