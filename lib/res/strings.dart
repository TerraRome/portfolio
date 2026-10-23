import 'package:flutter/widgets.dart';

/// UI copy only — no intl package, no codegen. Project and certificate data
/// stay in English because it is technical content.
class AppStrings {
  const AppStrings({
    required this.code,
    required this.navAbout,
    required this.navSkills,
    required this.navExperience,
    required this.navProjects,
    required this.navEducation,
    required this.navContact,
    required this.navCv,
    required this.menuTooltip,
    required this.heroRole,
    required this.heroValueProp,
    required this.heroCv,
    required this.heroContact,
    required this.proofYears,
    required this.proofProjects,
    required this.proofStack,
    required this.aboutEyebrow,
    required this.aboutHeading,
    required this.aboutSubtitle,
    required this.aboutParagraphs,
    required this.skillsEyebrow,
    required this.skillsHeading,
    required this.skillsSubtitle,
    required this.skillGroupTitles,
    required this.experienceEyebrow,
    required this.experienceHeading,
    required this.experienceSubtitle,
    required this.projectsEyebrow,
    required this.projectsHeading,
    required this.projectsSubtitle,
    required this.caseStudy,
    required this.showAll,
    required this.showFeatured,
    required this.educationEyebrow,
    required this.educationHeading,
    required this.educationSubtitle,
    required this.credentials,
    required this.contactEyebrow,
    required this.contactHeading,
    required this.contactSubtitle,
    required this.emailLabel,
    required this.footerNote,
    required this.themeLight,
    required this.themeDark,
    required this.modalProblem,
    required this.modalSolution,
    required this.modalWhatIDid,
    required this.modalTechStack,
    required this.modalScreens,
    required this.modalLinks,
    required this.modalClose,
  });

  /// Locale tag shown in the nav toggle: EN / ID.
  final String code;

  final String navAbout;
  final String navSkills;
  final String navExperience;
  final String navProjects;
  final String navEducation;
  final String navContact;
  final String navCv;
  final String menuTooltip;

  final String heroRole;
  final String heroValueProp;
  final String heroCv;
  final String heroContact;
  final String proofYears;
  final String proofProjects;
  final String proofStack;

  final String aboutEyebrow;
  final String aboutHeading;
  final String aboutSubtitle;
  final List<String> aboutParagraphs;

  final String skillsEyebrow;
  final String skillsHeading;
  final String skillsSubtitle;

  /// Keyed by the English group title in `skillGroups`.
  final Map<String, String> skillGroupTitles;

  final String experienceEyebrow;
  final String experienceHeading;
  final String experienceSubtitle;

  final String projectsEyebrow;
  final String projectsHeading;
  final String projectsSubtitle;
  final String caseStudy;

  /// `{n}` is replaced with the project count.
  final String showAll;
  final String showFeatured;

  final String educationEyebrow;
  final String educationHeading;
  final String educationSubtitle;
  final String credentials;

  final String contactEyebrow;
  final String contactHeading;
  final String contactSubtitle;
  final String emailLabel;
  final String footerNote;
  final String themeLight;
  final String themeDark;
  final String modalProblem;
  final String modalSolution;
  final String modalWhatIDid;
  final String modalTechStack;
  final String modalScreens;
  final String modalLinks;
  final String modalClose;

  String showAllProjects(int count) => showAll.replaceFirst('{n}', '$count');
}

const AppStrings en = AppStrings(
  code: 'EN',
  navAbout: 'About',
  navSkills: 'Skills',
  navExperience: 'Experience',
  navProjects: 'Projects',
  navEducation: 'Education',
  navContact: 'Contact',
  navCv: 'Download CV',
  menuTooltip: 'Sections',
  heroRole: 'Flutter & Mobile Engineer',
  heroValueProp:
      'I build offline-first Flutter apps for payments and mobility — four-plus '
      'years shipping products that keep working when the network does not.',
  heroCv: 'Download CV',
  heroContact: 'Contact Me',
  proofYears: '4+ yrs Flutter',
  proofProjects: '8 projects',
  proofStack: 'Flutter · BLoC · Firebase',
  aboutEyebrow: 'About',
  aboutHeading: 'Shipping mobile since 2019.',
  aboutSubtitle: 'What I do, and how I work.',
  aboutParagraphs: [
    'I am a mobile engineer with more than four years of production Flutter '
        'experience, mostly on products where a failed transaction costs someone '
        'real money.',
    'Recent work is electric mobility: battery swaps, rentals and payments, '
        'built to stay usable on weak or missing connectivity.',
    'I care about structure that survives a team — clear layers, testable '
        'state, and boring decisions that do not need a rewrite next year.',
    'I work closely with backend and product, and I ship.',
  ],
  skillsEyebrow: 'Skills',
  skillsHeading: 'Tools I reach for.',
  skillsSubtitle: 'Grouped by where they sit in the stack.',
  skillGroupTitles: {
    'Mobile': 'Mobile',
    'Backend & Data': 'Backend & Data',
    'Tooling': 'Tooling',
  },
  experienceEyebrow: 'Experience',
  experienceHeading: 'Where I have worked.',
  experienceSubtitle: 'Roles, scope and outcomes.',
  projectsEyebrow: 'Featured Projects',
  projectsHeading: 'Selected work.',
  projectsSubtitle: 'Shipped products, mostly mobility and payments.',
  caseStudy: 'Case study',
  showAll: 'Show all {n} projects',
  showFeatured: 'Show featured only',
  educationEyebrow: 'Education & Certifications',
  educationHeading: 'Credentials.',
  educationSubtitle: 'Courses and certifications, each with a public record.',
  credentials: 'Credentials',
  contactEyebrow: 'Contact',
  contactHeading: 'Let us talk.',
  contactSubtitle: 'Open to Flutter and mobile engineering roles.',
  emailLabel: 'Email',
  footerNote: 'Built with Flutter.',
  themeLight: 'Switch to light theme',
  themeDark: 'Switch to dark theme',
  modalProblem: 'Problem',
  modalSolution: 'Solution',
  modalWhatIDid: 'What I did',
  modalTechStack: 'Tech stack',
  modalScreens: 'Screens',
  modalLinks: 'Links',
  modalClose: 'Close',
);

