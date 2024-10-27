import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:karabookapp/pages/portfolio/data/datasources/portfolio_datasource.dart';
import 'package:karabookapp/pages/portfolio/domain/repositories/portfolio_repository.dart';

@RoutePage(name: 'PortfolioWrappedRoute')
class PortfolioProvider extends StatelessWidget implements AutoRouteWrapper {
  const PortfolioProvider({super.key});

  @override
  Widget wrappedRoute(context) => RepositoryProvider<IPortfolioRepository>(
        create: (context) => PortfolioRepository(PortfolioDataSources()),
        child: this,
      );

  @override
  Widget build(BuildContext context) => const AutoRouter();
}
