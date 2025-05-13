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

    // Check if there's already a FilterListTheme in the widget tree
    final existingTheme =
        context.dependOnInheritedWidgetOfExactType<FilterListTheme>();

    if (existingTheme != null) {
      // If a theme already exists, use it directly
      return Scaffold(
        backgroundColor: Colors.transparent,
        body: _buildBody(context, controller, config),
      );
    } else {
      // If no theme exists, create one
      return FilterListTheme(
        theme: themeData ?? FilterListThemeData.light(context),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: _buildBody(context, controller, config),
        ),
      );
    }
  }

  Widget _buildBody(
    BuildContext context,
    FilterListController<T> controller,
    FilterUIConfig config,
  ) {
    final theme = FilterListTheme.of(context);

    return Container(
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
                    '${controller.selectedItemCount} ${config.selectedItemsText}',
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
    );
  }

  Widget _buildHeader(
    BuildContext context,
    FilterListController<T> controller,
    FilterUIConfig config,
  ) {
    final theme = FilterListTheme.of(context);

    return Container(
      decoration: BoxDecoration(
        color: theme.headerTheme.backgroundColor,
        boxShadow: theme.headerTheme.boxShadow,
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
                    style: theme.headerTheme.headerTextStyle,
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
                  contentPadding: theme
                          .headerTheme.searchFieldInputBorder?.dimensions
                          ?.resolve(TextDirection.ltr) ??
                      EdgeInsets.zero,
                  border: theme.headerTheme.searchFieldInputBorder,
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
    final theme = FilterListTheme.of(context);

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
    final theme = FilterListTheme.of(context);
    final List<Widget> choices = [];

    for (final item in items) {
      final selected = controller.isSelected(item);
      final maxSelectionReached =
          controller.isMaximumSelectionReached && !selected;

      choices.add(
        ChoiceChipWidget(
          choiceChipBuilder: choiceChipBuilder,
          disabled: maxSelectionReached,
          item: item,
          onSelected: (value) {
            controller.toggleSelection(
              item,
              enableOnlySingleSelection: config.enableOnlySingleSelection,
            );
          },
          selected: selected,
          text: controller.filterCore.searchPredicate is LabelDelegate<T>
              ? (controller.filterCore.searchPredicate
                  as LabelDelegate<T>)(item)
              : item.toString(),
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
    final theme = FilterListTheme.of(context);

    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        decoration:
            theme.controlBarButtonTheme.controlContainerDecoration != null
                ? theme.controlBarButtonTheme.controlContainerDecoration!
                : BoxDecoration(
                    color: theme.controlBarButtonTheme.backgroundColor,
                  ),
        child: SafeArea(
          top: false,
          child: Container(
            height: theme.controlBarButtonTheme.height,
            padding: theme.controlBarButtonTheme.padding,
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
    final theme = FilterListTheme.of(context);
    final List<Widget> buttons = [];

    if (!config.enableOnlySingleSelection &&
        controller.filterCore.maximumSelectionLength == null &&
        config.controlButtons.contains(ControlButtonType.All)) {
      buttons.add(
        ControlButton(
          choiceChipLabel: config.allButtonText,
          onPressed: controller.selectAll,
        ),
      );
      buttons.add(SizedBox(width: theme.controlBarButtonTheme.buttonSpacing));
    }

    if (config.controlButtons.contains(ControlButtonType.Reset)) {
      buttons.add(
        ControlButton(
          choiceChipLabel: config.resetButtonText,
          onPressed: controller.clearSelection,
        ),
      );
      buttons.add(SizedBox(width: theme.controlBarButtonTheme.buttonSpacing));
    }

    if (config.controlButtons.contains(ControlButtonType.Apply)) {
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
