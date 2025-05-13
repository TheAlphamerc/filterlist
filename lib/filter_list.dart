library filter_list;

/// Core components for modern usage
export 'src/core/core.dart';
export 'src/core/filter_callbacks.dart';
export 'src/core/filter_core.dart';
export 'src/core/filter_list_provider.dart';
export 'src/core/filter_list_view_model.dart';
export 'src/core/filter_ui_config.dart';
export 'src/core/typedefs.dart';

/// Documentation about modern usage patterns
export 'src/core/usage_patterns.dart';

/// State management components
export 'src/state/filter_state.dart';
export 'src/state/provider.dart';

/// Implementation components (dialog and delegate)
export 'src/filter_list_delegate.dart'
    hide
        ValidateSelectedItem,
        SearchPredict,
        LabelDelegate,
        OnApplyButtonClick,
        ChoiceChipBuilder,
        ValidateRemoveItem,
        ControlButtonType;
export 'src/filter_list_dialog.dart'
    hide
        ValidateSelectedItem,
        SearchPredict,
        LabelDelegate,
        OnApplyButtonClick,
        ChoiceChipBuilder,
        ValidateRemoveItem,
        ControlButtonType;

/// Theme components for styling
export 'src/theme/theme.dart';

/// Modern widget implementations
export 'src/widget/filter_list_widget_modern.dart';
export 'src/widget/choice_chip_widget.dart';
export 'src/widget/control_button.dart';
export 'src/widget/control_button_bar.dart';
export 'src/widget/header.dart';
export 'src/widget/search_field_widget.dart';
