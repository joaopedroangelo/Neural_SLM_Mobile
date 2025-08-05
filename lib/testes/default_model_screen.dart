import 'package:flutter/material.dart';
import 'package:flutter_app/testes/avaliable_models.dart';
import 'package:flutter_app/testes/model_download.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DefaultModelSelectorScreen extends StatefulWidget {
  const DefaultModelSelectorScreen({super.key});

  @override
  State<DefaultModelSelectorScreen> createState() =>
      _DefaultModelSelectorScreenState();
}

class _DefaultModelSelectorScreenState
    extends State<DefaultModelSelectorScreen> {
  late Future<List<Model>> _downloadedModelsFuture;

  @override
  void initState() {
    super.initState();
    _downloadedModelsFuture = _getDownloadedModels();
  }

  Future<List<Model>> _getDownloadedModels() async {
    final token = await ModelDownloadService(
      modelUrl: '',
      modelFilename: '',
      licenseUrl: '',
    ).loadToken();

    List<Model> downloadedModels = [];

    for (final model in Model.values) {
      final service = ModelDownloadService(
        modelUrl: model.url,
        modelFilename: model.filename,
        licenseUrl: model.licenseUrl,
      );

      final exists = await service.checkModelExistence(token ?? '');
      if (exists) {
        downloadedModels.add(model);
      }
    }

    return downloadedModels;
  }

  Future<void> _setDefaultModel(Model model) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('default_model', model.name);
    if (context.mounted) {
      Navigator.pop(context, model);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Selecionar Modelo Padrão')),
      body: FutureBuilder<List<Model>>(
        future: _downloadedModelsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text('Nenhum modelo baixado encontrado.'),
            );
          }

          final models = snapshot.data!;
          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: models.length,
            separatorBuilder: (_, __) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              final model = models[index];
              return ListTile(
                title: Text(model.displayName),
                subtitle: Text(model.filename),
                leading: const Icon(Icons.model_training),
                onTap: () => _setDefaultModel(model),
              );
            },
          );
        },
      ),
    );
  }
}
