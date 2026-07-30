import 'package:cinemax/core/theme/app_text_theme.dart';
import 'package:cinemax/core/ui/components/app_button.dart';
import 'package:cinemax/core/ui/components/app_text.dart';
import 'package:cinemax/core/ui/extensions/app_spacing_extension.dart';
import 'package:cinemax/core/ui/layouts/app_scaffold.dart';
import 'package:cinemax/core/variables/app_radius.dart';
import 'package:cinemax/core/variables/app_svgs.dart';
import 'package:cinemax/core/variables/colors.dart';
import 'package:cinemax/features/Explore/bloc/explore_bloc.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class PaymentCheckout extends StatefulWidget {
  const PaymentCheckout({super.key, this.id});

  final String? id;

  @override
  State<PaymentCheckout> createState() => _PaymentCheckoutState();
}

class _PaymentCheckoutState extends State<PaymentCheckout> {
  @override
  void initState() {
    super.initState();
    if (widget.id != null) {
      context.read<ExploreBloc>().add(GetMovieById(widget.id!));
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 24),
        child: SizedBox(
          width: MediaQuery.sizeOf(context).width * 0.9,
          child: AppButtonElevated(
            text: 'Make Payment',
            onPressed: () => context.push('/paymentMethod'),
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
          'Ticket Checkout',
          style: appTextTheme.titleMedium?.copyWith(
            color: AppColors.kWhite,
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: .start,
        children: [
          BlocBuilder<ExploreBloc, ExploreState>(
            builder: (context, state) {
              final movieFromList = state.movies
                  .where((m) => m.id == widget.id)
                  .firstOrNull;

              if (state.status == ExploreStatus.success ||
                  movieFromList != null) {
                final movies = state.selectedMovie ?? movieFromList!;
                return Column(
                  crossAxisAlignment: .start,
                  children: [
                    _buildTicketCard(
                      ValueKey(movies.id),
                      movies.image!,
                      movies.title!,
                    ),

                    24.verticalSpacing,

                    Column(
                      crossAxisAlignment: .start,
                      children: [
                        AppText(
                          'Order Total',
                          style: appTextTheme.titleMedium?.copyWith(
                            fontSize: 18,
                            color: AppColors.kWhite,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        16.verticalSpacing,
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 18,
                            vertical: 22,
                          ),
                          width: MediaQuery.sizeOf(context).width,
                          decoration: BoxDecoration(
                            color: AppColors.kCarbonBlack,
                            borderRadius: AppRadius.largeRadius,
                          ),
                          child: Column(
                            crossAxisAlignment: .start,
                            children: [
                              AppText(
                                '4 Tickets x '
                                '\$${movies.price!.toStringAsFixed(2)}',
                                style: appTextTheme.titleMedium?.copyWith(
                                  fontSize: 18,
                                  color: AppColors.kWhite,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              16.verticalSpacing,
                              // total
                              Row(
                                children: [
                                  Expanded(
                                    child: AppText(
                                      'Total',
                                      style: appTextTheme.titleMedium?.copyWith(
                                        fontSize: 18,
                                        color: AppColors.kSliver300,
                                      ),
                                    ),
                                  ),

                                  AppText(
                                    '\$${63.96}',
                                    style: appTextTheme.titleMedium?.copyWith(
                                      fontSize: 18,
                                      color: AppColors.kWhite,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                              16.verticalSpacing,
                              // service fee
                              Row(
                                children: [
                                  Expanded(
                                    child: AppText(
                                      'Service Fee',
                                      style: appTextTheme.titleMedium?.copyWith(
                                        fontSize: 18,
                                        color: AppColors.kSliver300,
                                      ),
                                    ),
                                  ),

                                  AppText(
                                    '\$${3.99}',
                                    style: appTextTheme.titleMedium?.copyWith(
                                      fontSize: 18,
                                      color: AppColors.kWhite,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                              const Divider(
                                color: AppColors.kCharcoal700,
                                thickness: 2,
                              ),

                              16.verticalSpacing,
                              // payable amount
                              Row(
                                children: [
                                  Expanded(
                                    child: AppText(
                                      'Payable Amount',
                                      style: appTextTheme.titleMedium?.copyWith(
                                        fontSize: 18,
                                        color: AppColors.kWhite,
                                      ),
                                    ),
                                  ),

                                  AppText(
                                    '\$${67.95}',
                                    style: appTextTheme.titleMedium?.copyWith(
                                      fontSize: 18,
                                      color: AppColors.kWhite,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              }
              return const Center(
                child: CircularProgressIndicator(
                  color: AppColors.kMagentaBloom500,
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildTicketCard(ValueKey<dynamic> key, String image, String title) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 22),
      decoration: BoxDecoration(
        color: AppColors.kCarbonBlack,
        borderRadius: AppRadius.largeRadius,
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: AppRadius.mediumRadius,
            child: Image.network(
              image,
              width: 100,
              height: 150,
              fit: BoxFit.cover,
            ),
          ),
          16.horizontalSpacing,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText(
                title,
                style: appTextTheme.titleMedium?.copyWith(
                  color: AppColors.kWhite,
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                ),
              ),
              12.verticalSpacing,
              // genre
              AppText(
                'Sci-Fri, Horor, Action',
                style: appTextTheme.titleMedium?.copyWith(
                  color: AppColors.kSliver300,
                  fontSize: 18,
                ),
              ),
              12.verticalSpacing,
              // date
              Row(
                children: [
                  SvgPicture.asset(AppSvgs.kCalendar),
                  8.horizontalSpacing,
                  AppText(
                    'Wednesday 3rd March,\n 2026',
                    style: appTextTheme.titleMedium?.copyWith(
                      color: AppColors.kWhite,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
              12.verticalSpacing,
              // time
              Row(
                children: [
                  SvgPicture.asset(AppSvgs.kclock),
                  8.horizontalSpacing,
                  AppText(
                    '11:00pm',
                    style: appTextTheme.titleMedium?.copyWith(
                      color: AppColors.kWhite,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
