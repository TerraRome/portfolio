import 'package:flutter/material.dart';
import 'package:flutter_portfolio/model/profile.dart';
import 'package:flutter_portfolio/res/constants.dart';
import 'package:flutter_portfolio/res/strings.dart';
import 'package:flutter_portfolio/view/components/nav_bar.dart';
import 'package:flutter_portfolio/view/components/section_header.dart';
import 'package:flutter_portfolio/view/sections/about_section.dart';
import 'package:flutter_portfolio/view/sections/contact_section.dart';
import 'package:flutter_portfolio/view/sections/education_section.dart';
import 'package:flutter_portfolio/view/sections/experience_section.dart';
import 'package:flutter_portfolio/view/sections/hero_section.dart';
import 'package:flutter_portfolio/view/sections/projects_section.dart';
import 'package:flutter_portfolio/view/sections/skills_section.dart';

class PortfolioPage extends StatefulWidget {
  const PortfolioPage({super.key});

  @override
  State<PortfolioPage> createState() => _PortfolioPageState();
}

class _Section {
  const _Section(this.id, this.label, this.child);
  final String id;
  final String label;
  final Widget child;
}

class _PortfolioPageState extends State<PortfolioPage> {
  final ScrollController _scroll = ScrollController();
  final ValueNotifier<String> _active = ValueNotifier<String>('about');
  final Map<String, GlobalKey> _keys = <String, GlobalKey>{};

  /// Visible order, refreshed each build so scroll-spy follows the language
  /// and the hidden Experience section.
  List<String> _ids = const <String>[];

  /// Numbering comes from visible order, so a hidden Experience leaves no gap.
  List<_Section> _buildSections(AppStrings s) {
    final out = <_Section>[];
    void add(String id, String label, Widget Function(int) build) =>
        out.add(_Section(id, label, build(out.length + 1)));

    add('about', s.navAbout, (i) => AboutSection(index: i));
    add('skills', s.navSkills, (i) => SkillsSection(index: i));
    if (experienceList.isNotEmpty) {
      add('experience', s.navExperience, (i) => ExperienceSection(index: i));
    }
    add('projects', s.navProjects, (i) => ProjectsSection(index: i));
    add('education', s.navEducation, (i) => EducationSection(index: i));
    add('contact', s.navContact, (i) => ContactSection(index: i));
    return out;
  }

  @override
  void initState() {
    super.initState();
    _scroll.addListener(_syncActiveSection);
    WidgetsBinding.instance.addPostFrameCallback((_) => _syncActiveSection());
  }

  @override
  void dispose() {
    _scroll.removeListener(_syncActiveSection);
    _scroll.dispose();
    _active.dispose();
    super.dispose();
  }

  /// Scroll-spy: the last section whose top has passed under the nav wins.
  void _syncActiveSection() {
    if (!_scroll.hasClients || _ids.isEmpty) return;

    var active = _ids.first;
    for (final id in _ids) {
      final box = _keys[id]?.currentContext?.findRenderObject();
      if (box is! RenderBox || !box.hasSize) continue;
      if (box.localToGlobal(Offset.zero).dy <= navHeight + 100) active = id;
    }
    if (_scroll.position.extentAfter < 2) active = _ids.last;
    if (_active.value != active) _active.value = active;
  }

  void _jump(String id) {
    final target = _keys[id]?.currentContext;
    if (target == null) return;
    _active.value = id;
    Scrollable.ensureVisible(
      target,
      alignment: 0,
      duration: MediaQuery.disableAnimationsOf(context)
          ? Duration.zero
          : motionNormal,
      curve: Curves.easeInOut,
    );
  }

  void _toTop() {
    if (!_scroll.hasClients) return;
    _scroll.animateTo(
      0,
      duration: MediaQuery.disableAnimationsOf(context)
          ? Duration.zero
          : motionNormal,
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    final h = context.hermes;
    final s = context.strings;
    final sections = _buildSections(s);
    _ids = [for (final section in sections) section.id];

    return Scaffold(
      backgroundColor: h.bg,
      body: Column(
        children: [
          NavBar(
            items: [for (final sec in sections) NavItem(sec.id, sec.label)],
            active: _active,
            onJump: _jump,
            onHome: _toTop,
          ),
          Expanded(
            child: SingleChildScrollView(
              controller: _scroll,
              child: Column(
                children: [
                  HeroSection(onContact: () => _jump('contact')),
                  for (final section in sections) _anchor(section),
                  const SizedBox(height: spacing3xl),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _anchor(_Section section) {
    return Padding(
      key: _keys.putIfAbsent(section.id, () => GlobalKey()),
      padding: const EdgeInsets.only(top: spacing3xl + spacingSm),
      child: SectionShell(child: section.child),
    );
  }
}
