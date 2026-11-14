import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:link_savw_chat/core/GetIt/gi.dart';
import 'package:link_savw_chat/core/extentions/show_dialoges.dart';
import 'package:link_savw_chat/core/services/cloudinary/image_upload.dart';
import 'package:link_savw_chat/core/utils/colors.dart';

import '../../../Data/models/category_model.dart';
import '../../../Data/models/chat_model.dart';
import '../../cubit/home_cubit.dart';
import '../../cubit/home_state.dart';
import '../add_category/add_category_bottom_sheet.dart';
import 'create_chat_bottom_sheet_body.dart';

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

  int _selectedCategoryIndex = 0;
  File? _selectedImage;
  Uint8List? _selectedImageBytes;
  final bool _isLoading = false;

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

    final result = await pickChatImage(
      context: context,
      hasImage: _selectedImage != null || _selectedImageBytes != null,
    );

    if (result == null || !mounted) return;

    setState(() {
      if (result.isRemoved) {
        _selectedImage = null;
        _selectedImageBytes = null;
      } else {
        _selectedImage = result.file;
        _selectedImageBytes = result.bytes;
      }
    });
  }

  Future<void> _onSubmit(List<CategoryModel> categories) async {
    final name = _nameController.text.trim();
    if (name.isEmpty) {
      showMyDialog(context, 'Please enter a chat name');
      return;
    }

    final newChat = _buildChatModel(
      name: name,
      categories: categories,
    );

    context.read<HomeCubit>().addChat(newChat, imageFile: _selectedImage);
    Navigator.of(context).pop();
  }

  ChatModel _buildChatModel({
    required String name,
    required List<CategoryModel> categories,
  }) {
    final categoryId = categories.findIdByIndex(_selectedCategoryIndex);
    final description = _descriptionController.text.trim();
    final now = DateTime.now();

    return ChatModel(
      id: '',
      name: name,
      description: description,
      lastMessage: description,
      image: null,
      color_backgroung_icon: AppColors.brandBlue.toARGB32(),
      nummessage: 0,
      category: categoryId,
      date: now,
      datecreateChat: now,
      createdAt: now,
      updatedAt: now,
      boolNotification: true,
      boolIsPin: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        final categories = state.categories;
        final selectedIndex = _selectedCategoryIndex >= categories.length
            ? 0
            : _selectedCategoryIndex;

        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Container(
            decoration: BoxDecoration(
              color: isDark ? AppColors.surfaceDark : AppColors.surfaceLight,
              borderRadius: BorderRadius.vertical(top: Radius.circular(28.r)),
            ),
            child: SafeArea(
              top: false,
              child: CreateChatBottomSheetBody(
                categories: categories,
                selectedIndex: selectedIndex,
                onCategorySelected: _onCategorySelected,
                onAddCategory: () => AddCategoryBottomSheet.show(context),
                nameController: _nameController,
                descriptionController: _descriptionController,
                imageFile: _selectedImage,
                imageBytes: _selectedImageBytes,
                isLoading: _isLoading,
                onClosePressed: () => Navigator.of(context).pop(),
                onCameraTap: _onCameraTap,
                onSubmitPressed: () => _onSubmit(categories),
              ),
            ),
          ),
        );
      },
    );
  }
}
