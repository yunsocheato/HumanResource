import 'dart:async';
import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class UpdateController extends GetxController {
  final hasNewUpdate = false.obs;
  final isLoading = false.obs;

  String? latestCommitSha;

  final repoOwner = "yunsocheato";
  final repoName = "HumanResource";
  final branch = "master";

  final githubToken = "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";

  @override
  void onInit() {
    super.onInit();
    checkForUpdate();

    Timer.periodic(const Duration(seconds: 60), (_) => checkForUpdate());
  }

  Future<void> checkForUpdate() async {
    try {
      final url = Uri.parse(
        "https://api.github.com/repos/$repoOwner/$repoName/commits/$branch",
      );

      final headers = {
        "Accept": "application/vnd.github+json",
        if (githubToken.isNotEmpty) "Authorization": "Bearer $githubToken",
      };

      final response = await http.get(url, headers: headers);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        final latestSha = data['sha'];

        if (latestCommitSha != null && latestSha != latestCommitSha) {
          hasNewUpdate.value = true;
        }

        latestCommitSha = latestSha;
      } else {
        print("GitHub API error: ${response.statusCode}");
      }
    } catch (e) {
      print("Update check failed: $e");
    }
  }

  Future<void> fetchAllFiles() async {
    isLoading.value = true;
    await Future.delayed(const Duration(seconds: 2));
    isLoading.value = false;

    hasNewUpdate.value = false;
  }
}
