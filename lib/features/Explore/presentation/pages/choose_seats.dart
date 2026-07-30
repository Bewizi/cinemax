import 'package:cinemax/core/theme/app_text_theme.dart';
import 'package:cinemax/core/ui/components/app_button.dart';
import 'package:cinemax/core/ui/components/app_text.dart';
import 'package:cinemax/core/ui/extensions/app_spacing_extension.dart';
import 'package:cinemax/core/ui/layouts/app_scaffold.dart';
import 'package:cinemax/core/variables/app_radius.dart';
import 'package:cinemax/core/variables/app_svgs.dart';
import 'package:cinemax/core/variables/colors.dart';
import 'package:cinemax/features/Explore/presentation/widgets/date_selector/date_item.dart';
import 'package:cinemax/features/Explore/presentation/widgets/screen_glow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class ChooseSeats extends StatefulWidget {
  const ChooseSeats({super.key});

  @override
  State<ChooseSeats> createState() => _ChooseSeatsState();
}

class _ChooseSeatsState extends State<ChooseSeats> {
  final List<bool> selectedSeats = List.generate(31, (_) => false);
  final List<bool> selectedTime = List.generate(6, (_) => false);

  late List<DateItem> dates;

  int selectedTimeIndex = 0;

  final weekDays = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday',
  ];

  final months = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December',
  ];

  final showTime = [
    '12:00pm',
    '2:00pm',
    '4:00pm',
    '6:00pm',
    '8:00pm,',
    '10:00pm',
  ];

  @override
  void initState() {
    super.initState();

    final now = DateTime.now();

    dates = List.generate(
      12,
      (index) => DateItem(
        date: now.add(Duration(days: index)),
        isSelected: index == 0,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 24),
        child: SizedBox(
          width: MediaQuery.sizeOf(context).width * 0.9,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: AppRadius.extraLargeRadius,
              boxShadow: [
                BoxShadow(
                  color: AppColors.kWildStrawberry300.withValues(alpha: 0.25),
                  blurRadius: 10,
                  spreadRadius: 6,
                ),
              ],
            ),
            child: AppButtonElevated(
              text: 'Proceed to Checkout',
              onPressed: () => context.push('/paymentCheckout'),
            ),
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
          'Choose Seats',
          style: appTextTheme.titleMedium?.copyWith(
            color: AppColors.kWhite,
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 41),
              child: AppText(
                'Create your experience',
                style: appTextTheme.titleMedium?.copyWith(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: AppColors.kWhite,
                ),
              ),
            ),
            16.verticalSpacing,

            const Divider(
              height: 20,
              thickness: 5,
              indent: 20,
              endIndent: 0,
              color: AppColors.kMagentaBloom500,
            ),
            const ScreenGlow(),
            136.verticalSpacing,
            Padding(
              padding: const EdgeInsets.only(bottom: 128),
              child: Column(
                crossAxisAlignment: .start,
                children: [
                  Wrap(
                    spacing: 2,
                    runSpacing: 2,
                    children: List.generate(
                      selectedSeats.length,
                      _buildSeat,
                    ),
                  ),
                  16.verticalSpacing,
                  _buildAvialbeAndTakenSeats(),
                  16.verticalSpacing,
                  // date selector
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppText(
                        'Select Date',
                        style: appTextTheme.titleMedium?.copyWith(
                          color: AppColors.kWhite,
                          fontWeight: FontWeight.w500,
                          fontSize: 18,
                        ),
                      ),
                      16.verticalSpacing,
                      Wrap(
                        spacing: 10,
                        runSpacing: 10,
                        children: List.generate(
                          dates.length,
                          _buildDateCard,
                        ),
                      ),
                    ],
                  ),

                  // time selector
                  16.verticalSpacing,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppText(
                        'Select Showtime',
                        style: appTextTheme.titleMedium?.copyWith(
                          color: AppColors.kWhite,
                          fontWeight: FontWeight.w500,
                          fontSize: 18,
                        ),
                      ),
                      16.verticalSpacing,
                      Wrap(
                        spacing: 10,
                        runSpacing: 10,
                        children: List.generate(
                          showTime.length,
                          (index) => _buildTimeCard(index, showTime[index]),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSeat(int index) {
    return IconButton(
      onPressed: () {
        setState(() {
          selectedSeats[index] = !selectedSeats[index];
        });
      },
      icon: SvgPicture.asset(
        AppSvgs.kChairIcon,
        colorFilter: ColorFilter.mode(
          selectedSeats[index]
              ? AppColors.kMagentaBloom500
              : AppColors.kCharcoal700,
          BlendMode.srcIn,
        ),
      ),
    );
  }

  Widget _buildAvialbeAndTakenSeats() {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 19, vertical: 8),
          decoration: BoxDecoration(
            color: AppColors.kCarbonBlack,
            borderRadius: AppRadius.mediumRadius,
          ),
          child: Row(
            children: [
              SvgPicture.asset(
                AppSvgs.kIcRoundEventSeat,
                colorFilter: const ColorFilter.mode(
                  AppColors.kMagentaBloom500,
                  BlendMode.srcIn,
                ),
              ),
              8.horizontalSpacing,
              AppText(
                'Available',
                style: appTextTheme.titleMedium?.copyWith(
                  color: AppColors.kWhite,
                ),
              ),
            ],
          ),
        ),
        12.horizontalSpacing,
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 19, vertical: 8),
          decoration: BoxDecoration(
            color: AppColors.kCarbonBlack,
            borderRadius: AppRadius.mediumRadius,
          ),
          child: Row(
            children: [
              SvgPicture.asset(
                AppSvgs.kIcRoundEventSeat,
                colorFilter: const ColorFilter.mode(
                  AppColors.kCharcoal700,
                  BlendMode.srcIn,
                ),
              ),
              8.horizontalSpacing,
              AppText(
                'Taken',
                style: appTextTheme.titleMedium?.copyWith(
                  color: AppColors.kWhite,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDateCard(int index) {
    final item = dates[index];

    return GestureDetector(
      onTap: () {
        setState(() {
          dates = dates
              .map(
                (e) => e.copyWith(isSelected: false),
              )
              .toList();

          dates[index] = dates[index].copyWith(
            isSelected: true,
          );
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        width: 52,
        padding: const EdgeInsets.symmetric(
          vertical: 10,
        ),
        decoration: BoxDecoration(
          color: item.isSelected
              ? AppColors.kMagentaBloom500
              : AppColors.kCharcoal700,
          borderRadius: AppRadius.mediumRadius,
        ),
        child: Column(
          children: [
            AppText(
              weekDays[item.date.weekday - 1].substring(0, 3),
              style: appTextTheme.bodySmall?.copyWith(
                color: AppColors.kWhite,
                fontWeight: FontWeight.w600,
              ),
            ),

            const SizedBox(height: 4),

            AppText(
              '${item.date.day}',
              style: appTextTheme.titleMedium?.copyWith(
                color: AppColors.kWhite,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 4),

            AppText(
              months[item.date.month - 1],
              style: appTextTheme.bodySmall?.copyWith(
                color: AppColors.kWhite,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTimeCard(int index, String time) {
    final isSelected = selectedTimeIndex == index;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedTimeIndex = index;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        padding: const EdgeInsets.symmetric(horizontal: 19, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.kMagentaBloom500
              : AppColors.kCarbonBlack,
          borderRadius: AppRadius.mediumRadius,
        ),
        child: AppText(
          time,
          style: appTextTheme.titleMedium?.copyWith(
            color: AppColors.kWhite,
            fontWeight: FontWeight.w500,
            fontSize: 18,
          ),
        ),
      ),
    );
  }
}
