import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import '../../../features/home/home_page.dart';

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
    // Usa um loading animado da biblioteca
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 146, 201, 218),
      body: Center(
        child: LoadingAnimationWidget.inkDrop(
          color: Colors.white,
          size: MediaQuery.of(context).size.width * 0.2,
        ),
      ),
    );
  }
}
