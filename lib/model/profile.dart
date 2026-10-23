/// Profile data — the single place to edit identity, links and work history.
/// UI copy lives in `lib/res/strings.dart`.
library;

const String displayName = 'Tengku Alfarizi';

/// Existing CV file in Drive.
const String cvUrl =
    'https://drive.google.com/file/d/1jd2Dxl_9avDi23Y-CLeF23mQXbYSaosb/view?usp=drive_link';

const String email = 'tengku.alfarizi1@gmail.com';

class SocialLink {
  const SocialLink(this.label, this.url);
  final String label;
  final String url;
}

const List<SocialLink> contactLinks = [
  SocialLink(
    'LinkedIn',
    'https://www.linkedin.com/in/tengku-alfarizi-a645b7249/',
  ),
  SocialLink('GitHub', 'https://github.com/TerraRome'),
  SocialLink('GitLab', 'https://gitlab.com/TerraRo'),
  SocialLink('WhatsApp', 'https://wa.me/6285172270117'),
];

class SkillGroup {
  const SkillGroup(this.title, this.skills);
  final String title;
  final List<String> skills;
}

const List<SkillGroup> skillGroups = [
  SkillGroup('Mobile', [
    'Flutter',
    'Dart',
    'BLoC',
    'GetX',
    'React Native',
    'Clean Architecture',
  ]),
  SkillGroup('Backend & Data', [
    'Firebase',
    'REST',
    'Dio',
    'Hive / SQLite',
    'AWS Cognito',
    'Laravel',
    'PHP',
    'Node.js',
  ]),
  SkillGroup('Tooling', ['Git', 'CI', 'Figma']),
];

class Experience {
  const Experience({
    required this.company,
    required this.position,
    required this.period,
    this.bullets = const [],
  });

  final String company;
  final String position;
  final String period;

  /// Two or three measurable outcomes. No invented numbers.
  final List<String> bullets;
}

class Education {
  const Education({
    required this.school,
    required this.degree,
    required this.period,
    this.note = '',
  });

  final String school;
  final String degree;
  final String period;
  final String note;
}

/// Source: current CV. Facts only — no invented metrics.
const List<Experience> experienceList = <Experience>[
  Experience(
    company: 'PT Code Development Indonesia',
    position: 'Mobile Developer (Flutter)',
    period: 'Aug 2023 — Present',
    bullets: [
      'Shipped ReCharge, an IoT powerbank-sharing platform: station discovery, '
          'QR rental and return, WhatsApp OTP, credit top-up and multiple payment '
          'methods.',
      'Built Volta, SGB and SeMoLis — battery-swap and electric-motorcycle rental '
          'apps covering transactions, monitoring and payments.',
      'Delivered the Tariq mobile app for Hajj and Umrah pilgrims.',
      'Standardised the stack across products: BLoC, Dio, GetX DI, AWS Cognito '
          'auth, Firebase Crashlytics/Analytics/Remote Config/FCM, multi-flavor '
          'builds.',
    ],
  ),
  Experience(
    company: 'Freelance',
    position: 'Mobile & Full-Stack Developer',
    period: 'Sep 2021 — Jun 2022',
    bullets: [
      'BISPO — clothing e-commerce app with order tracking from checkout to '
          'delivery (Flutter, BLoC, Dio).',
      'TomsirApps & TomSirBackend — F&B ordering with stock and cash management '
          '(React Native, Redux, Express).',
    ],
  ),
  Experience(
    company: 'PT Permata Solusindo',
    position: 'Full-Stack Developer',
    period: 'Nov 2019 — Jul 2023',
    bullets: [
      'Built SigApp, SigAppWeb and SigAppBackend for driver operations: '
          'check-in/check-out attendance, travel expense logging and timesheet '
          'verification.',
      'Delivered the mobile client in React Native on a Laravel backend.',
    ],
  ),
];

const List<Education> educationList = <Education>[
  Education(
    school: 'Universitas Insan Pembangunan',
    degree: 'Bachelor of Information Technology',
    period: '2016 — 2020',
    note: 'GPA 3.83 / 4.00',
  ),
];
