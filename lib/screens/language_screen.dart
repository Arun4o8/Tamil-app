import 'package:flutter/material.dart';

class LanguageScreen extends StatefulWidget {
  final String currentLanguage;
  final ValueChanged<String> onLanguageChanged;

  const LanguageScreen({
    super.key,
    required this.currentLanguage,
    required this.onLanguageChanged,
  });

  @override
  State<LanguageScreen> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  late String _selected;

  final List<({String code, String name, String native, String flag})> _languages = [
    (code: 'English', name: 'English', native: 'English', flag: '🇬🇧'),
    (code: 'Tamil', name: 'Tamil', native: 'தமிழ்', flag: '🇮🇳'),
  ];

  @override
  void initState() {
    super.initState();
    _selected = widget.currentLanguage;
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Language 🌐', style: TextStyle(fontWeight: FontWeight.w800)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Choose your preferred language for the app.',
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(color: Colors.grey),
            ),
            const SizedBox(height: 20),
            Card(
              child: Column(
                children: _languages.asMap().entries.map((e) {
                  final lang = e.value;
                  final isSelected = _selected == lang.code;
                  return Column(
                    children: [
                      InkWell(
                        borderRadius: e.key == 0
                            ? const BorderRadius.vertical(top: Radius.circular(16))
                            : const BorderRadius.vertical(bottom: Radius.circular(16)),
                        onTap: () {
                          setState(() => _selected = lang.code);
                          widget.onLanguageChanged(lang.code);
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                          child: Row(
                            children: [
                              Text(lang.flag, style: const TextStyle(fontSize: 28)),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(lang.name,
                                        style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 16)),
                                    Text(lang.native,
                                        style: TextStyle(color: Colors.grey.shade500, fontSize: 13)),
                                  ],
                                ),
                              ),
                              if (isSelected)
                                Icon(Icons.check_circle, color: scheme.primary)
                              else
                                Icon(Icons.circle_outlined, color: Colors.grey.shade400),
                            ],
                          ),
                        ),
                      ),
                      if (e.key < _languages.length - 1) const Divider(height: 1, indent: 70),
                    ],
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 20),
            FilledButton(
              onPressed: () => Navigator.pop(context),
              style: FilledButton.styleFrom(
                minimumSize: const Size(double.infinity, 52),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
              ),
              child: const Text('Save Language', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            ),
          ],
        ),
      ),
    );
  }
}
