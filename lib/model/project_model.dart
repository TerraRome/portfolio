/// Project data — one place to edit. Adding a screenshot later means filling
/// `image`; nothing else changes.
///
/// Sort rule: live with visuals → live without visuals → in progress → coming
/// soon. Within a group, order follows this list.
///
/// Every reader-facing string is a [Loc] (EN + ID). The lists stay `const`;
/// `.t` resolves the active language at call time.
library;

import 'package:flutter_portfolio/res/strings.dart';

enum ProjectStatus {
  live,
  inProgress,
  comingSoon;

  String get label => switch (this) {
        ProjectStatus.live => appStrings.value.statusLive,
        ProjectStatus.inProgress => appStrings.value.statusInProgress,
        ProjectStatus.comingSoon => appStrings.value.statusComingSoon,
      };

  int get sortRank => switch (this) {
        ProjectStatus.live => 0,
        ProjectStatus.inProgress => 2,
        ProjectStatus.comingSoon => 3,
      };
}

/// Non-visual projects get a code snippet instead of a screenshot.
class ProjectPreview {
  const ProjectPreview({
    required this.caption,
    required this.code,
    this.language = 'dart',
  });

  final Loc caption;
  final String code;
  final String language;
}

class ProjectLink {
  const ProjectLink({required this.label, required this.url});
  final Loc label;
  final String url;
}

/// A screenshot shown as evidence in the case-study modal.
class ProjectShot {
  const ProjectShot({required this.asset, required this.label});
  final String asset;
  final Loc label;
}

class Project {
  const Project({
    required this.name,
    required this.status,
    required this.role,
    required this.summary,
    required this.problem,
    required this.solution,
    required this.techStack,
    this.year = '',
    this.image,
    this.imageAlt = '',
    this.preview,
    this.impact = const [],
    this.links = const [],
    this.gallery = const [],
  });

  /// Product name — a proper noun, identical in both languages.
  final String name;
  final ProjectStatus status;
  final Loc role;
  final String year;
  final Loc summary;
  final Loc problem;
  final Loc solution;
  final List<String> techStack;

  /// Asset path. Null → designed fallback card, never a broken image.
  final String? image;
  final String imageAlt;

  /// Shown when there is no screenshot to show.
  final ProjectPreview? preview;

  /// Measurable outcomes. Empty list → section omitted.
  final List<Loc> impact;

  /// Only the links that exist are rendered.
  final List<ProjectLink> links;

  /// Screenshots shown as evidence. Empty list → section omitted.
  final List<ProjectShot> gallery;

  bool get hasVisual => image != null;
}

/// Live + visual first, then live non-visual, then in-progress, then coming soon.
List<Project> sortedProjects(List<Project> input) {
  final indexed = input.asMap().entries.toList();
  indexed.sort((a, b) {
    final rankA = a.value.status.sortRank + (a.value.hasVisual ? 0 : 1);
    final rankB = b.value.status.sortRank + (b.value.hasVisual ? 0 : 1);
    final byRank = rankA.compareTo(rankB);
    return byRank != 0 ? byRank : a.key.compareTo(b.key);
  });
  return [for (final e in indexed) e.value];
}

const Loc _website = Loc('Website', 'Situs Web');

