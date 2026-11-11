import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
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
  Uint8List? _selectedImageBytes;
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
      hasImage: _selectedImage != null || _selectedImageBytes != null,
    );

    if (option == null || !mounted) return;

    if (option == ImageSourceOption.remove) {
      setState(() {
        _selectedImage = null;
        _selectedImageBytes = null;
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
            _selectedImage = File(picked.path);
          }
        });
      }
    } catch (_) {
      if (mounted) {
        showMyDialog(context, 'Failed to pick image. Please try again.');
      }
    }
  }

  Future<void> _onSubmit(List<CategoryModel> categories) async {
    if (_isLoading) return;

    final name = _nameController.text.trim();
    if (name.isEmpty) {
      showMyDialog(context, 'Please enter a chat name');
      return;
    }

    setState(() => _isLoading = true);

    try {
      final imageUrl = await _uploadImageIfNeeded();
      if ((_selectedImage != null || _selectedImageBytes != null) &&
          (imageUrl == null || imageUrl.isEmpty)) {
        if (mounted) {
          setState(() => _isLoading = false);
        }
        return;
      }

      final newChat = _buildChatModel(
        name: name,
        imageUrl: imageUrl,
        categories: categories,
      );

      if (!mounted) return;

      final success = await context.read<HomeCubit>().addChat(newChat);

      if (!mounted) return;

      if (success) {
        Navigator.of(context).pop();
      } else {
        final error = context.read<HomeCubit>().state.errorMessage;
        showMyDialog(
          context,
          error ?? 'An error occurred while creating chat.',
        );
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

  ChatModel _buildChatModel({
    required String name,
    String? imageUrl,
    required List<CategoryModel> categories,
  }) {
    final categoryId = categories.isNotEmpty &&
            _selectedCategoryIndex < categories.length
        ? categories[_selectedCategoryIndex].id
        : 'all';
    final description = _descriptionController.text.trim();
    final now = DateTime.now();

    return ChatModel(
      id: '',
      name: name,
      description: description,
      lastMessage: description,
      image: imageUrl,
      color_backgroung_icon: AppColors.brandBlue.toARGB32(),
      nummessage: 0,
      category: categoryId,
      date: now,
      datecreateChat: now,
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
