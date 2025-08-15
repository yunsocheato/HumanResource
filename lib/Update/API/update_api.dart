import 'dart:convert';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart' as http;
import '../Model/update_model.dart';

class UpdateGitHubAPI {
  final String githubToken;

  UpdateGitHubAPI({required this.githubToken});

  Future<String?> fetchFileData(UpdateModelGithub model, String filepath) async {
    try {
      final url = Uri.parse(
          'https://api.github.com/repos/${model.repoOwner}/${model.repoName}/contents/$filepath?ref=${model.branch}');
      final response = await http.get(url, headers: {
        'Accept': 'application/vnd.github.v3+json',
        'Authorization': 'token $githubToken',
      });

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final content = utf8.decode(base64Decode(data['content']));
        return content;
      } else {
        Get.snackbar('Error', 'Failed to fetch file data: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      Get.snackbar('Error', 'Exception: $e');
      return null;
    }
  }

  Future<bool> updateFileData(
      UpdateModelGithub model, String filepath, String newContent) async {
    try {
      final fetchUrl = Uri.parse(
          'https://api.github.com/repos/${model.repoOwner}/${model.repoName}/contents/$filepath?ref=${model.branch}');
      final fetchResponse = await http.get(fetchUrl, headers: {
        'Accept': 'application/vnd.github.v3+json',
        'Authorization': 'token $githubToken',
      });

      if (fetchResponse.statusCode != 200) {
        Get.snackbar('Error', 'Cannot fetch file SHA: ${fetchResponse.statusCode}');
        return false;
      }
      final fetchData = jsonDecode(fetchResponse.body);
      final sha = fetchData['sha'];
      final url = fetchUrl;
      final body = jsonEncode({
        'message': 'Update file via Flutter',
        'content': base64Encode(utf8.encode(newContent)),
        'sha': sha,
        'branch': model.branch,
      });
      final response = await http.put(url, headers: {
        'Accept': 'application/vnd.github.v3+json',
        'Authorization': 'token $githubToken',
        'Content-Type': 'application/json',
      }, body: body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        Get.snackbar('Success', 'File updated successfully');
        return true;
      } else {
        Get.snackbar('Error', 'Failed to update file: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      Get.snackbar('Error', 'Exception: $e');
      return false;
    }
  }
}
