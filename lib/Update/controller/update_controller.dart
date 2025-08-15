import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../API/update_api.dart';
import '../Model/update_model.dart';

class UpdateController extends GetxController{
  final buttonUpdate = true.obs;
  final isLoading = false.obs;
  final hasnewUpdate = false.obs;
  final RxString filecontent = ''.obs ;
  final RxList<Map<String, dynamic>> allFiles = <Map<String, dynamic>>[].obs;


  var Username = 'yunsocheato'.obs;

  var model = UpdateModelGithub(
    repoOwner: 'yunsocheato',
    repoName: 'HumanResource',
    branch: 'master',
  );
  late UpdateGitHubAPI gitHubAPI;
  String? lastcommitsha;

  @override
  void onInit() {
    super.onInit();
    gitHubAPI = UpdateGitHubAPI(
      githubToken: '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'
    );
    Timer.periodic(Duration(minutes: 1), (_) => CheckForUpdate());
  }

  Future<void>CheckForUpdate() async {
    final url = Uri.parse('https://api.github.com/repos/${model.repoOwner}/${model.repoName}/commits');
    try{
      final response = await http.get(url);
      if(response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final latestSha = data['sha'];
        if(latestSha != lastcommitsha){
          lastcommitsha = latestSha;
          hasnewUpdate.value = true;
          Get.snackbar('Update', 'New update available',
              snackPosition: SnackPosition.TOP);
        }
        else{
          hasnewUpdate.value = false;
        }
      }
    } catch(e){
      Get.snackbar('Error', 'Exception: $e');
    }
  }

  Future<void> fetchAllFiles([String path = '']) async {
    isLoading.value = true;
    hasnewUpdate.value = false;
    final url = Uri.parse(
        'https://api.github.com/repos/${model.repoOwner}/${model.repoName}/contents/$path?ref=${model.branch}');
    try {
      final response = await http.get(url, headers: {
        'Authorization':
        'token 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'
      });
      if (response.statusCode == 200) {
        final List data = jsonDecode(response.body);
        for (var item in data) {
          if (item['type'] == 'file') {
            allFiles.add({
              'path': item['path'],
              'download_url': item['download_url'],
            });
          } else if (item['type'] == 'dir') {
            await fetchAllFiles(item['path']);
          }
        }
        Get.snackbar('Update', 'Fetched all files from GitHub',
            snackPosition: SnackPosition.TOP);
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch files: $e',
          snackPosition: SnackPosition.TOP);
    } finally {
      isLoading.value = false;
      update();
    }
  }
}