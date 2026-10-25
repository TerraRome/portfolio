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

  /// Finished build with public source, no deployed product URL.
  demo,
  inProgress,
  comingSoon;

  String get label => switch (this) {
        ProjectStatus.live => appStrings.value.statusLive,
        ProjectStatus.demo => appStrings.value.statusDemo,
        ProjectStatus.inProgress => appStrings.value.statusInProgress,
        ProjectStatus.comingSoon => appStrings.value.statusComingSoon,
      };

  // Finished work shares a rank: the badge, not the order, tells a shipped
  // product from a demo. Visuals break the tie, then list order.
  int get sortRank => switch (this) {
        ProjectStatus.live || ProjectStatus.demo => 0,
        ProjectStatus.inProgress => 2,
        ProjectStatus.comingSoon => 3,
      };
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
const Loc _source = Loc('Source code', 'Kode sumber');

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
  Project(
    name: 'Crimson Dragon Hot Pot — Delivery',
    status: ProjectStatus.demo,
    role: Loc('Mobile Developer (Flutter)', 'Mobile Developer (Flutter)'),
    year: '2026',
    summary: Loc(
      'Hot pot delivery app: 26 screens from onboarding to live rider '
          'tracking, on a crimson-and-gold design system built from scratch.',
      'Aplikasi pesan-antar hot pot: 26 layar dari onboarding sampai pelacakan '
          'kurir langsung, dengan design system crimson dan emas dari nol.',
    ),
    problem: Loc(
      'A delivery app has to carry the whole journey — sign in, browse, cart, '
          'payment, tracking — without a dead end, and look like a restaurant '
          'rather than a template.',
      'Aplikasi pesan-antar harus membawa seluruh alur — masuk, jelajah menu, '
          'keranjang, pembayaran, pelacakan — tanpa jalan buntu, dan tampil '
          'seperti restoran, bukan template.',
    ),
    solution: Loc(
      'Built all 26 routes in Flutter with GoRouter typed arguments, a Riverpod '
          'state layer, and a Material 3 theme drawn from crimson and gold '
          'tokens. The live-tracking map is a CustomPainter — no map SDK.',
      'Membangun 26 rute di Flutter dengan GoRouter typed arguments, lapisan '
          'state Riverpod, dan tema Material 3 dari token crimson dan emas. '
          'Peta pelacakan langsung digambar dengan CustomPainter — tanpa SDK '
          'peta.',
    ),
    techStack: ['Flutter', 'Riverpod', 'GoRouter', 'Material 3', 'CustomPainter'],
    impact: [
      Loc(
        '26 routes, every screen reachable, no placeholder pages.',
        '26 rute, semua layar bisa dicapai, tanpa halaman placeholder.',
      ),
      Loc(
        'Live-tracking map drawn on canvas, so no map SDK or API key is needed.',
        'Peta pelacakan digambar di canvas, jadi tidak perlu SDK peta atau API '
            'key.',
      ),
      Loc(
        'OTP input, spice-level selector and animated splash built from scratch.',
        'Input OTP, pemilih level pedas, dan splash animasi dibuat dari nol.',
      ),
    ],
    image: 'assets/images/projects/hotpot/main-image.png',
    imageAlt: 'Crimson Dragon Hot Pot banner',
    links: [
      ProjectLink(label: _source, url: 'https://github.com/TerraRome/Hot-Pot'),
    ],
    // Ordered as the diner walks the app: sign in, Home, then the order flow.
    gallery: [
      ProjectShot(
        asset: 'assets/images/projects/hotpot/signin.webp',
        label: Loc('Sign in', 'Masuk'),
      ),
      ProjectShot(
        asset: 'assets/images/projects/hotpot/onboarding.gif',
        label: Loc('Onboarding', 'Onboarding'),
      ),
      ProjectShot(
        asset: 'assets/images/projects/hotpot/home.webp',
        label: Loc('Home', 'Beranda'),
      ),
      ProjectShot(
        asset: 'assets/images/projects/hotpot/product-detail.gif',
        label: Loc('Product detail', 'Detail produk'),
      ),
      ProjectShot(
        asset: 'assets/images/projects/hotpot/cart.gif',
        label: Loc('Cart', 'Keranjang'),
      ),
      ProjectShot(
        asset: 'assets/images/projects/hotpot/order-tracking.webp',
        label: Loc('Order tracking', 'Pelacakan pesanan'),
      ),
      ProjectShot(
        asset: 'assets/images/projects/hotpot/live-tracking.gif',
        label: Loc('Live tracking', 'Pelacakan langsung'),
      ),
      ProjectShot(
        asset: 'assets/images/projects/hotpot/profile.gif',
        label: Loc('Profile', 'Profil'),
      ),
      ProjectShot(
        asset: 'assets/images/projects/hotpot/loyalty.gif',
        label: Loc('Loyalty & rewards', 'Poin & hadiah'),
      ),
    ],
  ),
  Project(
    name: 'TaskFlow — Task Manager',
    status: ProjectStatus.demo,
    role: Loc('Mobile Developer (Flutter)', 'Mobile Developer (Flutter)'),
    year: '2026',
    summary: Loc(
      'Task manager with schedules, projects and statistics: 14 screens, dark '
          'mode, and offline persistence with no backend.',
      'Manajer tugas dengan jadwal, proyek, dan statistik: 14 layar, mode '
          'gelap, dan penyimpanan offline tanpa backend.',
    ),
    problem: Loc(
      'Task apps usually need an account and lose the day\'s work when the '
          'network does, and project counts drift between screens.',
      'Aplikasi tugas biasanya butuh akun dan kehilangan pekerjaan hari ini '
          'saat jaringan putus, sementara hitungan tugas proyek melenceng antar '
          'layar.',
    ),
    solution: Loc(
      'Built TaskFlow local-first: Hive with hand-written TypeAdapters, a '
          'Riverpod state layer with derived providers, and a custom '
          'InheritedWidget theme that switches dark mode without a restart.',
      'Membangun TaskFlow local-first: Hive dengan TypeAdapter tulisan tangan, '
          'lapisan state Riverpod dengan derived provider, dan tema '
          'InheritedWidget sendiri yang mengganti mode gelap tanpa restart.',
    ),
    techStack: ['Flutter', 'Riverpod', 'Hive', 'SharedPreferences'],
    impact: [
      Loc(
        'Tasks and projects survive a restart with no backend at all.',
        'Tugas dan proyek tetap ada setelah aplikasi ditutup, tanpa backend.',
      ),
      Loc(
        'One derived provider feeds Projects, Project Detail and Statistics, so '
            'counts cannot disagree.',
        'Satu derived provider memasok Projects, Project Detail, dan '
            'Statistics, jadi hitungan tidak bisa berbeda.',
      ),
      Loc(
        'Dark mode across all 14 screens from a single token set.',
        'Mode gelap di 14 layar dari satu set token.',
      ),
    ],
    image: 'assets/images/projects/taskflow/main-image.png',
    imageAlt: 'TaskFlow banner',
    links: [
      ProjectLink(
        label: _source,
        url: 'https://github.com/TerraRome/TaskManager',
      ),
    ],
    // Ordered as the user walks the app: onboarding, Home, then the task flow.
    gallery: [
      ProjectShot(
        asset: 'assets/images/projects/taskflow/onboarding.gif',
        label: Loc('Onboarding', 'Onboarding'),
      ),
      ProjectShot(
        asset: 'assets/images/projects/taskflow/home.webp',
        label: Loc('Home', 'Beranda'),
      ),
      ProjectShot(
        asset: 'assets/images/projects/taskflow/schedule.webp',
        label: Loc('Schedule', 'Jadwal'),
      ),
      ProjectShot(
        asset: 'assets/images/projects/taskflow/new-task.gif',
        label: Loc('New task', 'Tugas baru'),
      ),
      ProjectShot(
        asset: 'assets/images/projects/taskflow/task-detail.webp',
        label: Loc('Task detail', 'Detail tugas'),
      ),
      ProjectShot(
        asset: 'assets/images/projects/taskflow/projects.webp',
        label: Loc('Projects', 'Proyek'),
      ),
      ProjectShot(
        asset: 'assets/images/projects/taskflow/statistics.webp',
        label: Loc('Statistics', 'Statistik'),
      ),
      ProjectShot(
        asset: 'assets/images/projects/taskflow/home-dark.webp',
        label: Loc('Home, dark mode', 'Beranda, mode gelap'),
      ),
    ],
  ),
];