const AppStrings id = AppStrings(
  code: 'ID',
  navAbout: 'Tentang',
  navSkills: 'Keahlian',
  navExperience: 'Pengalaman',
  navProjects: 'Proyek',
  navEducation: 'Pendidikan',
  navContact: 'Kontak',
  navCv: 'Unduh CV',
  menuTooltip: 'Bagian',
  heroRole: 'Engineer Flutter & Mobile',
  heroValueProp:
      'Saya membangun aplikasi Flutter offline-first untuk pembayaran dan '
      'mobilitas — lebih dari empat tahun mengirim produk yang tetap berjalan '
      'saat jaringan bermasalah.',
  heroCv: 'Unduh CV',
  heroContact: 'Hubungi Saya',
  proofYears: '4+ thn Flutter',
  proofProjects: '8 proyek',
  proofStack: 'Flutter · BLoC · Firebase',
  aboutEyebrow: 'Tentang',
  aboutHeading: 'Mengirim aplikasi mobile sejak 2019.',
  aboutSubtitle: 'Apa yang saya kerjakan dan bagaimana cara saya bekerja.',
  aboutParagraphs: [
    'Saya mobile engineer dengan lebih dari empat tahun pengalaman Flutter di '
        'produksi, terutama pada produk yang transaksinya tidak boleh gagal.',
    'Pekerjaan terakhir di mobilitas listrik: tukar baterai, sewa, dan '
        'pembayaran, dibangun agar tetap bisa dipakai saat jaringan lemah atau '
        'hilang.',
    'Saya mementingkan struktur yang bertahan dalam tim — lapisan yang jelas, '
        'state yang mudah diuji, dan keputusan sederhana yang tidak perlu '
        'ditulis ulang tahun depan.',
    'Saya bekerja dekat dengan backend dan product, dan saya mengirim.',
  ],
  skillsEyebrow: 'Keahlian',
  skillsHeading: 'Perkakas yang saya pakai.',
  skillsSubtitle: 'Dikelompokkan menurut posisinya di stack.',
  skillGroupTitles: {
    'Mobile': 'Mobile',
    'Backend & Data': 'Backend & Data',
    'Tooling': 'Perkakas',
  },
  experienceEyebrow: 'Pengalaman',
  experienceHeading: 'Tempat saya bekerja.',
  experienceSubtitle: 'Peran, cakupan, dan hasil.',
  projectsEyebrow: 'Proyek Pilihan',
  projectsHeading: 'Karya pilihan.',
  projectsSubtitle: 'Produk yang sudah rilis, kebanyakan mobilitas dan '
      'pembayaran.',
  caseStudy: 'Studi kasus',
  showAll: 'Lihat semua {n} proyek',
  showFeatured: 'Tampilkan pilihan saja',
  educationEyebrow: 'Pendidikan & Sertifikasi',
  educationHeading: 'Kredensial.',
  educationSubtitle: 'Kursus dan sertifikasi, masing-masing dengan catatan '
      'publik.',
  credentials: 'Kredensial',
  contactEyebrow: 'Kontak',
  contactHeading: 'Mari bicara.',
  contactSubtitle: 'Terbuka untuk peran Flutter dan mobile engineering.',
  emailLabel: 'Email',
  footerNote: 'Dibangun dengan Flutter.',
  themeLight: 'Ganti ke tema terang',
  themeDark: 'Ganti ke tema gelap',
  modalProblem: 'Masalah',
  modalSolution: 'Solusi',
  modalWhatIDid: 'Yang saya kerjakan',
  modalTechStack: 'Tech stack',
  modalScreens: 'Tangkapan layar',
  modalLinks: 'Tautan',
  modalClose: 'Tutup',
);

/// English by default; the nav toggle flips this.
final ValueNotifier<AppStrings> appStrings = ValueNotifier<AppStrings>(en);

void toggleLanguage() {
  appStrings.value = appStrings.value == en ? id : en;
}

/// Above `MaterialApp`, so every screen reads the current language.
class StringsScope extends InheritedWidget {
  const StringsScope({super.key, required this.strings, required super.child});

  final AppStrings strings;

  static AppStrings of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<StringsScope>()?.strings ?? en;

  @override
  bool updateShouldNotify(StringsScope oldWidget) =>
      oldWidget.strings != strings;
}

extension StringsContext on BuildContext {
  AppStrings get strings => StringsScope.of(this);
}
