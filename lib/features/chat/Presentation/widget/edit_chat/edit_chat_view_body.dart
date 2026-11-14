import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:link_savw_chat/core/extentions/show_dialoges.dart';
import 'package:link_savw_chat/core/routes/navigation.dart';
import 'package:link_savw_chat/core/services/cloudinary/image_upload.dart';
import 'package:link_savw_chat/features/home/Data/models/category_model.dart';
import 'package:link_savw_chat/features/home/Data/models/chat_model.dart';
import 'package:link_savw_chat/features/home/Presentation/cubit/home_cubit.dart';
import 'package:link_savw_chat/features/home/Presentation/cubit/home_state.dart';
import 'package:link_savw_chat/features/home/Presentation/widget/add_category/add_category_bottom_sheet.dart';
import 'package:link_savw_chat/features/home/Presentation/widget/create_chat/chat_form_fields.dart';

import '../../cubit/chat_cubit.dart';
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

  late String _selectedCategoryId;
  File? _selectedImageFile;
  Uint8List? _selectedImageBytes;
  String? _existingImageUrl;
  final bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.chat.name);
    _descriptionController =
        TextEditingController(text: widget.chat.description);
    _selectedCategoryId = widget.chat.category;
    _existingImageUrl = widget.chat.displayImage;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _onCameraTap() async {
    if (_isLoading) return;

    final hasImage = _selectedImageFile != null ||
        _selectedImageBytes != null ||
        (_existingImageUrl != null && _existingImageUrl!.trim().isNotEmpty);

    final result = await pickChatImage(
      context: context,
      hasImage: hasImage,
    );

    if (result == null || !mounted) return;

    setState(() {
      if (result.isRemoved) {
        _selectedImageFile = null;
        _selectedImageBytes = null;
        _existingImageUrl = null;
      } else {
        _selectedImageFile = result.file;
        _selectedImageBytes = result.bytes;
      }
    });
  }

  Future<void> _onSave() async {
    final name = _nameController.text.trim();
    if (name.isEmpty) {
      showMyDialog(context, 'Please enter a chat name');
      return;
    }

    final localImagePath =
        _selectedImageFile != null ? _selectedImageFile!.path : _existingImageUrl;

    final updatedChat = widget.chat.copyWith(
      name: name,
      description: _descriptionController.text.trim(),
      category: _selectedCategoryId,
      image: localImagePath,
      pendingImagePath: _selectedImageFile?.path,
      clearImage: _selectedImageFile == null && _existingImageUrl == null,
      clearPendingImage: _selectedImageFile == null,
    );

    context
        .read<ChatCubit>()
        .updateChat(updatedChat, newImageFile: _selectedImageFile);

    showMyDialog(
      context,
      'Chat updated successfully',
      type: DialogType.success,
    );
    pop(context, updatedChat);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        final categories = state.categories;
        final selectedIndex =
            categories.findIndexByIdOrName(_selectedCategoryId);

        return Column(
          children: [
            EditChatTopBar(
              onSavePressed: _onSave,
              isLoading: _isLoading,
            ),
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(height: 16.h),
                    ChatFormFields(
                      categories: categories,
                      selectedCategoryIndex: selectedIndex,
                      onCategorySelected: (idx) {
                        setState(() {
                          _selectedCategoryId = categories.findIdByIndex(idx);
                        });
                      },
                      onAddCategory: () =>
                          AddCategoryBottomSheet.show(context),
                      nameController: _nameController,
                      descriptionController: _descriptionController,
                      imageFile: _selectedImageFile,
                      imageBytes: _selectedImageBytes,
                      imageUrl: _existingImageUrl,
                      onCameraTap: _onCameraTap,
                      onNameChanged: (val) => setState(() {}),
                      onDescriptionChanged: (val) => setState(() {}),
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
