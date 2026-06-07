import 'package:flutter/material.dart';

void main() {
  runApp(const MoroccoTravelApp());
}

// ==================== APP ====================
class MoroccoTravelApp extends StatelessWidget {
  const MoroccoTravelApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Morocco Travel Converter',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF1976D2),
          brightness: Brightness.light,
        ),
        fontFamily: 'Poppins',
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF1976D2),
          brightness: Brightness.dark,
        ),
        fontFamily: 'Poppins',
      ),
      home: const MainApp(),
    );
  }
}

class MainApp extends StatefulWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  int _selectedIndex = 0;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final List<Widget> _pages = [
    const HomePage(),
    const ProfilePage(),
    const ConverterPage(),
    const CitiesPage(),
    const AboutPage(),
  ];

  void _onNavItem(int index) {
    setState(() {
      _selectedIndex = index;
    });
    Navigator.pop(context); // Close drawer
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: CustomDrawer(
        onNavItem: _onNavItem,
        selectedIndex: _selectedIndex,
      ),
      body: Stack(
        children: [
          _pages[_selectedIndex],
          Positioned(
            bottom: 24,
            right: 24,
            child: FloatingActionButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Ready to explore Morocco? 🧳'),
                    duration: Duration(seconds: 2),
                  ),
                );
              },
              child: const Icon(Icons.airplanemode_active),
            ),
          ),
        ],
      ),
    );
  }
}

// ==================== CUSTOM DRAWER ====================
class CustomDrawer extends StatelessWidget {
  final Function(int) onNavItem;
  final int selectedIndex;

  const CustomDrawer({
    Key? key,
    required this.onNavItem,
    required this.selectedIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.blue.shade800,
              Colors.blue.shade600,
              Colors.cyan.shade500,
            ],
          ),
        ),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.blue.shade900,
                    Colors.cyan.shade600,
                  ],
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 70,
                    height: 70,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 3),
                      color: Colors.grey.shade300,
                    ),
                    child: Center(
                      child: Text(
                        'AJ',
                        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Ahmed Jamal',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'ahmed.jamal@travel.com',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Colors.white70,
                        ),
                  ),
                ],
              ),
            ),
            _buildDrawerItem(
              context,
              icon: Icons.home_rounded,
              label: 'Accueil',
              index: 0,
              isSelected: selectedIndex == 0,
            ),
            _buildDrawerItem(
              context,
              icon: Icons.person_rounded,
              label: 'Profil Voyageur',
              index: 1,
              isSelected: selectedIndex == 1,
            ),
            _buildDrawerItem(
              context,
              icon: Icons.currency_exchange_rounded,
              label: 'Convertisseur Devises',
              index: 2,
              isSelected: selectedIndex == 2,
            ),
            _buildDrawerItem(
              context,
              icon: Icons.location_city_rounded,
              label: 'Villes du Maroc',
              index: 3,
              isSelected: selectedIndex == 3,
            ),
            _buildDrawerItem(
              context,
              icon: Icons.info_rounded,
              label: 'À propos',
              index: 4,
              isSelected: selectedIndex == 4,
            ),
            const Divider(color: Colors.white24, height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Paramètres',
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          color: Colors.white70,
                        ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Icon(Icons.brightness_4, color: Colors.white70, size: 20),
                      const SizedBox(width: 12),
                      Text(
                        'Mode sombre',
                        style: TextStyle(color: Colors.white70),
                      ),
                      const Spacer(),
                      Switch(
                        value: false,
                        onChanged: (value) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Dark mode coming soon! 🌙'),
                            ),
                          );
                        },
                        activeColor: Colors.amber,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawerItem(
    BuildContext context, {
    required IconData icon,
    required String label,
    required int index,
    required bool isSelected,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: isSelected ? Colors.white.withOpacity(0.2) : Colors.transparent,
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: Icon(icon, color: Colors.white),
        title: Text(
          label,
          style: TextStyle(
            color: Colors.white,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        selected: isSelected,
        onTap: () => onNavItem(index),
      ),
    );
  }
}

