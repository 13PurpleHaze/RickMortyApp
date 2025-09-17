import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:rick_morty_app/core/ui/ui.dart';

import 'package:rick_morty_app/features/theme/theme.dart';

@RoutePage()
class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          PlatformAppBar(title: 'Settings'),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 8),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surfaceContainer,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  children: [
                    PlatformListTile(
                      title: Text('Github repository'),
                      trailing: Icon(Icons.arrow_forward_ios),
                      onTap:
                          () => _launchUrl(
                            'https://github.com/13PurpleHaze/RickMortyApp',
                          ),
                    ),
                    PlatformListTile(
                      title: Text('Api'),
                      trailing: Icon(Icons.arrow_forward_ios),
                      onTap: () => _launchUrl('https://rickandmortyapi.com'),
                    ),

                    BlocBuilder<ThemeCubit, ThemeState>(
                      builder: (context, state) {
                        return PlatformListTile(
                          title: Text('Dark theme'),
                          subtitle: Text('Switch for theme'),

                          trailing: Switch.adaptive(
                            value: state.isDart,
                            onChanged: (value) {
                              context.read<ThemeCubit>().setThemeBrightness(
                                value ? Brightness.dark : Brightness.light,
                              );
                            },
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _launchUrl(String url) async {
    final Uri _url = Uri.parse(url);

    if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
    }
  }
}
