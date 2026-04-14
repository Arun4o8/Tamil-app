import 'package:google_mlkit_translation/google_mlkit_translation.dart';

class TranslatorService {
  static final TranslatorService _instance = TranslatorService._internal();
  factory TranslatorService() => _instance;
  TranslatorService._internal();

  final _modelManager = OnDeviceTranslatorModelManager();
  bool _isTamilDownloaded = false;
  OnDeviceTranslator? _translator;

  Future<void> init() async {
    _isTamilDownloaded = await _modelManager.isModelDownloaded(TranslateLanguage.tamil.bcpCode);
    if (!_isTamilDownloaded) {
      // Download model dynamically if it doesn't exist
      await _modelManager.downloadModel(TranslateLanguage.tamil.bcpCode);
      _isTamilDownloaded = true;
    }
    
    _translator = OnDeviceTranslator(
      sourceLanguage: TranslateLanguage.english,
      targetLanguage: TranslateLanguage.tamil,
    );
  }

  Future<String> translateBlock(String text) async {
    // If not initialized, initialize and download model first
    if (_translator == null) {
      await init();
    }
    try {
      if (text.trim().isEmpty) return text;
      // The ML Kit handles the actual string translation natively
      return await _translator!.translateText(text);
    } catch (e) {
      return text; // Safe fallback
    }
  }

  void dispose() {
    _translator?.close();
  }
}

// Global instance for easy access
final mlTranslator = TranslatorService();
