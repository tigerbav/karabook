import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:karabookapp/common/app_colors.dart';
import 'package:karabookapp/common/app_resources.dart';
import 'package:karabookapp/common/utils/utils.dart';
import 'package:karabookapp/common/widgets/arrow_back.dart';
import 'package:karabookapp/common/widgets/primary_button.dart';
import 'package:karabookapp/generated/locale_keys.g.dart';
import 'package:karabookapp/pages/contact_us/data/datasources/contact_us_datasource.dart';
import 'package:karabookapp/pages/contact_us/domain/repositories/contact_us_repository.dart';
import 'package:karabookapp/pages/contact_us/presentation/logic/contact_us_cubit.dart';
import 'package:karabookapp/pages/contact_us/presentation/widgets/files_list_widget.dart';

@RoutePage()
class ContactUsScreen extends StatelessWidget {
  const ContactUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ContactUsCubit(
        ContactUsRepository(ContactUsDataSource()),
      ),
      child: const _ContactUsView(),
    );
  }
}

class _ContactUsView extends StatefulWidget {
  const _ContactUsView();

  @override
  State<_ContactUsView> createState() => _ContactUsState();
}

class _ContactUsState extends State<_ContactUsView> {
  final _controller = TextEditingController();
  final _focus = FocusNode();

  @override
  void dispose() {
    _controller.dispose();
    _focus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    late final cubit = context.read<ContactUsCubit>();

    return BlocListener<ContactUsCubit, ContactUsState>(
      listener: (context, state) {
        if (state.isFailure) {
          Utils.showToast(context, state.errorMessage);
          cubit.resetFailure();
        } //
        else if (state.isSuccess) {
          Utils.showToast(context, LocaleKeys.email_sent.tr(), isError: false);
          cubit.resetFailure();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          leading: const ArrowBack(),
          scrolledUnderElevation: 0,
        ),
        body: SafeArea(
          child: ListView(
            children: [
              Padding(
                padding: EdgeInsets.all(20.sp),
                child: TextField(
                  controller: _controller,
                  focusNode: _focus,
                  maxLines: 15,
                  decoration: InputDecoration(
                    border: _border,
                    disabledBorder: _border,
                    focusedBorder: _border,
                    enabledBorder: _border,
                  ),
                ),
              ),
              const FilesListWidget(),
              Row(
                children: [
                  SizedBox(width: 20.sp),
                  Expanded(
                    child: PrimaryButton(
                      text: LocaleKeys.send.tr(),
                      isBig: true,
                      action: () => cubit.send(_controller.text),
                    ),
                  ),
                  GestureDetector(
                    onTap: cubit.openImagePicker,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 25.sp),
                      child: SvgPicture.asset(AppResources.attach),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  static final _border = OutlineInputBorder(
    borderRadius: BorderRadius.circular(22.sp),
    borderSide: BorderSide(
      width: 1.sp,
      color: AppColors.shared.grey,
    ),
  );
}
