import 'package:flutter/material.dart';
import 'package:task_flow/widgets/base/expandable_section.dart';

import '../../generated/l10n.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({super.key});

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  bool filtersExpanded = true;
  bool sortExpanded = true;

  late Map<String, bool> filters;
  late String selectedSortOption;
  late String selectedAddOption;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final s = S.of(context);

    filters = {
      s.in_process: false,
      s.finished: false,
      s.today: false,
      s.tomorrow: false,
      s.this_week: false,
      s.this_month: false,
    };

    selectedSortOption = s.by_date_of_expiration;
    selectedAddOption = s.by_order;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final s = S.of(context);

    final sortOptions = [
      s.by_date_of_expiration,
      s.by_name,
      s.by_priority,
    ];

    final additionalSorting = [
      s.by_order,
      s.by_descending,
    ];

    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(minWidth: 300, maxWidth: 500),
        child: Dialog(
          backgroundColor: theme.colorScheme.surface,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  s.filters_and_sorting,
                  style: theme.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.primary,
                  ),
                ),
                const SizedBox(height: 24),

                ExpandableSection(
                  title: s.filters,
                  initiallyExpanded: filtersExpanded,
                  children: filters.keys.map((String key) {
                    return CheckboxListTile(
                      controlAffinity: ListTileControlAffinity.leading,
                      contentPadding: EdgeInsets.zero,
                      title: Text(key),
                      value: filters[key],
                      onChanged: (bool? value) {
                        setState(() {
                          filters[key] = value!;
                        });
                      },
                    );
                  }).toList(),
                ),

                const SizedBox(height: 16),

                ExpandableSection(
                  title: s.sorting,
                  initiallyExpanded: sortExpanded,
                  children: [
                    ...sortOptions.map((String option) {
                      return RadioListTile<String>(
                        contentPadding: EdgeInsets.zero,
                        title: Text(option),
                        value: option,
                        groupValue: selectedSortOption,
                        onChanged: (String? value) {
                          setState(() {
                            selectedSortOption = value!;
                          });
                        },
                      );
                    }).toList(),
                    const Divider(height: 32),
                    ...additionalSorting.map((String option) {
                      return RadioListTile(
                        contentPadding: EdgeInsets.zero,
                        title: Text(option),
                        value: option,
                        groupValue: selectedAddOption,
                        onChanged: (String? value) {
                          setState(() {
                            selectedAddOption = value!;
                          });
                        },
                      );
                    }),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
