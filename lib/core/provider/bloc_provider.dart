import 'package:cinemax/core/data/di/injection.dart';
import 'package:cinemax/features/Auth/bloc/auth_bloc.dart';
import 'package:cinemax/features/Explore/bloc/explore_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

final List<BlocProvider> appBlocProvider = [
  BlocProvider<AuthBloc>.value(value: sl<AuthBloc>()),
  BlocProvider<ExploreBloc>.value(value: sl<ExploreBloc>()),
];
