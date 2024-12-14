import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/globalProvider.dart';
import '../provider/language_provider.dart';
import 'login_page.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  static const Color primaryPurple = Color(0xFF6200EE);

  @override
  Widget build(BuildContext context) {
    return Consumer2<Global_provider, LanguageProvider>(
      builder: (context, provider, languageProvider, child) {
        if (!provider.isLoggedIn) {
          return const LoginPage();
        }

        final user = provider.currentUser!;
        return Scaffold(
          appBar: AppBar(
            title: Text(
              languageProvider.translate('profile'),
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            backgroundColor: primaryPurple,
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                // Profile info container
                Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: primaryPurple,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                    ),
                  ),
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
                      const CircleAvatar(
                        radius: 50,
                        backgroundColor: Colors.white,
                        child: Icon(Icons.person, size: 50, color: primaryPurple),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        '${user.name.firstname} ${user.name.lastname}',
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
                // Settings section
                Card(
                  margin: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      ListTile(
                        leading: const Icon(Icons.settings),
                        title: Text(languageProvider.translate('settings')),
                      ),
                      const Divider(),
                      // Language selection
                      ListTile(
                        leading: const Icon(Icons.language),
                        title: Text(languageProvider.translate('language')),
                        trailing: DropdownButton<String>(
                          value: languageProvider.currentLanguageCode,
                          items: [
                            DropdownMenuItem(
                              value: 'en',
                              child: Text(languageProvider.translate('english')),
                            ),
                            DropdownMenuItem(
                              value: 'mn',
                              child: Text(languageProvider.translate('mongolian')),
                            ),
                          ],
                          onChanged: (String? value) {
                            if (value != null) {
                              languageProvider.setLanguage(value);
                            }
                          },
                        ),
                      ),
                      // Logout button
                      ListTile(
                        leading: const Icon(Icons.logout, color: Colors.red),
                        title: Text(
                          languageProvider.translate('logout'),
                          style: const TextStyle(color: Colors.red),
                        ),
                        onTap: () => provider.logout(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildContactItem(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: primaryPurple.withOpacity(0.1), // Icon background өнгө
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: primaryPurple), // Icon өнгө
          ),
          const SizedBox(width: 15),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 14,
                ),
              ),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}