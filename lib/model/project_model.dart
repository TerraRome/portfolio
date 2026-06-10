class Project {
  final String name;
  final String summary;
  final String image;

  final String role;
  final String problem;
  final String solution;

  final List<String> techStack;
  final List<String> contributions;
  final List<String> challenges;

  Project({
    required this.name,
    required this.summary,
    required this.image,
    required this.role,
    required this.problem,
    required this.solution,
    required this.techStack,
    required this.contributions,
    required this.challenges,
  });
}

final List<Project> projectList = [
  Project(
    name: 'Volta',
    image: 'assets/images/volta.png',
    role: 'Flutter Developer',
    summary:
        'Electric vehicle ecosystem platform for battery swap stations and motorcycle rental services.',
    problem:
        'Managing battery swap transactions, vehicle monitoring, and rental services within a single mobile ecosystem.',
    solution:
        'Developed a Flutter application that integrates battery swap workflows, motorcycle rental services, payment processes, and real-time operational monitoring.',
    techStack: [
      'Flutter',
      'BLoC',
      'Dio',
      'Firebase',
      'Hive',
      'GetIt',
    ],
    contributions: [
      'Implemented battery swap workflows',
      'Integrated QR code scanning',
      'Developed rental transaction features',
      'Implemented push notifications',
      'Implemented offline caching using Hive',
      'Integrated payment workflows',
      'Implemented WebView integrations',
    ],
    challenges: [
      'Transaction consistency',
      'Offline synchronization',
      'Real-time data updates',
      'Battery validation workflows',
    ],
  ),
  Project(
    name: 'SGB (Battery Swap Station)',
    image: 'assets/images/sgb.png',
    role: 'Flutter Developer',
    summary:
        'Operational application for battery swap station management and battery lifecycle monitoring.',
    problem:
        'Battery swap stations require reliable validation and monitoring of battery inventory and transactions.',
    solution:
        'Built station-side workflows to support battery validation, inventory monitoring, and operational transactions.',
    techStack: [
      'Flutter',
      'BLoC',
      'Dio',
      'Firebase',
    ],
    contributions: [
      'Built battery validation flows',
      'Implemented QR scanning features',
      'Integrated backend operational services',
      'Implemented station monitoring workflows',
    ],
    challenges: [
      'Battery inventory accuracy',
      'Transaction validation',
      'Operational reliability',
    ],
  ),
  Project(
    name: 'SeMoLis',
    image: 'assets/images/semolis.png',
    role: 'Flutter Developer',
    summary: 'Motorcycle rental and electric vehicle subscription platform.',
    problem:
        'Users need a simple process for renting electric motorcycles and managing rental transactions.',
    solution:
        'Developed rental management features including registration, transaction workflows, and status monitoring.',
    techStack: [
      'Flutter',
      'BLoC',
      'Dio',
      'Firebase',
    ],
    contributions: [
      'Developed rental workflows',
      'Integrated customer transaction flows',
      'Implemented status tracking',
      'Built backend integrations',
    ],
    challenges: [
      'Rental lifecycle management',
      'Transaction reliability',
      'User experience optimization',
    ],
  ),
  Project(
    name: 'Tariq Mobile',
    image: 'assets/images/tariq.png',
    role: 'Flutter Developer',
    summary: 'Digital companion application for Hajj and Umrah pilgrims.',
    problem:
        'Pilgrims need accessible guidance and information throughout their worship journey.',
    solution:
        'Developed a mobile application that provides worship guidance, schedules, and supporting information.',
    techStack: [
      'Flutter',
      'BLoC',
      'Dio',
      'Firebase',
    ],
    contributions: [
      'Built mobile application features',
      'Integrated backend APIs',
      'Implemented state management using BLoC',
      'Developed notification workflows',
    ],
    challenges: [
      'User accessibility',
      'Content synchronization',
      'Scalable architecture',
    ],
  ),
  Project(
    name: 'Driver Attendance & Expense System',
    image: 'assets/images/driver.png',
    role: 'Full Stack Developer',
    summary:
        'Enterprise solution for attendance tracking, expense reporting, and timesheet management.',
    problem:
        'Driver operational reporting was performed manually and required significant administrative effort.',
    solution:
        'Built a system to digitize attendance, expense submission, and timesheet verification processes.',
    techStack: [
      'React Native',
      'Laravel',
      'REST API',
      'MySQL',
    ],
    contributions: [
      'Developed mobile application',
      'Developed backend services',
      'Implemented attendance tracking',
      'Implemented expense workflows',
      'Implemented timesheet verification',
    ],
    challenges: [
      'Data consistency',
      'Offline reporting scenarios',
      'Operational workflow optimization',
    ],
  ),
  Project(
    name: 'BISPO',
    image: 'assets/images/bispo.png',
    role: 'Flutter Developer',
    summary:
        'E-commerce platform for fashion product ordering and shipment tracking.',
    problem:
        'Customers require transparency regarding their order status throughout the fulfillment process.',
    solution:
        'Developed an e-commerce application with ordering, shipment tracking, and order status monitoring.',
    techStack: [
      'Flutter',
      'Dio',
      'BLoC',
    ],
    contributions: [
      'Developed mobile application',
      'Implemented order management',
      'Implemented shipment tracking',
      'Integrated backend services',
    ],
    challenges: [
      'Order lifecycle tracking',
      'Real-time status updates',
      'User experience optimization',
    ],
  ),
  Project(
    name: 'TomsirApps',
    image: 'assets/images/tomsir.png',
    role: 'Full Stack Developer',
    summary:
        'Food and beverage ordering platform with inventory and cash management.',
    problem:
        'Business operations required a centralized solution for sales, inventory, and financial tracking.',
    solution:
        'Built a mobile and backend solution for ordering, stock management, and cash flow monitoring.',
    techStack: [
      'React Native',
      'Node.js',
      'Express',
      'Redux',
    ],
    contributions: [
      'Developed mobile application',
      'Developed backend APIs',
      'Implemented stock management',
      'Implemented cash management workflows',
    ],
    challenges: [
      'Inventory synchronization',
      'Transaction management',
      'Scalable backend architecture',
    ],
  ),
];
