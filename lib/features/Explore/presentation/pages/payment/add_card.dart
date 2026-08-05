import 'package:cinemax/core/router/app_router.dart';
import 'package:cinemax/core/theme/app_text_theme.dart';
import 'package:cinemax/core/ui/components/app_button.dart';
import 'package:cinemax/core/ui/components/app_text.dart';
import 'package:cinemax/core/ui/components/app_textfield.dart';
import 'package:cinemax/core/ui/extensions/app_spacing_extension.dart';
import 'package:cinemax/core/ui/layouts/app_scaffold.dart';
import 'package:cinemax/core/variables/app_svgs.dart';
import 'package:cinemax/core/variables/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

class AddCard extends StatefulWidget {
  const AddCard({super.key});

  @override
  State<AddCard> createState() => _AddCardState();
}

class _AddCardState extends State<AddCard> {
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 24),
        child: SizedBox(
          width: MediaQuery.sizeOf(context).width * 0.9,
          child: AppButtonElevated(
            text: 'Add Card',
            onPressed: () => SuccessfulPaymentRoute().go(context),
          ),
        ),
      ),
      appbar: AppBar(
        backgroundColor: AppColors.kTransparent,
        elevation: 0,
        leading: IconButton(
          icon: SvgPicture.asset(AppSvgs.kChevronLeft),
          onPressed: () => context.pop(),
        ),
        centerTitle: true,
        title: AppText(
          'Add New Card',
          style: appTextTheme.titleMedium?.copyWith(
            color: AppColors.kWhite,
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
        ),
      ),
      body: Column(
        children: [
          Form(
            child: Column(
              children: [
                AddNewCardTextField(
                  title: 'Card Name',
                  showTitle: true,
                  hintText: 'Enter Card Name',
                ),
                16.verticalSpacing,
                AddNewCardTextField(
                  title: 'Card Number',
                  showTitle: true,
                  hintText: 'Enter Card Number',
                ),
                16.verticalSpacing,
                Row(
                  children: [
                    Expanded(
                      child: AddNewCardTextField(
                        title: 'Exp. Date',
                        showTitle: true,
                        hintText: 'MM/YY',
                      ),
                    ),
                    16.horizontalSpacing,
                    Expanded(
                      child: AddNewCardTextField(
                        title: 'cvv',
                        showTitle: true,
                        hintText: '123',
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
