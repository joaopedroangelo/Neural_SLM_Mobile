import 'package:flutter/material.dart';
import 'package:flutter_app/screens/settings/settings_page.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter_app/screens/chat/chat_page.dart';
import 'package:flutter_app/screens/consulta/consulta_menu_page.dart';
import 'package:flutter_app/screens/menus/menu_card.dart';
import 'package:flutter_app/screens/menus/menu_item.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});
  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final items = [
      MenuItem('Suas Informações', Icons.person, () {
        // TODO: navegar para Suas Informações
      }),
      MenuItem('Consulta', Icons.medical_services, () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const ConsultaMenuPage()),
        );
      }),
      MenuItem('Chat', Icons.chat, () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const ChatPage()),
        );
      }),
      MenuItem('Histórico', Icons.history, () {
        // TODO: Histórico
      }),
      MenuItem('Configurações', Icons.settings, () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const SettingsPage()),
        );
      }),
      MenuItem('Sobre', Icons.info, () {
        // TODO: Sobre
      }),
    ];

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFE0F7FA), Color(0xFFB2EBF2)],
          ),
        ),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 16,
                ),
                child: Lottie.asset(
                  'assets/heart_dementia_doctor.json',
                  height: 140,
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: GridView.builder(
                    itemCount: items.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 24,
                          crossAxisSpacing: 24,
                          childAspectRatio: 1.1,
                        ),
                    itemBuilder: (context, index) {
                      final item = items[index];
                      return MenuCard(item: item);
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
