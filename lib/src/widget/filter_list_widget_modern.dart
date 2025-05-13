import 'package:filter_list/src/core/core.dart';
import 'package:filter_list/src/theme/theme.dart';
import 'package:filter_list/src/widget/choice_chip_widget.dart';
import 'package:filter_list/src/widget/control_button.dart';
import 'package:flutter/material.dart';

/// A modern implementation of the FilterListWidget that uses the Provider-based state management.
/// This widget is designed to be used with FilterListProvider.
class FilterListWidgetModern<T> extends StatelessWidget {
  /// The Filter theme data.
  final FilterListThemeData? themeData;

  /// Custom choice chip builder.
  final ChoiceChipBuilder? choiceChipBuilder;

  /// Creates a new FilterListWidgetModern.
  const FilterListWidgetModern({
    Key? key,
    this.themeData,
    this.choiceChipBuilder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = FilterListProvider.of<T>(context);
    final config = controller.uiConfig;

    // Create FilterListTheme with appropriate precedence:
    // 1. Explicitly provided theme
    // 2. Theme from context
    // 3. Default light theme
    final FilterListThemeData effectiveTheme =
        themeData ?? FilterListTheme.safeOf(context);

    return FilterListTheme(
      theme: effectiveTheme,
      child: Builder(builder: (context) {
        // Access the theme safely through the context
        final theme = FilterListTheme.safeOf(context);

        return Scaffold(
          backgroundColor: Colors.transparent,
          body: Container(
            color: theme.backgroundColor,
            child: Stack(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    if (config.hideHeader)
                      const SizedBox()
                    else
                      _buildHeader(context, controller, config),
                    if (!config.hideSelectedTextCount)
                      Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: Text(
                          '${controller.selectedItemsCount} ${config.selectedItemsText}',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ),
                    Expanded(
                      child: _buildItemList(context, controller, config),
                    ),
                  ],
                ),
                _buildControlButtonBar(context, controller, config),
              ],
            ),
          ),
        );
      }),
    );
  }

  Widget _buildHeader(
    BuildContext context,
    FilterListController<T> controller,
    FilterUIConfig config,
  ) {
    final theme = HeaderTheme.safeOf(context);

    return Container(
      decoration: BoxDecoration(
        color: theme.backgroundColor,
        boxShadow: theme.boxShadow,
      ),
      padding: const EdgeInsets.all(12.0),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              if (config.headlineText != null)
                Expanded(
                  child: Text(
                    config.headlineText!,
                    style: theme.headerTextStyle,
                  ),
                ),
              if (!config.hideCloseIcon)
                IconButton(
                  icon: config.closeIcon ?? const Icon(Icons.close),
                  onPressed:
                      config.onClosePressed ?? () => Navigator.pop(context),
                ),
            ],
          ),
          if (!config.hideSearchField)
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: TextField(
                decoration: InputDecoration(
                  hintText: config.searchFieldHint ?? 'Search',
                  contentPadding: theme.searchFieldInputBorder != null
                      ? theme.searchFieldInputBorder!.dimensions
                          .resolve(TextDirection.ltr)
                      : EdgeInsets.zero,
                  border: theme.searchFieldInputBorder,
                  prefixIcon: const Icon(Icons.search),
                ),
                onChanged: controller.updateSearchQuery,
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildItemList(
    BuildContext context,
    FilterListController<T> controller,
    FilterUIConfig config,
  ) {
    final theme = FilterListTheme.safeOf(context);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: SingleChildScrollView(
        child: AnimatedBuilder(
          animation: controller,
          builder: (context, _) {
            final items = controller.filteredItems;
            if (items.isEmpty) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Text(
                    'No items found',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
              );
            }

            return Wrap(
              alignment: theme.wrapAlignment,
              crossAxisAlignment: theme.wrapCrossAxisAlignment,
              runSpacing: theme.wrapSpacing,
              children: _buildChoiceChips(context, controller, items, config),
            );
          },
        ),
      ),
    );
  }

  List<Widget> _buildChoiceChips(
    BuildContext context,
    FilterListController<T> controller,
    List<T> items,
    FilterUIConfig config,
  ) {
    final theme = FilterListTheme.safeOf(context);
    final List<Widget> choices = [];

    // Function to get display text for each item
    String getItemText(T item) {
      // Use controller's createCallbacks to get the proper label
      try {
        final callbacks = controller.createCallbacks(
          labelProvider: (item) => item.toString(),
        );

        // Use the label provider from callbacks
        return callbacks.labelProvider(item) ?? item.toString();
      } catch (e) {
        // If we can't create callbacks, fall back to toString
        return item.toString();
      }
    }

    for (final item in items) {
      final selected = controller.isItemSelected(item);
      final maxSelectionReached =
          controller.isMaximumSelectionReached && !selected;

      choices.add(
        ChoiceChipWidget(
          choiceChipBuilder: choiceChipBuilder,
          disabled: maxSelectionReached,
          item: item,
          onSelected: (value) {
            controller.toggleItem(
              item,
              enableOnlySingleSelection: config.enableOnlySingleSelection,
            );
          },
          selected: selected,
          text: getItemText(item),
        ),
      );
    }

    // Add padding at the bottom for better scrolling experience
    choices.add(
      SizedBox(
        height: theme.controlBarButtonTheme.height + 20,
        width: MediaQuery.of(context).size.width,
      ),
    );

    return choices;
  }

  Widget _buildControlButtonBar(
    BuildContext context,
    FilterListController<T> controller,
    FilterUIConfig config,
  ) {
    final theme = ControlButtonBarTheme.safeOf(context);

    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        decoration: theme.controlContainerDecoration != null
            ? theme.controlContainerDecoration!
            : BoxDecoration(
                color: theme.backgroundColor,
              ),
        child: SafeArea(
          top: false,
          child: Container(
            height: theme.height,
            padding: theme.padding,
            child: AnimatedBuilder(
              animation: controller,
              builder: (context, _) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: _buildControlButtons(context, controller, config),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildControlButtons(
    BuildContext context,
    FilterListController<T> controller,
    FilterUIConfig config,
  ) {
    final theme = ControlButtonBarTheme.safeOf(context);
    final List<Widget> buttons = [];

    // Check if the button should be shown based on controller properties
    final shouldShowAllButton = !config.enableOnlySingleSelection &&
        !controller.isMaximumSelectionReached &&
        config.controlButtons.contains(ControlButtonType.all);

    if (shouldShowAllButton) {
      buttons.add(
        ControlButton(
          choiceChipLabel: config.allButtonText,
          onPressed: controller.selectAll,
        ),
      );
      buttons.add(SizedBox(width: theme.buttonSpacing));
    }

    if (config.controlButtons.contains(ControlButtonType.reset)) {
      buttons.add(
        ControlButton(
          choiceChipLabel: config.resetButtonText,
          onPressed: controller.clearSelection,
        ),
      );
      buttons.add(SizedBox(width: theme.buttonSpacing));
    }

    if (config.controlButtons.contains(ControlButtonType.apply)) {
      buttons.add(
        ControlButton(
          choiceChipLabel: config.applyButtonText,
          primaryButton: true,
          onPressed: () {
            final result = controller.applyFilter();
            Navigator.pop(context, result);
          },
        ),
      );
    }

    return buttons;
  }
}