// ==================== HOME PAGE ====================
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late AnimationController _slideController;

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _slideController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    Future.delayed(const Duration(milliseconds: 200), () {
      _fadeController.forward();
      _slideController.forward();
    });
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _slideController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () => Scaffold.of(context).openDrawer(),
        ),
        title: const Text('Morocco Travel'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Hero Section
            Container(
              height: 300,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.blue.shade800,
                    Colors.cyan.shade500,
                  ],
                ),
              ),
              child: FadeTransition(
                opacity: _fadeController,
                child: Stack(
                  children: [
                    Positioned(
                      top: -50,
                      right: -50,
                      child: Container(
                        width: 200,
                        height: 200,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white.withOpacity(0.1),
                        ),
                      ),
                    ),
                    Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.travel_explore_rounded,
                            size: 80,
                            color: Colors.white,
                          ),
                          const SizedBox(height: 20),
                          Text(
                            'Bienvenue au Maroc',
                            style: Theme.of(context)
                                .textTheme
                                .headlineMedium
                                ?.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            'Découvrez la magie du voyage',
                            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                  color: Colors.white70,
                                ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Accès rapide',
                    style: Theme.of(context)
                        .textTheme
                        .headlineSmall
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  SlideTransition(
                    position: Tween<Offset>(
                      begin: const Offset(0, 0.5),
                      end: Offset.zero,
                    ).animate(_slideController),
                    child: Column(
                      children: [
                        _buildQuickAccessTile(
                          context,
                          icon: Icons.person_rounded,
                          title: 'Mon Profil',
                          subtitle: 'Voir vos statistiques de voyage',
                          color: Colors.purple.shade500,
                          onTap: () {
                            // Navigate to Profile (index 1)
                            Scaffold.of(context).openDrawer();
                            Future.delayed(const Duration(milliseconds: 300), () {
                              // This will be handled by drawer
                            });
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('📊 Ouvrez le profil depuis le menu'),
                                duration: Duration(milliseconds: 800),
                              ),
                            );
                          },
                        ),
                        const SizedBox(height: 12),
                        _buildQuickAccessTile(
                          context,
                          icon: Icons.currency_exchange_rounded,
                          title: 'Convertisseur',
                          subtitle: 'MAD → EUR / USD',
                          color: Colors.green.shade500,
                          onTap: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('💱 Ouvrez le convertisseur depuis le menu'),
                                duration: Duration(milliseconds: 800),
                              ),
                            );
                          },
                        ),
                        const SizedBox(height: 12),
                        _buildQuickAccessTile(
                          context,
                          icon: Icons.location_city_rounded,
                          title: 'Villes du Maroc',
                          subtitle: '10 destinations incontournables',
                          color: Colors.orange.shade500,
                          onTap: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('🏙️ Ouvrez les villes depuis le menu'),
                                duration: Duration(milliseconds: 800),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.amber.shade50,
                          Colors.orange.shade50,
                        ],
                      ),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: Colors.orange.shade200,
                        width: 1,
                      ),
                    ),
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Inspirations du jour',
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 16),
                        _buildStatRow('🏙️', 'Villes visitées', '7/10'),
                        const SizedBox(height: 12),
                        _buildStatRow('✈️', 'Pays explorés', '12/195'),
                        const SizedBox(height: 12),
                        _buildStatRow('🗺️', 'Km parcourus', '8,500 km'),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.blue.shade50,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: Colors.blue.shade200,
                        width: 1,
                      ),
                    ),
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        Icon(
                          Icons.format_quote_rounded,
                          size: 40,
                          color: Colors.blue.shade400,
                        ),
                        const SizedBox(height: 12),
                        Text(
                          '"Le monde est un livre, et ceux qui ne voyagent pas n\'en lisent qu\'une page."',
                          textAlign: TextAlign.center,
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge
                              ?.copyWith(
                                fontStyle: FontStyle.italic,
                                color: Colors.blue.shade900,
                              ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickAccessTile(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [color.withOpacity(0.1), color.withOpacity(0.05)],
            ),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: color.withOpacity(0.3),
              width: 1,
            ),
          ),
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: color.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: color, size: 28),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall
                          ?.copyWith(color: Colors.grey.shade600),
                    ),
                  ],
                ),
              ),
              Icon(Icons.arrow_forward_ios_rounded, color: color, size: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatRow(String emoji, String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Text(emoji, style: const TextStyle(fontSize: 24)),
            const SizedBox(width: 12),
            Text(
              label,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.orange.shade700,
          ),
        ),
      ],
    );
  }
}