const List<Project> projectList = [
  Project(
    name: 'ReCharge — Powerbank Sharing',
    status: ProjectStatus.live,
    role: Loc('Mobile Developer (Flutter)', 'Mobile Developer (Flutter)'),
    year: '2023 — Present',
    summary: Loc(
      'IoT powerbank sharing: find a station, rent by QR, track the rental, '
          'return anywhere.',
      'Powerbank sharing berbasis IoT: cari stasiun, sewa lewat QR, pantau '
          'transaksi, kembalikan di mana saja.',
    ),
    problem: Loc(
      'A sharing network needs one flow that covers station discovery, QR '
          'rental, live rental state, and return — with payments and identity '
          'handled securely.',
      'Jaringan sharing butuh satu alur yang mencakup pencarian stasiun, sewa '
          'via QR, status transaksi langsung, dan pengembalian — dengan '
          'pembayaran serta identitas yang aman.',
    ),
    solution: Loc(
      'Built and maintained the Flutter app: station map, QR scan to rent, '
          'rental transaction management, WhatsApp OTP registration, credit '
          'top-up and multiple payment methods.',
      'Membangun dan merawat aplikasi Flutter: peta stasiun, scan QR untuk '
          'sewa, manajemen transaksi, registrasi OTP WhatsApp, top-up saldo, '
          'dan berbagai metode pembayaran.',
    ),
    techStack: [
      'Flutter',
      'BLoC',
      'Dio',
      'GetX DI',
      'AWS Cognito',
      'Firebase',
    ],
    impact: [
      Loc(
        'Authentication via AWS Amplify / Amazon Cognito, with WhatsApp OTP '
            'onboarding.',
        'Autentikasi lewat AWS Amplify / Amazon Cognito, dengan onboarding OTP '
            'WhatsApp.',
      ),
      Loc(
        'Crashlytics, Analytics, Remote Config and Cloud Messaging wired across '
            'the app.',
        'Crashlytics, Analytics, Remote Config, dan Cloud Messaging terpasang '
            'di seluruh aplikasi.',
      ),
      Loc(
        'Multi-environment flavors so staging and production builds ship from '
            'one codebase.',
        'Flavor multi-environment agar build staging dan produksi keluar dari '
            'satu codebase.',
      ),
    ],
    image: 'assets/images/projects/recharge/main-image.png',
    imageAlt: 'ReCharge banner',
    links: [
      ProjectLink(label: _website, url: 'https://www.recharge.id/'),
    ],
    // Ordered as the user walks the app: sign in, Home, then the rental flow.
    gallery: [
      ProjectShot(
        asset: 'assets/images/projects/recharge/login.webp',
        label: Loc('Login', 'Masuk'),
      ),
      ProjectShot(
        asset: 'assets/images/projects/recharge/home.webp',
        label: Loc('Home', 'Beranda'),
      ),
      ProjectShot(
        asset: 'assets/images/projects/recharge/paket.webp',
        label: Loc('Packages', 'Paket'),
      ),
      ProjectShot(
        asset: 'assets/images/projects/recharge/buy-packages.webp',
        label: Loc('Buy packages', 'Beli paket'),
      ),
      ProjectShot(
        asset: 'assets/images/projects/recharge/payment-overview.webp',
        label: Loc('Payment overview', 'Ringkasan pembayaran'),
      ),
      ProjectShot(
        asset: 'assets/images/projects/recharge/profile.webp',
        label: Loc('Profile', 'Profil'),
      ),
    ],
  ),
  Project(
    name: 'Volta — EV Monitoring',
    status: ProjectStatus.live,
    role: Loc('Mobile Developer (Flutter)', 'Mobile Developer (Flutter)'),
    year: '2023 — Present',
    summary: Loc(
      'Monitor and manage electric motorbikes and batteries, with SGB swaps and '
          'SeMoLis rentals inside one app.',
      'Pantau dan kelola motor listrik serta baterai, dengan tukar baterai SGB '
          'dan sewa SeMoLis dalam satu aplikasi.',
    ),
    problem: Loc(
      'Battery swap transactions, vehicle monitoring and rental services lived '
          'in separate tools, so operators had no single operational view.',
      'Transaksi tukar baterai, pemantauan kendaraan, dan layanan sewa tersebar '
          'di alat terpisah, sehingga operator tidak punya satu pandangan '
          'operasional.',
    ),
    solution: Loc(
      'Developed the Volta app: battery and vehicle monitoring, SGB swap '
          'transactions, and SeMoLis rental flows in a single Flutter client.',
      'Membangun aplikasi Volta: pemantauan baterai dan kendaraan, transaksi '
          'tukar baterai SGB, dan alur sewa SeMoLis dalam satu klien Flutter.',
    ),
    image: 'assets/images/projects/volta-light.webp',
    imageAlt: 'Volta app banner',
    links: [
      ProjectLink(label: _website, url: 'https://voltaindonesia.com/'),
    ],
    // Ordered as the user walks the app: sign in, land on Home, then the rest.
    gallery: [
      ProjectShot(
        asset: 'assets/images/projects/volta/login.webp',
        label: Loc('Login', 'Masuk'),
      ),
      ProjectShot(
        asset: 'assets/images/projects/volta/home.webp',
        label: Loc('Home', 'Beranda'),
      ),
      ProjectShot(
        asset: 'assets/images/projects/volta/find-my-volta.webp',
        label: Loc('Find My Volta', 'Cari Volta Saya'),
      ),
      ProjectShot(
        asset: 'assets/images/projects/volta/my-volta.webp',
        label: Loc('My Volta', 'Volta Saya'),
      ),
      ProjectShot(
        asset: 'assets/images/projects/volta/cabinet.webp',
        label: Loc('Cabinet detail', 'Detail kabinet'),
      ),
      ProjectShot(
        asset: 'assets/images/projects/volta/sgb-mitra.webp',
        label: Loc('SGB Mitra', 'Mitra SGB'),
      ),
      ProjectShot(
        asset: 'assets/images/projects/volta/dealer.webp',
        label: Loc('Dealer', 'Dealer'),
      ),
      ProjectShot(
        asset: 'assets/images/projects/volta/pilih-paket.webp',
        label: Loc('Choose package', 'Pilih paket'),
      ),
      ProjectShot(
        asset: 'assets/images/projects/volta/payment-method.webp',
        label: Loc('Payment method', 'Metode pembayaran'),
      ),
    ],
    techStack: ['Flutter', 'BLoC', 'Dio', 'GetX DI', 'Firebase'],
    impact: [
      Loc(
        'One client covers monitoring, swap transactions and rentals instead of '
            'three tools.',
        'Satu klien menangani pemantauan, transaksi tukar baterai, dan sewa — '
            'bukan tiga alat terpisah.',
      ),
      Loc(
        'Multi-flavor configuration keeps staging and production separated.',
        'Konfigurasi multi-flavor memisahkan staging dan produksi.',
      ),
    ],
  ),
  Project(
    name: 'SigApp — Driver Operations',
    status: ProjectStatus.live,
    role: Loc('Full-Stack Developer', 'Full-Stack Developer'),
    year: '2019 — 2023',
    summary: Loc(
      'Driver app, web console and backend for attendance, travel expenses and '
          'timesheet verification.',
      'Aplikasi driver, konsol web, dan backend untuk absensi, biaya perjalanan, '
          'dan verifikasi timesheet.',
    ),
    problem: Loc(
      'Driver reporting was manual, so attendance, expense claims and timesheet '
          'verification could not be audited in one place.',
      'Pelaporan driver masih manual, sehingga absensi, klaim biaya, dan '
          'verifikasi timesheet tidak bisa diaudit di satu tempat.',
    ),
    solution: Loc(
      'Built SigApp (React Native), SigAppWeb and SigAppBackend: '
          'check-in/check-out attendance, travel expense logging and timesheet '
          'verification on a Laravel API.',
      'Membangun SigApp (React Native), SigAppWeb, dan SigAppBackend: absensi '
          'check-in/check-out, pencatatan biaya perjalanan, dan verifikasi '
          'timesheet di API Laravel.',
    ),
    techStack: ['React Native', 'Laravel', 'PHP', 'REST API'],
    impact: [
      Loc(
        'Attendance, expenses and timesheets verified through one system '
            'instead of paper.',
        'Absensi, biaya, dan timesheet terverifikasi lewat satu sistem, bukan '
            'kertas.',
      ),
      Loc(
        'Four years of ownership across mobile client, web console and backend.',
        'Empat tahun menangani klien mobile, konsol web, dan backend sekaligus.',
      ),
    ],
    preview: ProjectPreview(
      caption: Loc('Illustrative — timesheet approval', 'Ilustrasi — persetujuan timesheet'),
      language: 'php',
      code: '''public function approve(Timesheet \$sheet): Timesheet
{
    abort_unless(\$sheet->status === 'pending', 409);
    \$sheet->update([
        'status' => 'approved',
        'approved_by' => auth()->id(),
        'approved_at' => now(),
    ]);
    return \$sheet;
}''',
    ),
  ),
  Project(
    name: 'BISPO — Fashion Commerce',
    status: ProjectStatus.live,
    role: Loc('Mobile Developer (Flutter)', 'Mobile Developer (Flutter)'),
    year: '2022',
    summary: Loc(
      'Clothing commerce app for all ages, with order tracking from checkout to '
          'delivery.',
      'Aplikasi belanja pakaian untuk semua usia, dengan pelacakan pesanan dari '
          'checkout sampai pengiriman.',
    ),
    problem: Loc(
      'Customers had no visibility into where an order was between packing and '
          'delivery.',
      'Pelanggan tidak bisa melihat posisi pesanan antara tahap pengemasan dan '
          'pengiriman.',
    ),
    solution: Loc(
      'Built ordering and shipment tracking so the purchase process is visible '
          'from checkout through packing to the customer.',
      'Membangun pemesanan dan pelacakan pengiriman agar proses pembelian '
          'terlihat sejak checkout, pengemasan, sampai diterima pelanggan.',
    ),
    techStack: ['Flutter', 'BLoC', 'Dio', 'GetX DI'],
    impact: [
      Loc(
        'Order lifecycle exposed to the customer instead of handled by support.',
        'Siklus pesanan terbuka untuk pelanggan, tidak lagi lewat tim support.',
      ),
    ],
  ),
  Project(
    name: 'SGB — Battery Swap Station',
    status: ProjectStatus.live,
    role: Loc('Mobile Developer (Flutter)', 'Mobile Developer (Flutter)'),
    year: '2023 — Present',
    summary: Loc(
      'Station-side app for battery validation and swap transactions in the '
          'Volta ecosystem.',
      'Aplikasi sisi stasiun untuk validasi baterai dan transaksi tukar baterai '
          'di ekosistem Volta.',
    ),
    problem: Loc(
      'Stations needed reliable battery validation before a swap could be '
          'authorised.',
      'Stasiun butuh validasi baterai yang andal sebelum tukar baterai bisa '
          'diizinkan.',
    ),
    solution: Loc(
      'Built station workflows for battery validation and swap transactions, '
          'sharing the Volta codebase and flavor configuration.',
      'Membangun alur stasiun untuk validasi baterai dan transaksi tukar '
          'baterai, memakai codebase dan konfigurasi flavor Volta.',
    ),
    techStack: ['Flutter', 'BLoC', 'Dio', 'Firebase'],
    impact: [
      Loc(
        'Swap validation handled at the station instead of through a manual step.',
        'Validasi tukar baterai ditangani di stasiun, bukan lewat langkah manual.',
      ),
    ],
  ),
  Project(
    name: 'SeMoLis — Electric Motorcycle Rental',
    status: ProjectStatus.live,
    role: Loc('Mobile Developer (Flutter)', 'Mobile Developer (Flutter)'),
    year: '2023 — Present',
    summary: Loc(
      'Rent-to-own electric motorcycle app: daily rental, battery swap stations '
          'and balance tracking.',
      'Aplikasi sewa-milik motor listrik: sewa harian, stasiun tukar baterai, '
          'dan pelacakan saldo.',
    ),
    problem: Loc(
      'Renting an electric motorcycle meant paperwork at a counter, and riders '
          'had no way to see their contract, payment schedule or remaining '
          'balance without calling an agent.',
      'Menyewa motor listrik berarti urus berkas di konter, dan penyewa tidak '
          'bisa melihat kontrak, jadwal pembayaran, atau sisa saldo tanpa '
          'menelepon agen.',
    ),
    solution: Loc(
      'Built the rider app end to end — registration, rental plan selection, '
          'IoT-backed bike unlock, battery swap station lookup and an in-app '
          'balance for the 660-day rent-to-own contract.',
      'Membangun aplikasi penyewa dari awal sampai akhir — registrasi, pilih '
          'paket sewa, buka kunci motor lewat IoT, pencarian stasiun tukar '
          'baterai, dan saldo dalam aplikasi untuk kontrak sewa-milik 660 hari.',
    ),
    image: 'assets/images/projects/semolis.webp',
    imageAlt: 'Semolis logo',
    links: [
      ProjectLink(label: _website, url: 'https://www.sewamotorlistrik.com/'),
    ],
    // Ordered as the rider walks the app: sign in, Home, then the rental flow.
    gallery: [
      ProjectShot(
        asset: 'assets/images/projects/semolis/login.webp',
        label: Loc('Login', 'Masuk'),
      ),
      ProjectShot(
        asset: 'assets/images/projects/semolis/home.webp',
        label: Loc('Home', 'Beranda'),
      ),
      ProjectShot(
        asset: 'assets/images/projects/semolis/rent.webp',
        label: Loc('Rent a bike', 'Sewa motor'),
      ),
      ProjectShot(
        asset: 'assets/images/projects/semolis/list-sgb.webp',
        label: Loc('Swap stations', 'Stasiun tukar baterai'),
      ),
      ProjectShot(
        asset: 'assets/images/projects/semolis/detail-sgb.webp',
        label: Loc('Station detail', 'Detail stasiun'),
      ),
      ProjectShot(
        asset: 'assets/images/projects/semolis/balance.webp',
        label: Loc('Balance', 'Saldo'),
      ),
    ],
    techStack: ['Flutter', 'BLoC', 'Dio', 'Firebase', 'IoT'],
    impact: [
      Loc(
        'Riders pick a plan, pay and see contract status in the app instead of '
            'at a counter.',
        'Penyewa memilih paket, membayar, dan melihat status kontrak di '
            'aplikasi, bukan di konter.',
      ),
      Loc(
        'Battery swap stations are reachable in-app, so a low battery never '
            'strands a rider.',
        'Stasiun tukar baterai bisa dicari di aplikasi, jadi baterai lemah '
            'tidak membuat penyewa tertahan.',
      ),
    ],
  ),
  Project(
    name: 'Tariq — Hajj & Umrah',
    status: ProjectStatus.live,
    role: Loc('Mobile Developer (Flutter)', 'Mobile Developer (Flutter)'),
    year: '2023 — Present',
    summary: Loc(
      'Companion app that helps pilgrims stay focused and devout through Hajj '
          'and Umrah.',
      'Aplikasi pendamping agar jamaah tetap fokus dan khusyuk menjalani haji '
          'dan umrah.',
    ),
    problem: Loc(
      'Pilgrims need guidance and schedules that stay reachable in crowded '
          'places with weak connectivity.',
      'Jamaah butuh panduan dan jadwal yang tetap bisa diakses di tempat padat '
          'dengan jaringan lemah.',
    ),
    solution: Loc(
      'Created and developed the mobile app with worship guidance and '
          'supporting content.',
      'Membuat dan mengembangkan aplikasi mobile berisi panduan ibadah dan '
          'konten pendukung.',
    ),
    techStack: ['Flutter', 'BLoC', 'Dio', 'GetX DI'],
    impact: [
      Loc(
        'Guidance available in-app rather than through printed material.',
        'Panduan tersedia di aplikasi, tidak lagi bergantung pada materi cetak.',
      ),
    ],
  ),
  Project(
    name: 'TomsirApps — F&B Ordering',
    status: ProjectStatus.live,
    role: Loc('Full-Stack Developer', 'Full-Stack Developer'),
    year: '2021 — 2022',
    summary: Loc(
      'F&B ordering with stock and cash management.',
      'Pemesanan makanan dan minuman dengan manajemen stok dan kas.',
    ),
    problem: Loc(
      'Small F&B operators tracked sales, stock and cash in separate notebooks.',
      'Pelaku usaha F&B kecil mencatat penjualan, stok, dan kas di buku '
          'terpisah.',
    ),
    solution: Loc(
      'Built a React Native client with Redux and an Express backend covering '
          'ordering, stock and cash management.',
      'Membangun klien React Native dengan Redux dan backend Express yang '
          'mencakup pemesanan, stok, dan manajemen kas.',
    ),
    techStack: ['React Native', 'Redux', 'Express', 'Node.js'],
    impact: [
      Loc(
        'Sales, stock and cash reconciled in one system.',
        'Penjualan, stok, dan kas tercatat di satu sistem.',
      ),
    ],
  ),
];
