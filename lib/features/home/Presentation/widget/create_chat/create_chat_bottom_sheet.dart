import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:link_savw_chat/core/GetIt/gi.dart';
import 'package:link_savw_chat/core/extentions/show_dialoges.dart';
import 'package:link_savw_chat/core/services/cloudinary/image_upload.dart';
import 'package:link_savw_chat/core/utils/colors.dart';
import '../../../Data/models/chat_model.dart';
import '../../cubit/home_cubit.dart';
import 'category_item_data.dart';
import 'create_chat_bottom_sheet_body.dart';
import 'image_source_picker_sheet.dart';

class CreateChatBottomSheet extends StatefulWidget {
  const CreateChatBottomSheet({super.key});

  static Future<void> show(BuildContext context) {
    HomeCubit homeCubit;
    try {
      homeCubit = context.read<HomeCubit>();
    } catch (_) {
      homeCubit = gi<HomeCubit>();
    }
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useRootNavigator: true,
      backgroundColor: AppColors.transparent,
      builder: (_) => BlocProvider.value(
        value: homeCubit,
        child: const CreateChatBottomSheet(),
      ),
    );
  }

  @override
  State<CreateChatBottomSheet> createState() => _CreateChatBottomSheetState();
}

class _CreateChatBottomSheetState extends State<CreateChatBottomSheet> {
  late final TextEditingController _nameController;
  late final TextEditingController _descriptionController;
  final ImagePicker _imagePicker = ImagePicker();

  int _selectedCategoryIndex = 0;
  File? _selectedImage;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _descriptionController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _onCategorySelected(int index) {
    setState(() {
      _selectedCategoryIndex = index;
    });
  }

  Future<void> _onCameraTap() async {
    if (_isLoading) return;

    final option = await ImageSourcePickerSheet.show(
      context: context,
      hasImage: _selectedImage != null,
    );

    if (option == null || !mounted) return;

    if (option == ImageSourceOption.remove) {
      setState(() => _selectedImage = null);
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
        imageQuality: 85,
      );

      if (picked != null && mounted) {
        setState(() => _selectedImage = File(picked.path));
      }
    } catch (_) {
      if (mounted) {
        showMyDialog(context, 'Failed to pick image. Please try again.');
      }
    }
  }

  Future<void> _onSubmit() async {
    if (_isLoading) return;

    final name = _nameController.text.trim();
    if (name.isEmpty) {
      showMyDialog(context, 'Please enter a chat name');
      return;
    }

    setState(() => _isLoading = true);

    try {
      final imageUrl = await _uploadImageIfNeeded();
      if (_selectedImage != null && (imageUrl == null || imageUrl.isEmpty)) {
        return;
      }

      final newChat = _buildChatModel(name: name, imageUrl: imageUrl);

      if (mounted) {
        await context.read<HomeCubit>().addChat(newChat);
      }

      if (mounted) {
        Navigator.of(context).pop();
      }
    } catch (_) {
      if (mounted) {
        showMyDialog(context, 'An error occurred while creating chat.');
      }
    } finally {
      if (mounted && _isLoading) {
        setState(() => _isLoading = false);
      }
    }
  }

  Future<String?> _uploadImageIfNeeded() async {
    if (_selectedImage == null) return null;
    return uploadImageToCloudinary(
      _selectedImage!,
      'dislsl3sa',
      'Chat_Link_Save',
      context,
    );
  }

  ChatModel _buildChatModel({required String name, String? imageUrl}) {
    final selectedCategory =
        CategoryItemData.defaultCategories[_selectedCategoryIndex];
    final description = _descriptionController.text.trim();
    final now = DateTime.now();

    return ChatModel(
      id: '',
      name: name,
      description: description,
      lastMessage: description,
      image: imageUrl,
      color_backgroung_icon: selectedCategory.accentColor.toARGB32(),
      nummessage: 0,
      category: selectedCategory.id,
      date: now,
      datecreateChat: now,
      boolNotification: true,
      boolIsPin: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: isDark ? AppColors.surfaceDark : AppColors.surfaceLight,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(28.r),
          ),
        ),
        child: SafeArea(
          top: false,
          child: CreateChatBottomSheetBody(
            categories: CategoryItemData.defaultCategories,
            selectedIndex: _selectedCategoryIndex,
            onCategorySelected: _onCategorySelected,
            nameController: _nameController,
            descriptionController: _descriptionController,
            imageFile: _selectedImage,
            isLoading: _isLoading,
            onClosePressed: () => Navigator.of(context).pop(),
            onCameraTap: _onCameraTap,
            onSubmitPressed: _onSubmit,
          ),
        ),
      ),
    );
  }
}
