import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:cross_file/cross_file.dart';
import 'package:flutter/material.dart';
import 'package:hrms/Utils/SnackBar/snack_bar.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/employee_profile_model.dart';

class EmployeeProfilesql {
  final SupabaseClient _supabase = Supabase.instance.client;

  String? get userEmail => _supabase.auth.currentUser?.email;

  Future<List<String>> fetchUsernameSuggestionsEmployeeProfile(
    String query,
  ) async {
    final result = await Supabase.instance.client
        .from('signupuser')
        .select('name')
        .ilike('name', query.isEmpty ? '%' : '%$query%');
    return List<String>.from(result.map((e) => e['name']));
  }

  Future<EmployeeProfileModel?> fetchUserByEmployeeProfile(String name) async {
    final results = await Supabase.instance.client
        .from('signupuser')
        .select()
        .ilike('name', '%$name%')
        .limit(1);

    if (results.isNotEmpty) {
      return EmployeeProfileModel.fromMap(results.first);
    }
    return null;
  }

  Future<EmployeeProfileModel?> getEmployeeProfile() async {
    final email = userEmail;
    if (email == null) {
      print("ERROR: getEmployeeProfile called but currentUser is null!");
      return null;
    }

    final response =
        await _supabase
            .from('signupuser')
            .select()
            .eq('email', email)
            .maybeSingle();

    return response != null ? EmployeeProfileModel.fromMap(response) : null;
  }

  /// Load profile image by email
  Future<String?> loadProfileImage(String email) async {
    final response =
        await _supabase
            .from('signupuser')
            .select('photo_url')
            .eq('email', email)
            .maybeSingle();

    return response?['photo_url'] as String?;
  }

  Future<void> updateUserInfo({
    required String targetUserId,
    required Map<String, dynamic> updates,
  }) async {
    try {
      final sanitizedUpdates = updates.map((key, value) {
        if (value is DateTime) return MapEntry(key, value.toIso8601String());
        return MapEntry(key, value);
      });

      // Check for duplicate email
      if (sanitizedUpdates.containsKey('email')) {
        final existingEmail =
            await _supabase
                .from('signupuser')
                .select('user_id')
                .eq('email', sanitizedUpdates['email'])
                .maybeSingle();

        if (existingEmail != null && existingEmail['user_id'] != targetUserId) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            showAwesomeSnackBarGetx(
              'Error',
              'The email already used',
              ContentType.failure,
            );
          });
          return;
        }
      }

      // Update only
      final response =
          await _supabase
              .from('signupuser')
              .update(sanitizedUpdates)
              .eq('user_id', targetUserId)
              .select();

      if (response.isEmpty) {
        throw Exception('Update failed: User not found or no rows updated.');
      }
    } on PostgrestException catch (e) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        showAwesomeSnackBarGetx(
          'Error',
          'Database Error ${e.message}',
          ContentType.failure,
        );
      });
    } catch (e) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        showAwesomeSnackBarGetx(
          'Failed',
          'Cannot Update The Profiles!',
          ContentType.warning,
        );
      });
    }
  }

  Future<String> uploadImage(XFile file) async {
    try {
      final fileName =
          'photo/${DateTime.now().millisecondsSinceEpoch}_${file.name}';
      final fileBytes = await file.readAsBytes();

      await _supabase.storage
          .from('photo')
          .uploadBinary(
            fileName,
            fileBytes,
            fileOptions: const FileOptions(upsert: true),
          );

      final imageUrl = _supabase.storage.from('photo').getPublicUrl(fileName);
      return imageUrl;
    } catch (e) {
      throw Exception('Upload failed: $e');
    }
  }
}
