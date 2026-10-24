/// Profile data — the single place to edit identity, links and work history.
/// UI copy lives in `lib/res/strings.dart`; CV content is [Loc] (EN + ID).
library;

import 'package:flutter_portfolio/res/strings.dart';

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

  /// Employer name — a proper noun, identical in both languages.
  final String company;
  final Loc position;
  final Loc period;

  /// Two or three measurable outcomes. No invented numbers.
  final List<Loc> bullets;
}

class Education {
  const Education({
    required this.school,
    required this.degree,
    required this.period,
    this.note = '',
  });

  final String school;
  final Loc degree;
  final String period;

  /// GPA and similar — numerals, identical in both languages.
  final String note;
}

/// Source: current CV. Facts only — no invented metrics.
const List<Experience> experienceList = <Experience>[
  Experience(
    company: 'PT Code Development Indonesia',
    position: Loc('Mobile Developer (Flutter)', 'Mobile Developer (Flutter)'),
    period: Loc('Aug 2023 — Present', 'Agu 2023 — Sekarang'),
    bullets: [
      Loc(
        'Shipped ReCharge, an IoT powerbank-sharing platform: station '
            'discovery, QR rental and return, WhatsApp OTP, credit top-up and '
            'multiple payment methods.',
        'Merilis ReCharge, platform powerbank sharing berbasis IoT: pencarian '
            'stasiun, sewa dan pengembalian via QR, OTP WhatsApp, top-up saldo, '
            'dan berbagai metode pembayaran.',
      ),
      Loc(
        'Built Volta, SGB and SeMoLis — battery-swap and electric-motorcycle '
            'rental apps covering transactions, monitoring and payments.',
        'Membangun Volta, SGB, dan SeMoLis — aplikasi tukar baterai dan sewa '
            'motor listrik yang mencakup transaksi, pemantauan, dan pembayaran.',
      ),
      Loc(
        'Delivered the Tariq mobile app for Hajj and Umrah pilgrims.',
        'Merilis aplikasi Tariq untuk jamaah haji dan umrah.',
      ),
      Loc(
        'Standardised the stack across products: BLoC, Dio, GetX DI, AWS Cognito '
            'auth, Firebase Crashlytics/Analytics/Remote Config/FCM, multi-flavor '
            'builds.',
        'Menyeragamkan stack antar produk: BLoC, Dio, GetX DI, autentikasi AWS '
            'Cognito, Firebase Crashlytics/Analytics/Remote Config/FCM, dan '
            'build multi-flavor.',
      ),
    ],
  ),
  Experience(
    company: 'Freelance',
    position: Loc(
      'Mobile & Full-Stack Developer',
      'Mobile & Full-Stack Developer',
    ),
    period: Loc('Sep 2021 — Jun 2022', 'Sep 2021 — Jun 2022'),
    bullets: [
      Loc(
        'BISPO — clothing e-commerce app with order tracking from checkout to '
            'delivery (Flutter, BLoC, Dio).',
        'BISPO — aplikasi e-commerce pakaian dengan pelacakan pesanan dari '
            'checkout sampai pengiriman (Flutter, BLoC, Dio).',
      ),
      Loc(
        'TomsirApps & TomSirBackend — F&B ordering with stock and cash '
            'management (React Native, Redux, Express).',
        'TomsirApps & TomSirBackend — pemesanan F&B dengan manajemen stok dan '
            'kas (React Native, Redux, Express).',
      ),
    ],
  ),
  Experience(
    company: 'PT Permata Solusindo',
    position: Loc('Full-Stack Developer', 'Full-Stack Developer'),
    period: Loc('Nov 2019 — Jul 2023', 'Nov 2019 — Jul 2023'),
    bullets: [
      Loc(
        'Built SigApp, SigAppWeb and SigAppBackend for driver operations: '
            'check-in/check-out attendance, travel expense logging and timesheet '
            'verification.',
        'Membangun SigApp, SigAppWeb, dan SigAppBackend untuk operasional '
            'driver: absensi check-in/check-out, pencatatan biaya perjalanan, '
            'dan verifikasi timesheet.',
      ),
      Loc(
        'Delivered the mobile client in React Native on a Laravel backend.',
        'Merilis klien mobile dengan React Native di backend Laravel.',
      ),
    ],
  ),
];

const List<Education> educationList = <Education>[
  Education(
    school: 'Universitas Insan Pembangunan',
    degree: Loc(
      'Bachelor of Information Technology',
      'Sarjana Teknologi Informasi',
    ),
    period: '2016 — 2020',
    note: 'GPA 3.83 / 4.00',
  ),
];
