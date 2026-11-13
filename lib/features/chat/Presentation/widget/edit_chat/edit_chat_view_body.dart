import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:link_savw_chat/core/extentions/show_dialoges.dart';
import 'package:link_savw_chat/core/routes/navigation.dart';
import 'package:link_savw_chat/core/services/cloudinary/image_upload.dart';
import 'package:link_savw_chat/features/home/Data/models/chat_model.dart';
import 'package:link_savw_chat/features/home/Presentation/cubit/home_cubit.dart';
import 'package:link_savw_chat/features/home/Presentation/cubit/home_state.dart';
import 'package:link_savw_chat/features/home/Presentation/widget/add_category/add_category_bottom_sheet.dart';
import 'package:link_savw_chat/features/home/Presentation/widget/create_chat/image_source_picker_sheet.dart';

import 'edit_chat_avatar_preview.dart';
import 'edit_chat_categories_section.dart';
import 'edit_chat_description_card.dart';
import 'edit_chat_name_card.dart';
import 'edit_chat_top_bar.dart';

class EditChatViewBody extends StatefulWidget {
  final ChatModel chat;

  const EditChatViewBody({super.key, required this.chat});

  @override
  State<EditChatViewBody> createState() => _EditChatViewBodyState();
}

class _EditChatViewBodyState extends State<EditChatViewBody> {
  late final TextEditingController _nameController;
  late final TextEditingController _descriptionController;
  final ImagePicker _imagePicker = ImagePicker();

  late String _selectedCategoryId;
  File? _selectedImageFile;
  Uint8List? _selectedImageBytes;
  String? _existingImageUrl;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.chat.name);
    _descriptionController = TextEditingController(
      text: widget.chat.description,
    );
    _selectedCategoryId = widget.chat.category;
    _existingImageUrl = widget.chat.image;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _onCameraTap() async {
    if (_isLoading) return;

    final hasImage =
        _selectedImageFile != null ||
        _selectedImageBytes != null ||
        (_existingImageUrl != null && _existingImageUrl!.trim().isNotEmpty);

    final option = await ImageSourcePickerSheet.show(
      context: context,
      hasImage: hasImage,
    );

    if (option == null || !mounted) return;

    if (option == ImageSourceOption.remove) {
      setState(() {
        _selectedImageFile = null;
        _selectedImageBytes = null;
        _existingImageUrl = null;
      });
      return;
    }

    final source = option == ImageSourceOption.camera
        ? ImageSource.camera
        : ImageSource.gallery;

    await _pickImage(source);
  }

  Future<void> _pickImage(ImageSource source) async {
    try {
      final picked = await _imagePicker.pickImage(
        source: source,
        maxWidth: 1024,
        maxHeight: 1024,
        imageQuality: 90,
      );

      if (picked != null && mounted) {
        final bytes = await picked.readAsBytes();
        setState(() {
          _selectedImageBytes = bytes;
          if (!kIsWeb) {
            _selectedImageFile = File(picked.path);
          }
        });
      }
    } catch (_) {
      if (mounted) {
        showMyDialog(context, 'Failed to pick image. Please try again.');
      }
    }
  }

  void _onCategorySelected(String categoryId) {
    setState(() {
      _selectedCategoryId = categoryId;
    });
  }

  Future<void> _onSave() async {
    if (_isLoading) return;

    final name = _nameController.text.trim();
    if (name.isEmpty) {
      showMyDialog(context, 'Please enter a chat name');
      return;
    }

    setState(() => _isLoading = true);

    try {
      String? finalImageUrl;

      if (_selectedImageFile != null) {
        final uploadedUrl = await uploadImageToCloudinary(
          _selectedImageFile!,
          'dislsl3sa',
          'Chat_Link_Save',
          context,
        );
        if (uploadedUrl == null || uploadedUrl.isEmpty) {
          if (mounted) {
            setState(() => _isLoading = false);
          }
          return;
        }
        finalImageUrl = uploadedUrl;
      } else {
        finalImageUrl = _existingImageUrl;
      }

      final updatedChat = widget.chat.copyWith(
        name: name,
        description: _descriptionController.text.trim(),
        category: _selectedCategoryId,
        image: finalImageUrl,
      );

      if (!mounted) return;

      final homeCubit = context.read<HomeCubit>();
      final success = await homeCubit.updateChat(updatedChat);

      if (!mounted) return;

      setState(() => _isLoading = false);

      if (success) {
        showMyDialog(
          context,
          'Chat updated successfully',
          type: DialogType.success,
        );
        pop(context, updatedChat);
      } else {
        final error = homeCubit.state.errorMessage;
        showMyDialog(
          context,
          error ?? 'Failed to update chat',
          type: DialogType.error,
        );
      }
    } catch (_) {
      if (mounted) {
        setState(() => _isLoading = false);
        showMyDialog(
          context,
          'An error occurred while updating chat',
          type: DialogType.error,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        final categories = state.categories;

        return Column(
          children: [
            EditChatTopBar(onSavePressed: _onSave, isLoading: _isLoading),
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(height: 16.h),
                    EditChatAvatarPreview(
                      imageBytes: _selectedImageBytes,
                      imageFile: _selectedImageFile,
                      imageUrl: _existingImageUrl,
                      onCameraTap: _onCameraTap,
                    ),
                    SizedBox(height: 22.h),
                    EditChatNameCard(
                      controller: _nameController,
                      onChanged: (val) => setState(() {}),
                    ),
                    SizedBox(height: 14.h),
                    EditChatDescriptionCard(
                      controller: _descriptionController,
                      onChanged: (val) => setState(() {}),
                    ),
                    SizedBox(height: 18.h),
                    EditChatCategoriesSection(
                      categories: categories,
                      selectedCategoryId: _selectedCategoryId,
                      onCategorySelected: _onCategorySelected,
                      onAddCategory: () => AddCategoryBottomSheet.show(context),
                    ),
                    SizedBox(height: 36.h),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
