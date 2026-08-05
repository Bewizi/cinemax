import 'package:cinemax/core/theme/app_text_theme.dart';
import 'package:cinemax/core/ui/components/app_button.dart';
import 'package:cinemax/core/ui/components/app_text.dart';
import 'package:cinemax/core/ui/extensions/app_spacing_extension.dart';
import 'package:cinemax/core/ui/layouts/app_scaffold.dart';
import 'package:cinemax/core/variables/app_radius.dart';
import 'package:cinemax/core/variables/app_svgs.dart';
import 'package:cinemax/core/variables/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

class PaymentMethod extends StatefulWidget {
  const PaymentMethod({super.key});

  @override
  State<PaymentMethod> createState() => _PaymentMethodState();
}

class _PaymentMethodState extends State<PaymentMethod> {
  bool isSelected = false;
  int selectedIndex = 0;

  List<Map<String, dynamic>> paymentMethod = [
    {
      'image': AppSvgs.kStreamlineBankRemix,
      'title': 'Bank Transfer',
    },
    {
      'image': AppSvgs.kSimpleIconsGooglepay,
      'title': 'Google Pay',
    },
    {
      'image': AppSvgs.kMagePaypal,
      'title': 'Paypal',
    },
    {
      'image': AppSvgs.kMingcuteBankCardFill,
      'title': 'Credit or Debit Card',
    },
    {
      'image': AppSvgs.kPlus,
      'title': 'Add New Card',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 24),
        child: SizedBox(
          width: MediaQuery.sizeOf(context).width * 0.9,
          child: AppButtonElevated(
            text: selectedIndex == 4 ? 'Next' : 'Make Payment',
            onPressed: () async {
              if (selectedIndex == 4) {
                await context.push('/addCard');
              } else {
                await context.push('/paymentMethod');
              }
            },
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
          'Payment Method',
          style: appTextTheme.titleMedium?.copyWith(
            color: AppColors.kWhite,
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            height: MediaQuery.sizeOf(context).height * 0.8,
            child: ListView.separated(
              separatorBuilder: (context, index) => 24.verticalSpacing,
              itemCount: paymentMethod.length,
              itemBuilder: (context, index) {
                final payment = paymentMethod[index];
                return _buildPayMethodCard(
                  index,
                  payment['image'] as String,
                  payment['title'] as String,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPayMethodCard(int index, String image, String title) {
    final isSelected = selectedIndex == index;

    return GestureDetector(
      onTap: () async {
        setState(() {
          selectedIndex = index;
        });
        if (index == 4) {
          await context.push('/addCard');
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.kMagentaBloom500.withValues(alpha: 0.25)
              : AppColors.kCarbonBlack,
          borderRadius: AppRadius.extraLargeRadius,
          border: BoxBorder.all(
            color: isSelected
                ? AppColors.kWildStrawberry300.withValues(alpha: 0.25)
                : AppColors.kGunmental800,
            width: 2,
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColors.kMagentaBloom500,
                borderRadius: AppRadius.fullRadius,
              ),
              child: SvgPicture.asset(
                image,
                width: 14,
                height: 14,
              ),
            ),
            16.horizontalSpacing,
            AppText(
              title,
              style: appTextTheme.titleMedium?.copyWith(
                fontSize: 18,
                color: AppColors.kWhite,
                fontWeight: FontWeight.w500,
              ),
            ),
            const Spacer(),
            SvgPicture.asset(
              AppSvgs.kChevronRight,
            ),
          ],
        ),
      ),
    );
  }
}
