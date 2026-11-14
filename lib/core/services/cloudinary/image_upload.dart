import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:link_savw_chat/core/extentions/show_dialoges.dart';
import 'package:link_savw_chat/features/home/Presentation/widget/create_chat/image_source_picker_sheet.dart';

const String kCloudinaryCloudName = 'dislsl3sa';
const String kCloudinaryUploadPreset = 'Chat_Link_Save';

class ChatImagePickResult {
  final File? file;
  final Uint8List? bytes;
  final bool isRemoved;

  const ChatImagePickResult({
    this.file,
    this.bytes,
    this.isRemoved = false,
  });
}

Future<ChatImagePickResult?> pickChatImage({
  required BuildContext context,
  required bool hasImage,
}) async {
  final option = await ImageSourcePickerSheet.show(
    context: context,
    hasImage: hasImage,
  );

  if (option == null || !context.mounted) return null;

  if (option == ImageSourceOption.remove) {
    return const ChatImagePickResult(isRemoved: true);
  }

  final source = option == ImageSourceOption.camera
      ? ImageSource.camera
      : ImageSource.gallery;

  try {
    final picker = ImagePicker();
    final picked = await picker.pickImage(
      source: source,
      maxWidth: 1024,
      maxHeight: 1024,
      imageQuality: 90,
    );

    if (picked != null && context.mounted) {
      final bytes = await picked.readAsBytes();
      final file = !kIsWeb ? File(picked.path) : null;
      return ChatImagePickResult(file: file, bytes: bytes);
    }
  } catch (_) {
    if (context.mounted) {
      showMyDialog(context, 'Failed to pick image. Please try again.');
    }
  }

  return null;
}

Future<String?> uploadChatImageToCloudinary(
  File imageFile,
  BuildContext context,
) {
  return uploadImageToCloudinary(
    imageFile,
    kCloudinaryCloudName,
    kCloudinaryUploadPreset,
    context,
  );
}

Future<String?> uploadChatImageBackground(File imageFile) async {
  final url = Uri.parse(
    'https://api.cloudinary.com/v1_1/$kCloudinaryCloudName/image/upload',
  );

  final request = http.MultipartRequest('POST', url);
  request.fields['upload_preset'] = kCloudinaryUploadPreset;
  request.files.add(
    await http.MultipartFile.fromPath(
      'file',
      imageFile.path,
    ),
  );

  try {
    final response = await request.send().timeout(
      const Duration(seconds: 30),
    );

    if (response.statusCode == 200) {
      final responseBody = await response.stream.bytesToString();
      final responseData = json.decode(responseBody);
      return responseData['secure_url'] as String?;
    }
    return null;
  } catch (e) {
    log('Cloudinary background upload exception: $e');
    return null;
  }
}

Future<String?> resolveChatImageUrl({
  required BuildContext context,
  required File? newImageFile,
  required String? existingImageUrl,
}) async {
  if (newImageFile != null) {
    return uploadChatImageToCloudinary(newImageFile, context);
  }
  return existingImageUrl;
}

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
