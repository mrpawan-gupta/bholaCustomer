import "package:flutter/material.dart";

class FilterableList extends StatelessWidget {
  const FilterableList({
    required this.items,
    required this.onItemTapped,
    this.loader,
    this.suggestionBuilder,
    this.elevation = 5,
    this.maxListHeight = 150,
    this.suggestionTextStyle = const TextStyle(),
    this.suggestionBackgroundColor,
    this.loading = false,
    super.key,
  });
  final List<String> items;
  final Function(String) onItemTapped;
  final double elevation;
  final double maxListHeight;
  final TextStyle suggestionTextStyle;
  final Widget? loader;
  final Color? suggestionBackgroundColor;
  final bool loading;
  final Widget Function(String data)? suggestionBuilder;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ScaffoldState? scaffold = Scaffold.maybeOf(context);

    final Color newSuggestionBackgroundColor = suggestionBackgroundColor ??
        scaffold?.widget.backgroundColor ??
        theme.scaffoldBackgroundColor;

    return Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(5),
      color: newSuggestionBackgroundColor,
      child: Container(
        constraints: BoxConstraints(maxHeight: maxListHeight),
        child: Visibility(
          visible: items.isNotEmpty || loading,
          child: ListView.builder(
            shrinkWrap: true,
            padding: const EdgeInsets.all(5),
            itemCount: loading ? 1 : items.length,
            itemBuilder: (BuildContext context, int index) {
              if (loading) {
                return loader!;
              }

              if (suggestionBuilder != null) {
                return InkWell(
                  child: suggestionBuilder!(items[index]),
                  onTap: () => onItemTapped(items[index]),
                );
              }

              return Material(
                color: Colors.transparent,
                child: InkWell(
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(5),
                    child: Text(
                      items[index],
                      style: suggestionTextStyle,
                    ),
                  ),
                  onTap: () => onItemTapped(items[index]),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
