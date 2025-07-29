import 'package:flutter/material.dart';
import '../home_page.dart';

class LoadingPage extends StatefulWidget {
  const LoadingPage({super.key});

  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  @override
  void initState() {
    super.initState();

    // Aguarda 4 segundos e navega para a HomePage
    Future.delayed(const Duration(seconds: 4), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const HomePage(title: 'Assistente Médico'),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 146, 201, 218),
      body: Center(
        child: Image.asset(
          'assets/loading.png',
          width: screenWidth,
          height: screenHeight * 120,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
