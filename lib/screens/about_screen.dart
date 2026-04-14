import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const saffron = Color(0xFFE65100);
    const teal = Color(0xFF00897B);

    return Scaffold(
      appBar: AppBar(
        title: const Text('About Us', style: TextStyle(fontWeight: FontWeight.w800)),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // App logo card
          Card(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  Container(
                    width: 90, height: 90,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [saffron, Color(0xFFFF8F00)],
                        begin: Alignment.topLeft, end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(22),
                    ),
                    child: const Center(child: Text('🎭', style: TextStyle(fontSize: 48))),
                  ),
                  const SizedBox(height: 16),
                  Text('XR Tamil KIDS',
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall!
                          .copyWith(fontWeight: FontWeight.w900, color: saffron)),
                  const SizedBox(height: 6),
                  Text('Version 1.0.0',
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(color: Colors.grey)),
                  const SizedBox(height: 10),
                  Text(
                    'An immersive XR learning app to explore Tamil Nadu\'s rich cultural heritage for students in grades 2–8.',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.grey.shade700, height: 1.5),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Team card
          Card(
            child: Column(
              children: [
                ListTile(
                  leading: CircleAvatar(
                    backgroundColor: saffron.withAlpha(20),
                    child: const Icon(Icons.business, color: saffron),
                  ),
                  title: const Text('Created By', style: TextStyle(fontWeight: FontWeight.w700, color: Colors.grey)),
                  subtitle: const Text('e16 ai', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 16)),
                ),
                const Divider(height: 1, indent: 72),
                ListTile(
                  leading: CircleAvatar(
                    backgroundColor: teal.withAlpha(20),
                    child: const Icon(Icons.school, color: teal),
                  ),
                  title: const Text('Mentor', style: TextStyle(fontWeight: FontWeight.w700, color: Colors.grey)),
                  subtitle: const Text('Dharaneesh AM', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 16)),
                ),
                const Divider(height: 1, indent: 72),
                ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.purple.withAlpha(20),
                    child: const Icon(Icons.code, color: Colors.purple),
                  ),
                  title: const Text('Developers', style: TextStyle(fontWeight: FontWeight.w700, color: Colors.grey)),
                  subtitle: const Text('Deepak.P & Arun.P', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 16)),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // Contact card
          Card(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('📬 Contact',
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .copyWith(fontWeight: FontWeight.w800)),
                  const SizedBox(height: 14),
                  _contactRow(Icons.email, 'support@xrtamil.com', Colors.blue),
                  const SizedBox(height: 10),
                  _contactRow(Icons.phone, '+91 98765 43210', Colors.green),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _contactRow(IconData icon, String text, Color color) {
    return Row(
      children: [
        Icon(icon, color: color, size: 20),
        const SizedBox(width: 12),
        Text(text, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
      ],
    );
  }
}
