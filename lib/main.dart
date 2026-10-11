import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

void main() {
  runApp(const CosmicExplorerApp());
}

class Planet {
  final String name;
  final String type;
  final String description;

  const Planet({
    required this.name,
    required this.type,
    required this.description,
  });
}

class PlanetCatalog {
  static const List<Planet> planets = [
    Planet(
      name: 'Mercury',
      type: 'Terrestrial',
      description:
      'Mercury is the smallest planet in our solar system and the closest to the Sun.',
    ),
    Planet(
      name: 'Mars',
      type: 'Terrestrial',
      description:
      'Mars is known as the Red Planet because of its reddish surface. It has two small moons.',
    ),
    Planet(
      name: 'Jupiter',
      type: 'Gas Giant',
      description:
      'Jupiter is the largest planet in our solar system. It is known for its Great Red Spot.',
    ),
    Planet(
      name: 'Kepler-186f',
      type: 'Terrestrial Exoplanet',
      description:
      'Kepler-186f is an exoplanet orbiting a red dwarf star approximately 500 light-years from Earth.',
    ),
    Planet(
      name: 'Proxima Centauri b',
      type: 'Terrestrial Exoplanet',
      description:
      'Proxima Centauri b is an exoplanet orbiting Proxima Centauri, the closest star to our Sun.',
    ),
  ];
}

final GoRouter myRouter = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const MissionControl(),
    ),
    GoRoute(
      path: '/docking-bay',
      builder: (context, state) => const DockingBay(),
    ),
    GoRoute(
      path: '/planet/:id',
      builder: (context, state) {
        final id = int.parse(state.pathParameters['id']!);
        final planet = PlanetCatalog.planets[id];

        return PlanetDetail(planet: planet);
      },
    ),
  ],
);

class CosmicExplorerApp extends StatelessWidget {
  const CosmicExplorerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: myRouter,
    );
  }
}

class MissionControl extends StatelessWidget {
  const MissionControl({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cosmic Explorer - Mission Control'),
      ),
      body: ListView.builder(
        itemCount: PlanetCatalog.planets.length,
        itemBuilder: (context, index) {
          final planet = PlanetCatalog.planets[index];

          return ListTile(
            title: Text(planet.name),
            subtitle: Text(planet.type),
            trailing: const Icon(Icons.chevron_right),
            onTap: () async {
              final result = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PlanetDetail(planet: planet),
                ),
              );

              if (!context.mounted) return;

              if (result != null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(result)),
                );
              }
            },
          );
        },
      ),
    );
  }
}

class PlanetDetail extends StatelessWidget {
  final Planet planet;

  const PlanetDetail({
    super.key,
    required this.planet,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(planet.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            Text(
              planet.type,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            Text(
              planet.description,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(
                  context,
                  'You visited ${planet.name}!',
                );
              },
              child: const Text('Confirm Visit'),
            ),
          ],
        ),
      ),
    );
  }
}

class DockingBay extends StatelessWidget {
  const DockingBay({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Docking Bay Telemetry'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            context.go('/');
          },
          child: const Text('Return to Mission Control'),
        ),
      ),
    );
  }
}