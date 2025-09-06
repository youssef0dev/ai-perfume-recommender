import '../services/supabase_database_service.dart';
import '../models/database_models.dart';

class DatabaseService {
  static final DatabaseService _instance = DatabaseService._internal();
  factory DatabaseService() => _instance;
  DatabaseService._internal();

  final SupabaseDatabaseService _supabaseService = SupabaseDatabaseService();

  /// Save analysis to Supabase
  Future<String> saveAnalysis(Analysis analysis) async {
    return await _supabaseService.saveAnalysis(analysis);
  }

  /// Get all analyses ordered by timestamp (most recent first)
  Future<List<Analysis>> getAnalyses({int limit = 20}) async {
    return await _supabaseService.getAnalyses(limit: limit);
  }

  /// Get specific analysis by ID
  Future<Analysis?> getAnalysis(String analysisId) async {
    return await _supabaseService.getAnalysis(analysisId);
  }

  /// Stream analyses in real-time
  Stream<List<Analysis>> streamAnalyses({int limit = 20}) {
    return _supabaseService.streamAnalyses(limit: limit);
  }

  /// Delete analysis by ID
  Future<void> deleteAnalysis(String analysisId) async {
    return await _supabaseService.deleteAnalysis(analysisId);
  }

  /// Get analyses count
  Future<int> getAnalysesCount() async {
    return await _supabaseService.getAnalysesCount();
  }

  /// Search analyses by personality traits or perfume types
  Future<List<Analysis>> searchAnalyses({
    String? personalityTrait,
    String? perfumeType,
    int limit = 10,
  }) async {
    return await _supabaseService.searchAnalyses(
      personalityTrait: personalityTrait,
      perfumeType: perfumeType,
      limit: limit,
    );
  }

  /// Get analysis statistics
  Future<Map<String, dynamic>> getAnalysisStatistics() async {
    return await _supabaseService.getAnalysisStatistics();
  }
}