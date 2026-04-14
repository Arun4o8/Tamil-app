import 'package:flutter/material.dart';

class SupportScreen extends StatelessWidget {
  const SupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Support 💬', style: TextStyle(fontWeight: FontWeight.w800)),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Contact card
          Card(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: scheme.primaryContainer,
                        child: Icon(Icons.headset_mic, color: scheme.primary),
                      ),
                      const SizedBox(width: 12),
                      Text('Contact Support',
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(fontWeight: FontWeight.w800)),
                    ],
                  ),
                  const SizedBox(height: 16),
                  _contactTile(context, Icons.email, 'Email', 'support@xrtamil.com', Colors.blue),
                  const SizedBox(height: 12),
                  _contactTile(context, Icons.phone, 'Phone', '+91 98765 43210', Colors.green),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          // FAQs card
          Card(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.amber.withAlpha(30),
                        child: const Icon(Icons.help_outline, color: Colors.amber),
                      ),
                      const SizedBox(width: 12),
                      Text('FAQs',
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(fontWeight: FontWeight.w800)),
                    ],
                  ),
                  const SizedBox(height: 16),
                  _faqItem(
                    context,
                    q: 'How do I start training?',
                    a: 'Select a dance form from the Explore tab and tap "Step-by-Step Training".',
                  ),
                  const Divider(height: 24),
                  _faqItem(
                    context,
                    q: 'Is a VR headset required?',
                    a: 'No. You can use AR View directly on your mobile phone camera.',
                  ),
                  const Divider(height: 24),
                  _faqItem(
                    context,
                    q: 'Can I use the app offline?',
                    a: 'Yes! All cultural data and training steps work without an internet connection.',
                  ),
                  const Divider(height: 24),
                  _faqItem(
                    context,
                    q: 'How are quiz scores saved?',
                    a: 'Scores are tracked locally. Progress saving across sessions will be in the next update.',
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _contactTile(BuildContext context, IconData icon, String label, String value, Color color) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(color: color.withAlpha(20), shape: BoxShape.circle),
          child: Icon(icon, color: color, size: 20),
        ),
        const SizedBox(width: 14),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: TextStyle(fontSize: 12, color: Colors.grey.shade500, fontWeight: FontWeight.w500)),
            Text(value, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700)),
          ],
        ),
      ],
    );
  }

  Widget _faqItem(BuildContext context, {required String q, required String a}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(q,
            style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 14, color: Color(0xFF2C3E50))),
        const SizedBox(height: 6),
        Text(a,
            style: TextStyle(fontSize: 13, color: Colors.grey.shade600, height: 1.5)),
      ],
    );
  }
}
