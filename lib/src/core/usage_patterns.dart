/// This file provides documentation on the recommended usage patterns
/// for the filter_list package.
/// 
/// # Migration from Legacy to Modern API
/// 
/// ## Legacy API (Deprecated):
/// ```dart
/// FilterListDialog.display<User>(
///   context,
///   listData: users,
///   selectedListData: selectedUsers,
///   choiceChipLabel: (item) => item!.name,
///   validateSelectedItem: (list, val) => list!.contains(val),
///   onItemSearch: (user, query) {
///     return user.name!.toLowerCase().contains(query.toLowerCase());
///   },
///   onApplyButtonClick: (list) {
///     setState(() {
///       selectedUserList = List.from(list!);
///     });
///     Navigator.pop(context);
///   },
/// );
/// ```
/// 
/// ## Modern API (Recommended):
/// ```dart
/// // Using FilterListDialog.showWithCore:
/// await FilterListDialog.showWithCore<User>(
///   context,
///   allItems: users,
///   selectedItems: selectedUsers,
///   callbacks: FilterCallbacks<User>(
///     searchPredicate: (user, query) {
///       return user.name!.toLowerCase().contains(query.toLowerCase());
///     },
///     validateSelection: (list, val) => list!.contains(val),
///     labelProvider: (user) => user!.name,
///     onApplyButtonClick: (list) {
///       setState(() {
///         selectedUsers = List.from(list!);
///       });
///     },
///   ),
///   uiConfig: const FilterUIConfig(
///     headlineText: 'Select Users',
///     hideSelectedTextCount: false,
///   ),
/// );
///
/// // Using FilterListDialog.showFilterListModern (Provider-based):
/// final result = await FilterListDialog.showFilterListModern<User>(
///   context,
///   themeData: FilterListThemeData.light(context),
///   listData: users,
///   selectedListData: selectedUsers,
///   labelProvider: (user) => user!.name,
///   validateSelection: (list, val) => list!.contains(val),
///   searchPredicate: (user, query) {
///     return user.name!.toLowerCase().contains(query.toLowerCase());
///   },
///   onApplyButtonClick: (list) {
///     setState(() {
///       selectedUsers = List.from(list!);
///     });
///   },
/// );
/// ```
/// 
/// # For Custom Implementations
/// 
/// Use the modern components for building custom interfaces:
/// 
/// ```dart
/// // Create your filter list controller
/// final controller = FilterListController<User>(
///   allItems: users,
///   selectedItems: selectedUsers,
///   searchPredicate: (user, query) {
///     return user.name!.toLowerCase().contains(query.toLowerCase());
///   },
///   validateSelection: (list, val) => list!.contains(val),
///   onApplyButtonClick: (list) {
///     // Handle selected items
///   },
/// );
///
/// // Use in your widget tree
/// FilterListProvider<User>(
///   controller: controller,
///   child: FilterListWidgetModern<User>(
///     themeData: FilterListThemeData.light(context),
///   ),
/// )
/// ``` 