import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/GetIt/gi.dart';
import '../../../../../core/extentions/show_dialoges.dart';
import '../../../../../core/utils/colors.dart';
import '../../cubit/home_cubit.dart';
import 'add_category_bottom_sheet_body.dart';

class AddCategoryBottomSheet extends StatefulWidget {
  const AddCategoryBottomSheet({super.key});

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
        child: const AddCategoryBottomSheet(),
      ),
    );
  }

  @override
  State<AddCategoryBottomSheet> createState() => _AddCategoryBottomSheetState();
}

class _AddCategoryBottomSheetState extends State<AddCategoryBottomSheet> {
  late final TextEditingController _nameController;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  Future<void> _onSubmit() async {
    if (_isLoading) return;

    final name = _nameController.text.trim();
    if (name.isEmpty) {
      showMyDialog(context, 'Please enter a category name');
      return;
    }

    setState(() => _isLoading = true);

    try {
      final success = await context.read<HomeCubit>().addCategory(name);
      if (!mounted) return;

      if (success) {
        Navigator.of(context).pop();
      } else {
        final error = context.read<HomeCubit>().state.errorMessage;
        showMyDialog(
          context,
          error ?? 'An error occurred while adding category.',
        );
      }
    } catch (_) {
      if (mounted) {
        showMyDialog(context, 'An error occurred while adding category.');
      }
    } finally {
      if (mounted && _isLoading) {
        setState(() => _isLoading = false);
      }
    }
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
          borderRadius: BorderRadius.vertical(top: Radius.circular(28.r)),
        ),
        child: SafeArea(
          top: false,
          child: AddCategoryBottomSheetBody(
            nameController: _nameController,
            isLoading: _isLoading,
            onClosePressed: () => Navigator.of(context).pop(),
            onSubmitPressed: _onSubmit,
          ),
        ),
      ),
    );
  }
}
