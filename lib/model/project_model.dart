/// Project data — one place to edit. Adding a screenshot later means filling
/// `image`; nothing else changes.
///
/// Sort rule: live with visuals → live without visuals → in progress → coming
/// soon. Within a group, order follows this list.
enum ProjectStatus {
  live('Live'),
  inProgress('In Progress'),
  comingSoon('Coming Soon');

  const ProjectStatus(this.label);
  final String label;

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

  final String caption;
  final String code;
  final String language;
}

class ProjectLink {
  const ProjectLink({required this.label, required this.url});
  final String label;
  final String url;
}

/// A screenshot shown as evidence in the case-study modal.
class ProjectShot {
  const ProjectShot({required this.asset, required this.label});
  final String asset;
  final String label;
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

  final String name;
  final ProjectStatus status;
  final String role;
  final String year;
  final String summary;
  final String problem;
  final String solution;
  final List<String> techStack;

  /// Asset path. Null → designed fallback card, never a broken image.
  final String? image;
  final String imageAlt;

  /// Shown when there is no screenshot to show.
  final ProjectPreview? preview;

  /// Measurable outcomes. Empty list → section omitted.
  final List<String> impact;

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

const List<Project> projectList = [
  Project(
    name: 'ReCharge — Powerbank Sharing',
    status: ProjectStatus.live,
    role: 'Mobile Developer (Flutter)',
    year: '2023 — Present',
    summary:
        'IoT powerbank sharing: find a station, rent by QR, track the rental, return anywhere.',
    problem:
        'A sharing network needs one flow that covers station discovery, QR rental, live rental state, and return — with payments and identity handled securely.',
    solution:
        'Built and maintained the Flutter app: station map, QR scan to rent, rental transaction management, WhatsApp OTP registration, credit top-up and multiple payment methods.',
    techStack: [
      'Flutter',
      'BLoC',
      'Dio',
      'GetX DI',
      'AWS Cognito',
      'Firebase',
    ],
    impact: [
      'Authentication via AWS Amplify / Amazon Cognito, with WhatsApp OTP onboarding.',
      'Crashlytics, Analytics, Remote Config and Cloud Messaging wired across the app.',
      'Multi-environment flavors so staging and production builds ship from one codebase.',
    ],
    preview: ProjectPreview(
      caption: 'Illustrative — rental flow boundary',
      code: '''class RentalRepository {
  Future<Rental> start(String stationQr) async {
    final station = await _api.resolveStation(stationQr);
    if (!station.hasAvailable) throw RentalError.noStock;
    final rental = await _api.createRental(station.id);
    _cache.write(rental.id, rental);
    return rental;
  }
}''',
    ),
  ),
  Project(
    name: 'Volta — EV Monitoring',
    status: ProjectStatus.live,
    role: 'Mobile Developer (Flutter)',
    year: '2023 — Present',
    summary:
        'Monitor and manage electric motorbikes and batteries, with SGB swaps and SeMoLis rentals inside one app.',
    problem:
        'Battery swap transactions, vehicle monitoring and rental services lived in separate tools, so operators had no single operational view.',
    solution:
        'Developed the Volta app: battery and vehicle monitoring, SGB swap transactions, and SeMoLis rental flows in a single Flutter client.',
    image: 'assets/images/projects/volta-light.webp',
    imageAlt: 'Volta app banner',
    links: [
      ProjectLink(label: 'Website', url: 'https://voltaindonesia.com/'),
    ],
    // Ordered as the user walks the app: sign in, land on Home, then the rest.
    gallery: [
      ProjectShot(
        asset: 'assets/images/projects/volta/login.webp',
        label: 'Login',
      ),
      ProjectShot(
        asset: 'assets/images/projects/volta/home.webp',
        label: 'Home',
      ),
      ProjectShot(
        asset: 'assets/images/projects/volta/find-my-volta.webp',
        label: 'Find My Volta',
      ),
      ProjectShot(
        asset: 'assets/images/projects/volta/my-volta.webp',
        label: 'My Volta',
      ),
      ProjectShot(
        asset: 'assets/images/projects/volta/cabinet.webp',
        label: 'Cabinet detail',
      ),
      ProjectShot(
        asset: 'assets/images/projects/volta/sgb-mitra.webp',
        label: 'SGB Mitra',
      ),
      ProjectShot(
        asset: 'assets/images/projects/volta/dealer.webp',
        label: 'Dealer',
      ),
      ProjectShot(
        asset: 'assets/images/projects/volta/pilih-paket.webp',
        label: 'Choose package',
      ),
      ProjectShot(
        asset: 'assets/images/projects/volta/payment-method.webp',
        label: 'Payment method',
      ),
    ],
    techStack: ['Flutter', 'BLoC', 'Dio', 'GetX DI', 'Firebase'],
    impact: [
      'One client covers monitoring, swap transactions and rentals instead of three tools.',
      'Multi-flavor configuration keeps staging and production separated.',
    ],
  ),
  Project(
    name: 'SigApp — Driver Operations',
    status: ProjectStatus.live,
    role: 'Full-Stack Developer',
    year: '2019 — 2023',
    summary:
        'Driver app, web console and backend for attendance, travel expenses and timesheet verification.',
    problem:
        'Driver reporting was manual, so attendance, expense claims and timesheet verification could not be audited in one place.',
    solution:
        'Built SigApp (React Native), SigAppWeb and SigAppBackend: check-in/check-out attendance, travel expense logging and timesheet verification on a Laravel API.',
    techStack: ['React Native', 'Laravel', 'PHP', 'REST API'],
    impact: [
      'Attendance, expenses and timesheets verified through one system instead of paper.',
      'Four years of ownership across mobile client, web console and backend.',
    ],
    preview: ProjectPreview(
      caption: 'Illustrative — timesheet approval',
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
    role: 'Mobile Developer (Flutter)',
    year: '2022',
    summary:
        'Clothing commerce app for all ages, with order tracking from checkout to delivery.',
    problem:
        'Customers had no visibility into where an order was between packing and delivery.',
    solution:
        'Built ordering and shipment tracking so the purchase process is visible from checkout through packing to the customer.',
    techStack: ['Flutter', 'BLoC', 'Dio', 'GetX DI'],
    impact: [
      'Order lifecycle exposed to the customer instead of handled by support.',
    ],
  ),
  Project(
    name: 'SGB — Battery Swap Station',
    status: ProjectStatus.live,
    role: 'Mobile Developer (Flutter)',
    year: '2023 — Present',
    summary:
        'Station-side app for battery validation and swap transactions in the Volta ecosystem.',
    problem:
        'Stations needed reliable battery validation before a swap could be authorised.',
    solution:
        'Built station workflows for battery validation and swap transactions, sharing the Volta codebase and flavor configuration.',
    techStack: ['Flutter', 'BLoC', 'Dio', 'Firebase'],
    impact: [
      'Swap validation handled at the station instead of through a manual step.',
    ],
  ),
  Project(
    name: 'SeMoLis — Electric Motorcycle Rental',
    status: ProjectStatus.live,
    role: 'Mobile Developer (Flutter)',
    year: '2023 — Present',
    summary:
        'Rent-to-own electric motorcycle app: daily rental, battery swap stations and balance tracking.',
    problem:
        'Renting an electric motorcycle meant paperwork at a counter, and riders had no way to see '
        'their contract, payment schedule or remaining balance without calling an agent.',
    solution:
        'Built the rider app end to end — registration, rental plan selection, IoT-backed bike unlock, '
        'battery swap station lookup and an in-app balance for the 660-day rent-to-own contract.',
    image: 'assets/images/projects/semolis.webp',
    imageAlt: 'Semolis logo',
    links: [
      ProjectLink(label: 'Website', url: 'https://www.sewamotorlistrik.com/'),
    ],
    // Ordered as the rider walks the app: sign in, Home, then the rental flow.
    gallery: [
      ProjectShot(
        asset: 'assets/images/projects/semolis/login.webp',
        label: 'Login',
      ),
      ProjectShot(
        asset: 'assets/images/projects/semolis/home.webp',
        label: 'Home',
      ),
      ProjectShot(
        asset: 'assets/images/projects/semolis/rent.webp',
        label: 'Rent a bike',
      ),
      ProjectShot(
        asset: 'assets/images/projects/semolis/list-sgb.webp',
        label: 'Swap stations',
      ),
      ProjectShot(
        asset: 'assets/images/projects/semolis/detail-sgb.webp',
        label: 'Station detail',
      ),
      ProjectShot(
        asset: 'assets/images/projects/semolis/balance.webp',
        label: 'Balance',
      ),
    ],
    techStack: ['Flutter', 'BLoC', 'Dio', 'Firebase', 'IoT'],
    impact: [
      'Riders pick a plan, pay and see contract status in the app instead of at a counter.',
      'Battery swap stations are reachable in-app, so a low battery never strands a rider.',
    ],
  ),
  Project(
    name: 'Tariq — Hajj & Umrah',
    status: ProjectStatus.live,
    role: 'Mobile Developer (Flutter)',
    year: '2023 — Present',
    summary:
        'Companion app that helps pilgrims stay focused and devout through Hajj and Umrah.',
    problem:
        'Pilgrims need guidance and schedules that stay reachable in crowded places with weak connectivity.',
    solution:
        'Created and developed the mobile app with worship guidance and supporting content.',
    techStack: ['Flutter', 'BLoC', 'Dio', 'GetX DI'],
    impact: [
      'Guidance available in-app rather than through printed material.',
    ],
  ),
  Project(
    name: 'TomsirApps — F&B Ordering',
    status: ProjectStatus.live,
    role: 'Full-Stack Developer',
    year: '2021 — 2022',
    summary: 'F&B ordering with stock and cash management.',
    problem:
        'Small F&B operators tracked sales, stock and cash in separate notebooks.',
    solution:
        'Built a React Native client with Redux and an Express backend covering ordering, stock and cash management.',
    techStack: ['React Native', 'Redux', 'Express', 'Node.js'],
    impact: [
      'Sales, stock and cash reconciled in one system.',
    ],
  ),
];
