import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  String selectedLanguage = 'English';
  double fontSize = 16; // Default font size

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
        title: Text(
          'Settings & Contact',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: ListView(
        children: [
          const SizedBox(height: 10),
          _buildDropdownTile(),
          _buildFontSizeSlider(),
          // const Divider(),
          _buildAboutUsTile(),
          _buildAppVersionTile(),
        ],
      ),
    );
  }

  Widget _buildDropdownTile() {
    return ListTile(
      leading: const Icon(Icons.language),
      title: const Text('Language'),
      trailing: DropdownButton<String>(
        value: selectedLanguage,
        items: ['English', 'Khmer']
            .map((lang) => DropdownMenuItem(value: lang, child: Text(lang)))
            .toList(),
        onChanged: (value) {
          setState(() {
            selectedLanguage = value!;
          });
        },
      ),
    );
  }

  Widget _buildFontSizeSlider() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const ListTile(
          leading: Icon(Icons.format_size),
          title: Text('Change Font Size'),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Slider(
                min: 14,
                max: 24,
                divisions: 9,
                value: fontSize,
                label: fontSize.toStringAsFixed(0),
                onChanged: (value) {
                  setState(() {
                    fontSize = value;
                  });
                },
              ),
              // Text(
              //   'Sample Text',
              //   style: TextStyle(fontSize: fontSize),
              // ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildAboutUsTile() {
    return ListTile(
      leading: const Icon(Icons.phone),
      title: const Text('Contact'),
      onTap: () {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Contact'),
              content: const Text(
                'For any inquiries, please reach out to us through the following channels:\n\n'
                'Email: support@yourcompany.com\n'
                'Phone: +1 234 567 890\n'
                'Address: 123 Your Street, City, Country\n\n'
                'We look forward to hearing from you!',
                style: TextStyle(fontSize: 16),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('OK'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  Widget _buildAppVersionTile() {
    return const ListTile(
      leading: Icon(Icons.verified),
      title: Text('App Version'),
      trailing: Text('1.0.0'),
    );
  }
}
