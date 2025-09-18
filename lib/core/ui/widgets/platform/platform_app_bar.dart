import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PlatformAppBar extends StatefulWidget {
  final String title;
  final List<Widget> actions;
  final void Function(String)? onChangeSearchBarTextChange;

  /// iOS only: Callback for searchable bottom tap
  /// This parameter is ignored on Android platform
  final void Function(bool result)? onSearchableBottomTap;

  const PlatformAppBar({
    super.key,
    required this.title,
    this.onChangeSearchBarTextChange,
    this.onSearchableBottomTap, // iOS only
    this.actions = const [],
  });

  @override
  State<PlatformAppBar> createState() => _PlatformAppBarState();
}

class _PlatformAppBarState extends State<PlatformAppBar> {
  final _controller = SearchController();
  final _focusNode = FocusNode();

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (Theme.of(context).platform == TargetPlatform.android) {
      return SliverAppBar(
        title: Text(widget.title),
        centerTitle: true,
        floating: true,
        snap: true,
        pinned: true,
        forceElevated: true,
        bottom:
            widget.onChangeSearchBarTextChange != null
                ? PreferredSize(
                  preferredSize: Size.fromHeight(65),
                  child: Padding(
                    padding: EdgeInsets.only(left: 16, right: 16, bottom: 8),
                    child: SearchBar(
                      leading: IconButton(
                        onPressed: () {
                          if (_controller.text.isNotEmpty) {
                            widget.onChangeSearchBarTextChange!(
                              _controller.text,
                            );
                          }
                        },
                        icon: Icon(Icons.search),
                      ),
                      controller: _controller,
                      focusNode: _focusNode,
                      trailing: [
                        IconButton(
                          onPressed: () {
                            if (_controller.text.isNotEmpty) {
                              _controller.clear();
                              _focusNode.unfocus();
                              widget.onChangeSearchBarTextChange!('');
                            }
                          },
                          icon: Icon(Icons.clear),
                        ),
                      ],
                      onChanged: widget.onChangeSearchBarTextChange,
                      onSubmitted: widget.onChangeSearchBarTextChange,
                      onTapOutside: (tap) {
                        _focusNode.unfocus();
                      },
                    ),
                  ),
                )
                : null,
        actions: widget.actions,
      );
    } else {
      return widget.onChangeSearchBarTextChange != null
          ? CupertinoSliverNavigationBar.search(
            stretch: true,
            backgroundColor: CupertinoThemeData().barBackgroundColor,
            largeTitle: Text(widget.title),
            onSearchableBottomTap: widget.onSearchableBottomTap,
            searchField: CupertinoSearchTextField(
              autofocus: true,
              placeholder: 'Search',
              onChanged: widget.onChangeSearchBarTextChange,
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: widget.actions,
            ),
          )
          : CupertinoSliverNavigationBar(
            stretch: true,
            backgroundColor: CupertinoThemeData().barBackgroundColor,
            largeTitle: Text(widget.title),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: widget.actions,
            ),
          );
    }
  }
}
