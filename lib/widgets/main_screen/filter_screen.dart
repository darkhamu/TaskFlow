import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
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

  Map<String, bool> filters = {};
  String selectedSortOption = '';
  String selectedAddOption = '';

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _loadSavedFiltersAndSort();
  }

  Future<void> _loadSavedFiltersAndSort() async {
    final s = S.of(context);
    final prefs = await SharedPreferences.getInstance();

    final allFilters = {
      s.in_process: false,
      s.finished: false,
      s.today: false,
      s.tomorrow: false,
      s.this_week: false,
      s.this_month: false,
    };

    final savedFilterJson = prefs.getString('taskFilters');
    final savedSort = prefs.getString('taskSort') ?? s.by_priority;
    final savedAdd = prefs.getString('taskAddSort') ?? s.by_order;

    if (savedFilterJson != null) {
      final Map<String, dynamic> decoded = jsonDecode(savedFilterJson);
      for (final key in decoded.keys) {
        if (allFilters.containsKey(key)) {
          allFilters[key] = decoded[key] as bool;
        }
      }
    }

    setState(() {
      filters = allFilters;
      selectedSortOption = savedSort;
      selectedAddOption = savedAdd;
    });
  }

  Future<void> _saveFiltersAndSort() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('taskFilters', jsonEncode(filters));
    await prefs.setString('taskSort', selectedSortOption);
    await prefs.setString('taskAddSort', selectedAddOption);
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
      child: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: const BoxConstraints(minWidth: 300, maxWidth: 500),
          child: Dialog(
            backgroundColor: theme.colorScheme.surface,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        s.filters_and_sorting,
                        style: theme.textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: theme.colorScheme.primary,
                        ),
                      ),
                      IconButton(
                        mouseCursor: SystemMouseCursors.click,
                        icon: Icon(Icons.cancel, color: Theme.of(context).colorScheme.primary,),
                        onPressed: () {
                          Navigator.of(context).pop({
                            'filters': filters,
                            'sort': selectedSortOption,
                            'add': selectedAddOption,
                          });
                        },
                      ),
                    ],
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
                  ElevatedButton(
                      onPressed: () async {
                        await _saveFiltersAndSort();
                        Navigator.of(context).pop({
                          'filters': filters,
                          'sort': selectedSortOption,
                          'addSort': selectedAddOption,
                        });
                      },
                      child: Text(S.of(context).save),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
