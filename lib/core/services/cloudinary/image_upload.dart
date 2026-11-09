import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:link_savw_chat/core/extentions/show_dialoges.dart';

Future<String?> uploadImageToCloudinary(
  File imageFile,
  String cloudName,
  String uploadPreset,
  BuildContext context,
) async {
  final url = Uri.parse(
    'https://api.cloudinary.com/v1_1/$cloudName/image/upload',
  );

  final request = http.MultipartRequest('POST', url);
  request.fields['upload_preset'] = uploadPreset;
  request.files.add(
    await http.MultipartFile.fromPath(
      'file',
      imageFile.path,
    ),
  );

  try {
    final response = await request.send().timeout(
      const Duration(seconds: 25),
    );

    if (response.statusCode == 200) {
      final responseBody = await response.stream.bytesToString();
      final responseData = json.decode(responseBody);
      log('responseData: $responseData');
      return responseData['secure_url'];
    } else {
      final responseBody = await response.stream.bytesToString();
      log('Cloudinary upload error (${response.statusCode}): $responseBody');
      if (context.mounted) {
        showMyDialog(context, 'Failed to upload image. Please try again.');
      }
      return null;
    }
  } catch (e) {
    log('Cloudinary upload exception: $e');
    if (context.mounted) {
      showMyDialog(context, 'Failed to upload image. Please try again.');
    }
    return null;
  }
}