// ==================== PROFILE PAGE ====================
class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil Voyageur'),
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () => Scaffold.of(context).openDrawer(),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 280,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.blue.shade800,
                    Colors.purple.shade500,
                  ],
                ),
              ),
              child: Stack(
                children: [
                  Positioned(
                    top: -30,
                    right: -30,
                    child: Container(
                      width: 150,
                      height: 150,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white.withOpacity(0.08),
                      ),
                    ),
                  ),
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ScaleTransition(
                          scale: Tween<double>(begin: 0.5, end: 1.0)
                              .animate(_controller),
                          child: Container(
                            width: 120,
                            height: 120,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Colors.white,
                                width: 4,
                              ),
                              color: Colors.grey.shade300,
                            ),
                            child: Center(
                              child: Text(
                                'AJ',
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineLarge
                                    ?.copyWith(
                                      color: Colors.blue.shade800,
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Ahmed Jamal',
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall
                              ?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Voyageur passionné',
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge
                              ?.copyWith(
                                color: Colors.white70,
                              ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Informations personnelles',
                    style: Theme.of(context)
                        .textTheme
                        .headlineSmall
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  _buildInfoCard(
                    context,
                    icon: Icons.person_rounded,
                    label: 'Nom',
                    value: 'Ahmed Jamal',
                    color: Colors.blue,
                  ),
                  const SizedBox(height: 12),
                  _buildInfoCard(
                    context,
                    icon: Icons.public_rounded,
                    label: 'Pays',
                    value: 'Maroc',
                    color: Colors.green,
                  ),
                  const SizedBox(height: 12),
                  _buildInfoCard(
                    context,
                    icon: Icons.location_city_rounded,
                    label: 'Ville',
                    value: 'Casablanca',
                    color: Colors.orange,
                  ),
                  const SizedBox(height: 12),
                  _buildInfoCard(
                    context,
                    icon: Icons.work_rounded,
                    label: 'Profession',
                    value: 'Photographe de voyage',
                    color: Colors.purple,
                  ),
                  const SizedBox(height: 30),
                  Text(
                    'Statistiques de voyage',
                    style: Theme.of(context)
                        .textTheme
                        .headlineSmall
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  GridView.count(
                    crossAxisCount: 3,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 12,
                    children: [
                      _buildStatCard(
                        context,
                        icon: '🌍',
                        value: '12',
                        label: 'Pays',
                        color: Colors.blue,
                      ),
                      _buildStatCard(
                        context,
                        icon: '✈️',
                        value: '24',
                        label: 'Voyages',
                        color: Colors.red,
                      ),
                      _buildStatCard(
                        context,
                        icon: '🗺️',
                        value: '8.5K',
                        label: 'Km',
                        color: Colors.amber,
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  Text(
                    'Réalisations',
                    style: Theme.of(context)
                        .textTheme
                        .headlineSmall
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.amber.shade50,
                          Colors.orange.shade50,
                        ],
                      ),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: Colors.amber.shade200,
                        width: 1,
                      ),
                    ),
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        _buildAchievement(
                          '🏆',
                          'Explorateur des continents',
                          'Visité 5 continents différents',
                        ),
                        const SizedBox(height: 12),
                        _buildAchievement(
                          '📸',
                          'Collector de moments',
                          '1000+ photos prises',
                        ),
                        const SizedBox(height: 12),
                        _buildAchievement(
                          '🎯',
                          'Voyageur infatigable',
                          'Plus de 20 voyages complétés',
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard(
    BuildContext context, {
    required IconData icon,
    required String label,
    required String value,
    required Color color,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: color.withOpacity(0.05),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: color.withOpacity(0.2),
          width: 1,
        ),
      ),
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: color.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: color),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: Theme.of(context)
                      .textTheme
                      .labelSmall
                      ?.copyWith(color: Colors.grey.shade600),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(
    BuildContext context, {
    required String icon,
    required String value,
    required String label,
    required Color color,
  }) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [color.withOpacity(0.1), color.withOpacity(0.05)],
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: color.withOpacity(0.2),
          width: 1,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(icon, style: const TextStyle(fontSize: 32)),
          const SizedBox(height: 8),
          Text(
            value,
            style: Theme.of(context)
                .textTheme
                .headlineSmall
                ?.copyWith(fontWeight: FontWeight.bold, color: color),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: Theme.of(context)
                .textTheme
                .labelSmall
                ?.copyWith(color: Colors.grey.shade600),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildAchievement(String icon, String title, String description) {
    return Row(
      children: [
        Text(icon, style: const TextStyle(fontSize: 32)),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              Text(
                description,
                style: Theme.of(context)
                    .textTheme
                    .bodySmall
                    ?.copyWith(color: Colors.grey.shade600),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// ==================== CONVERTER PAGE ====================
class ConverterPage extends StatefulWidget {
  const ConverterPage({Key? key}) : super(key: key);

  @override
  State<ConverterPage> createState() => _ConverterPageState();
}

class _ConverterPageState extends State<ConverterPage>
    with TickerProviderStateMixin {
  final TextEditingController _controller = TextEditingController();
  final List<Map<String, dynamic>> _history = [];
  double _eurAmount = 0;
  double _usdAmount = 0;

  late AnimationController _slideController;

  static const double EUR_RATE = 10.8;
  static const double USD_RATE = 9.9;

  @override
  void initState() {
    super.initState();
    _slideController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _slideController.forward();
    _controller.addListener(_onAmountChanged);
  }

  @override
  void dispose() {
    _controller.dispose();
    _slideController.dispose();
    super.dispose();
  }

  void _onAmountChanged() {
    setState(() {
      final amount = double.tryParse(_controller.text) ?? 0;
      _eurAmount = amount / EUR_RATE;
      _usdAmount = amount / USD_RATE;
    });
  }

  void _convertAndAddToHistory() {
    final amount = double.tryParse(_controller.text) ?? 0;
    if (amount > 0) {
      setState(() {
        _history.insert(0, {
          'amount': amount,
          'eur': amount / EUR_RATE,
          'usd': amount / USD_RATE,
          'timestamp': DateTime.now(),
        });
        if (_history.length > 5) {
          _history.removeLast();
        }
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('✅ Conversion ajoutée à l\'historique'),
          duration: Duration(seconds: 1),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('⚠️ Veuillez entrer un montant'),
        ),
      );
    }
  }

  void _clearAll() {
    setState(() {
      _controller.clear();
      _eurAmount = 0;
      _usdAmount = 0;
      _history.clear();
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('🧹 Tout a été supprimé'),
        duration: Duration(milliseconds: 800),
      ),
    );
  }

  void _shareResult() {
    if (_controller.text.isNotEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            '📋 ${_controller.text} MAD = ${_eurAmount.toStringAsFixed(2)} EUR / ${_usdAmount.toStringAsFixed(2)} USD',
          ),
          action: SnackBarAction(
            label: 'Copié',
            onPressed: () {},
          ),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('⚠️ Entrez d\'abord un montant'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Convertisseur de Devises'),
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () => Scaffold.of(context).openDrawer(),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh_rounded),
            onPressed: _clearAll,
            tooltip: 'Effacer tout',
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Colors.green.shade800,
                      Colors.teal.shade500,
                    ],
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.currency_exchange_rounded,
                      size: 48,
                      color: Colors.white,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Conversion Instantanée',
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'MAD → EUR / USD',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: Colors.white70,
                          ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              Text(
                'Montant en MAD',
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _controller,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                decoration: InputDecoration(
                  hintText: 'Entrez un montant',
                  prefixIcon: const Icon(Icons.attach_money_rounded),
                  suffixText: 'MAD',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(width: 2),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: Colors.grey.shade300,
                      width: 2,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(
                      color: Color(0xFF1976D2),
                      width: 2,
                    ),
                  ),
                  filled: true,
                  fillColor: Colors.grey.shade50,
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 16,
                    horizontal: 16,
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Text(
                'Résultats',
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(0.5, 0),
                  end: Offset.zero,
                ).animate(_slideController),
                child: Row(
                  children: [
                    Expanded(
                      child: _buildResultCard(
                        context,
                        currency: '💶 EUR',
                        amount: _eurAmount,
                        color: Colors.blue,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _buildResultCard(
                        context,
                        currency: '💵 USD',
                        amount: _usdAmount,
                        color: Colors.green,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: _shareResult,
                      icon: const Icon(Icons.share_rounded),
                      label: const Text('Partager'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue.shade600,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: _convertAndAddToHistory,
                      icon: const Icon(Icons.check_rounded),
                      label: const Text('Valider'),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              if (_history.isNotEmpty) ...[
                Text(
                  'Historique (${_history.length}/5)',
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey.shade50,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: Colors.grey.shade200,
                      width: 1,
                    ),
                  ),
                  child: ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: _history.length,
                    separatorBuilder: (context, index) => Divider(
                      height: 1,
                      color: Colors.grey.shade200,
                    ),
                    itemBuilder: (context, index) {
                      final record = _history[index];
                      return Padding(
                        padding: const EdgeInsets.all(12),
                        child: Row(
                          mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${record['amount'].toStringAsFixed(2)} MAD',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge
                                      ?.copyWith(
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                                Text(
                                  _formatTime(record['timestamp']),
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelSmall
                                      ?.copyWith(
                                        color: Colors.grey.shade600,
                                      ),
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  '${record['eur'].toStringAsFixed(2)} EUR',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue.shade600,
                                  ),
                                ),
                                Text(
                                  '${record['usd'].toStringAsFixed(2)} USD',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.green.shade600,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildResultCard(
    BuildContext context, {
    required String currency,
    required double amount,
    required Color color,
  }) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [color.withOpacity(0.1), color.withOpacity(0.05)],
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: color.withOpacity(0.3),
          width: 2,
        ),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            currency,
            style: Theme.of(context)
                .textTheme
                .bodyLarge
                ?.copyWith(fontWeight: FontWeight.bold, color: color),
          ),
          const SizedBox(height: 8),
          Text(
            amount.toStringAsFixed(2),
            style: Theme.of(context)
                .textTheme
                .headlineSmall
                ?.copyWith(fontWeight: FontWeight.bold, color: color),
          ),
        ],
      ),
    );
  }

  String _formatTime(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inMinutes < 1) {
      return 'À l\'instant';
    } else if (difference.inMinutes < 60) {
      return 'Il y a ${difference.inMinutes} min';
    } else {
      return '${dateTime.hour}:${dateTime.minute.toString().padLeft(2, '0')}';
    }
  }
}

// ==================== CITIES PAGE ====================
const List<Map<String, dynamic>> moroccoCities = [
  {
    "name": "Marrakech",
    "image":
        "https://images.unsplash.com/photo-1597212618440-806262de4f6b?w=800&h=600&fit=crop",
    "desc": "Ville rouge",
    "fullDesc":
        "Marrakech est la perle du sud du Maroc, célèbre pour ses riads traditionnels et sa médina animée.",
    "weather": "☀️ 28°C",
    "rating": 4.8,
    "activities": ["Médina", "Souks", "Jardin Majorelle", "Monuments"]
  },
  {
    "name": "Casablanca",
    "image":
        "https://images.unsplash.com/photo-1577147443647-81856d5151af?w=800&h=600&fit=crop",
    "desc": "Capitale économique",
    "fullDesc":
        "Casablanca est la plus grande ville du Maroc, mélange de modernité et de tradition.",
    "weather": "⛅ 22°C",
    "rating": 4.5,
    "activities": ["Mosquée Hassan II", "Corniche", "Shopping", "Vie nocturne"]
  },
  {
    "name": "Fès",
    "image":
        "https://images.unsplash.com/photo-1548013146-72479768bada?w=800&h=600&fit=crop",
    "desc": "Ville historique",
    "fullDesc":
        "Fès est l'une des villes les plus anciennes du monde arabe avec sa médina labyrinthique.",
    "weather": "🌤️ 25°C",
    "rating": 4.7,
    "activities": ["Médina historique", "Tanneries", "Universités anciennes"]
  },
  {
    "name": "Chefchaouen",
    "image":
        "https://images.unsplash.com/photo-1566073771259-6a8506099945?w=800&h=600&fit=crop",
    "desc": "Ville bleue",
    "fullDesc":
        "La célèbre ville bleue du Rif avec ses maisons peintes en bleu pastel.",
    "weather": "🌦️ 20°C",
    "rating": 4.9,
    "activities": ["Photographie", "Randonnée", "Cafés"]
  },
  {
    "name": "Agadir",
    "image":
        "https://images.unsplash.com/photo-1526778548025-fa2f459cd5ce?w=800&h=600&fit=crop",
    "desc": "Ville balnéaire",
    "fullDesc":
        "Agadir est une destination balnéaire moderne avec une magnifique plage.",
    "weather": "☀️ 26°C",
    "rating": 4.6,
    "activities": ["Plages", "Surf", "Restaurants", "Promenades côtières"]
  },
  {
    "name": "Rabat",
    "image":
        "https://images.unsplash.com/photo-1500530855697-b586d89ba3ee?w=800&h=600&fit=crop",
    "desc": "Capitale administrative",
    "fullDesc":
        "Rabat est la capitale du Maroc, connue pour son architecture gouvernementale.",
    "weather": "🌤️ 24°C",
    "rating": 4.4,
    "activities": ["Palais royal", "Musées", "Kasbah"]
  },
  {
    "name": "Tanger",
    "image":
        "https://images.unsplash.com/photo-1512453979798-5ea266f8880c?w=800&h=600&fit=crop",
    "desc": "Nord du Maroc",
    "fullDesc":
        "Tanger est le point de rencontre entre l'Europe et l'Afrique.",
    "weather": "⛅ 21°C",
    "rating": 4.5,
    "activities": ["Casbah", "Plages", "Grottes d'Hercule"]
  },
  {
    "name": "Essaouira",
    "image":
        "https://images.unsplash.com/photo-1476514525535-07fb3b4ae5f1?w=800&h=600&fit=crop",
    "desc": "Ville côtière",
    "fullDesc":
        "Essaouira est une charmante station balnéaire avec un port de pêche pittoresque.",
    "weather": "🌊 23°C",
    "rating": 4.7,
    "activities": ["Plages", "Galeries d'art", "Gastronomie côtière"]
  },
  {
    "name": "Ouarzazate",
    "image":
        "https://images.unsplash.com/photo-1539650116574-75c0c6d73c5f?w=800&h=600&fit=crop",
    "desc": "Porte du désert",
    "fullDesc":
        "Ouarzazate est la porte d'accès au désert du Sahara avec ses kasbah impressionnantes.",
    "weather": "☀️ 30°C",
    "rating": 4.6,
    "activities": ["Kasbah", "Désert", "Studios de cinéma"]
  },
  {
    "name": "Meknès",
    "image":
        "https://images.unsplash.com/photo-1519608487953-e999c86e7455?w=800&h=600&fit=crop",
    "desc": "Ville impériale",
    "fullDesc":
        "Meknès est une ancienne capitale impériale avec ses magnifiques portes.",
    "weather": "🌤️ 24°C",
    "rating": 4.5,
    "activities": ["Médina", "Volubilis", "Monuments historiques"]
  },
];

class CitiesPage extends StatefulWidget {
  const CitiesPage({Key? key}) : super(key: key);

  @override
  State<CitiesPage> createState() => _CitiesPageState();
}

class _CitiesPageState extends State<CitiesPage> {
  final Set<String> _favorites = {};
  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    final filtered = moroccoCities
        .where((city) =>
            city['name']
                .toLowerCase()
                .contains(_searchQuery.toLowerCase()) ||
            city['desc']
                .toLowerCase()
                .contains(_searchQuery.toLowerCase()))
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Découverte des Villes'),
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () => Scaffold.of(context).openDrawer(),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
              decoration: InputDecoration(
                hintText: 'Rechercher une ville...',
                prefixIcon: const Icon(Icons.search_rounded),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(width: 0),
                ),
                filled: true,
                fillColor: Colors.grey.shade100,
                contentPadding: const EdgeInsets.symmetric(vertical: 12),
              ),
            ),
          ),
          Expanded(
            child: filtered.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.location_city_rounded,
                          size: 64,
                          color: Colors.grey.shade300,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Aucune ville trouvée',
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge
                              ?.copyWith(
                                color: Colors.grey.shade600,
                              ),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: filtered.length,
                    itemBuilder: (context, index) {
                      final city = filtered[index];
                      final isFav = _favorites.contains(city['name']);

                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            PageRouteBuilder(
                              pageBuilder: (context, animation,
                                      secondaryAnimation) =>
                                  CityDetailPage(
                                city: city,
                                isFavorite: isFav,
                                onFavoriteChanged: (newValue) {
                                  setState(() {
                                    if (newValue) {
                                      _favorites.add(city['name']);
                                    } else {
                                      _favorites.remove(city['name']);
                                    }
                                  });
                                },
                              ),
                              transitionsBuilder: (context, animation,
                                      secondaryAnimation, child) =>
                                  SlideTransition(
                                position: Tween<Offset>(
                                  begin: const Offset(1, 0),
                                  end: Offset.zero,
                                ).animate(animation),
                                child: child,
                              ),
                            ),
                          );
                        },
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 16),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 8,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Stack(
                            children: [
                              Container(
                                height: 200,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),
                                  color: Colors.grey.shade300,
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(16),
                                  child: Image.network(
                                    city['image'],
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) {
                                      return Container(
                                        color: Colors.grey.shade300,
                                        child: const Center(
                                          child: Icon(Icons.image_not_supported),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                              Container(
                                height: 200,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),
                                  gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                      Colors.transparent,
                                      Colors.black.withOpacity(0.6),
                                    ],
                                  ),
                                ),
                              ),
                              Positioned.fill(
                                child: Padding(
                                  padding: const EdgeInsets.all(16),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                              color: Colors.white
                                                  .withOpacity(0.2),
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                            padding:
                                                const EdgeInsets.symmetric(
                                              horizontal: 10,
                                              vertical: 4,
                                            ),
                                            child: Text(
                                              city['desc'],
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 12,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                if (isFav) {
                                                  _favorites
                                                      .remove(city['name']);
                                                } else {
                                                  _favorites
                                                      .add(city['name']);
                                                }
                                              });
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: Colors.white
                                                    .withOpacity(0.2),
                                                shape: BoxShape.circle,
                                              ),
                                              padding:
                                                  const EdgeInsets.all(8),
                                              child: Icon(
                                                isFav
                                                    ? Icons.favorite_rounded
                                                    : Icons
                                                        .favorite_border_rounded,
                                                color: isFav
                                                    ? Colors.red
                                                    : Colors.white,
                                                size: 24,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            city['name'],
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 24,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          const SizedBox(height: 4),
                                          Row(
                                            children: [
                                              ...List.generate(
                                                5,
                                                (starIndex) => Icon(
                                                  Icons.star_rounded,
                                                  color: starIndex <
                                                          city['rating']
                                                          .toInt()
                                                      ? Colors.amber
                                                      : Colors.white30,
                                                  size: 16,
                                                ),
                                              ),
                                              const SizedBox(width: 8),
                                              Text(
                                                '${city['rating']}',
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
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
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

class CityDetailPage extends StatefulWidget {
  final Map<String, dynamic> city;
  final bool isFavorite;
  final Function(bool) onFavoriteChanged;

  const CityDetailPage({
    Key? key,
    required this.city,
    required this.isFavorite,
    required this.onFavoriteChanged,
  }) : super(key: key);

  @override
  State<CityDetailPage> createState() => _CityDetailPageState();
}

class _CityDetailPageState extends State<CityDetailPage> {
  late bool _isFavorite;

  @override
  void initState() {
    super.initState();
    _isFavorite = widget.isFavorite;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                children: [
                  Image.network(
                    widget.city['image'],
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: Colors.grey.shade300,
                      );
                    },
                  ),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.black.withOpacity(0.2),
                          Colors.black.withOpacity(0.6),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              IconButton(
                onPressed: () {
                  setState(() {
                    _isFavorite = !_isFavorite;
                    widget.onFavoriteChanged(_isFavorite);
                  });
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        _isFavorite
                            ? '❤️ Ajouté aux favoris'
                            : '💔 Retiré des favoris',
                      ),
                      duration: const Duration(milliseconds: 800),
                    ),
                  );
                },
                icon: Icon(
                  _isFavorite
                      ? Icons.favorite_rounded
                      : Icons.favorite_border_rounded,
                  color: _isFavorite ? Colors.red : Colors.white,
                ),
              ),
            ],
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.city['name'],
                            style: Theme.of(context)
                                .textTheme
                                .headlineMedium
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              ...List.generate(
                                5,
                                (index) => Icon(
                                  Icons.star_rounded,
                                  color: index <
                                          widget.city['rating'].toInt()
                                      ? Colors.amber
                                      : Colors.grey.shade300,
                                  size: 18,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                '${widget.city['rating']}',
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.orange.shade100,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                        child: Text(
                          widget.city['weather'],
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'À propos',
                    style: Theme.of(context)
                        .textTheme
                        .headlineSmall
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    widget.city['fullDesc'],
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'Activités recommandées',
                    style: Theme.of(context)
                        .textTheme
                        .headlineSmall
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: List.generate(
                      (widget.city['activities'] as List).length,
                      (index) {
                        final activity =
                            (widget.city['activities'] as List)[index];
                        return Container(
                          decoration: BoxDecoration(
                            color: Colors.blue.shade100,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: Colors.blue.shade300,
                              width: 1,
                            ),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          child: Text(
                            activity,
                            style: TextStyle(
                              color: Colors.blue.shade700,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'Prêt à explorer ${widget.city['name']}? 🚀',
                            ),
                          ),
                        );
                      },
                      icon: const Icon(Icons.explore_rounded),
                      label: const Text('Explorer'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue.shade600,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ==================== ABOUT PAGE ====================
class AboutPage extends StatelessWidget {
  const AboutPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('À propos'),
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () => Scaffold.of(context).openDrawer(),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 200,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.indigo.shade800,
                    Colors.purple.shade500,
                  ],
                ),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Icon(
                        Icons.travel_explore_rounded,
                        size: 48,
                        color: Colors.indigo.shade800,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Morocco Travel Converter',
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall
                          ?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'v1.0.0',
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge
                          ?.copyWith(
                            color: Colors.white70,
                          ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.blue.shade50,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: Colors.blue.shade200,
                        width: 1,
                      ),
                    ),
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'À propos de l\'app',
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'Morocco Travel Converter est une application moderne et intuitive conçue pour les voyageurs. Découvrez les plus belles villes, convertissez vos devises facilement et suivez vos statistiques de voyage en temps réel.',
                          style: Theme.of(context).textTheme.bodyMedium,
                          textAlign: TextAlign.justify,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'Fonctionnalités principales',
                    style: Theme.of(context)
                        .textTheme
                        .headlineSmall
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  _buildFeatureItem(
                    context,
                    icon: Icons.person_rounded,
                    title: 'Profil Voyageur',
                    description: 'Suivez vos statistiques',
                  ),
                  const SizedBox(height: 12),
                  _buildFeatureItem(
                    context,
                    icon: Icons.currency_exchange_rounded,
                    title: 'Convertisseur',
                    description: 'MAD → EUR / USD en temps réel',
                  ),
                  const SizedBox(height: 12),
                  _buildFeatureItem(
                    context,
                    icon: Icons.location_city_rounded,
                    title: 'Villes du Maroc',
                    description: '10 destinations incontournables',
                  ),
                  const SizedBox(height: 12),
                  _buildFeatureItem(
                    context,
                    icon: Icons.favorite_rounded,
                    title: 'Favoris',
                    description: 'Sauvegardez vos destinations',
                  ),
                  const SizedBox(height: 12),
                  _buildFeatureItem(
                    context,
                    icon: Icons.search_rounded,
                    title: 'Recherche',
                    description: 'Trouvez rapidement une ville',
                  ),
                  const SizedBox(height: 24),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.orange.shade50,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: Colors.orange.shade200,
                        width: 1,
                      ),
                    ),
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Technologie',
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 12),
                        _buildTechRow('Framework', 'Flutter'),
                        const SizedBox(height: 8),
                        _buildTechRow('Design', 'Material 3'),
                        const SizedBox(height: 8),
                        _buildTechRow('Police', 'Poppins'),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('✨ Merci d\'utiliser notre app!'),
                            duration: Duration(seconds: 1),
                          ),
                        );
                      },
                      icon: const Icon(Icons.mail_rounded),
                      label: const Text('Nous Contacter'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.indigo.shade600,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Center(
                    child: Column(
                      children: [
                        Text(
                          'Made with ❤️ for travelers',
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.copyWith(
                                color: Colors.grey.shade600,
                              ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '© 2024 Morocco Travel',
                          style: Theme.of(context)
                              .textTheme
                              .labelSmall
                              ?.copyWith(
                                color: Colors.grey.shade500,
                              ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String description,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.grey.shade200,
          width: 1,
        ),
      ),
      padding: const EdgeInsets.all(12),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: Colors.blue.shade100,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: Colors.blue.shade600),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 2),
                Text(
                  description,
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall
                      ?.copyWith(color: Colors.grey.shade600),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTechRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 14,
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: Colors.orange.shade100,
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 4,
          ),
          child: Text(
            value,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 12,
              color: Colors.orange.shade700,
            ),
          ),
        ),
      ],
    );
  }
}