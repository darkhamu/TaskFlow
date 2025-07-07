import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:provider/provider.dart';
import 'package:task_flow/models/task_model.dart';
import 'package:task_flow/utils/parsers.dart';
import 'package:task_flow/widgets/base/input_field_widget.dart';
import 'package:task_flow/widgets/base/input_with_border_base.dart';
import 'package:task_flow/widgets/base/round_button_widget.dart';

import '../../generated/l10n.dart';
import '../../main.dart';
import '../../providers/language_provider.dart';
import '../../utils/date_time_util.dart';
import '../../utils/dialog_util.dart';
import '../../utils/reminder_service.dart';
import '../../utils/task_repository.dart';
import '../base/priority_dropdown.dart';

class TaskScreen extends StatefulWidget {
  final TaskModel? taskModel;

  const TaskScreen({super.key, this.taskModel});

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  final userId = FirebaseAuth.instance.currentUser!.uid;

  final TaskRepository _taskRepository = TaskRepository();
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  DateTime deadlineDate = DateTime.now();
  TimeOfDay deadlineTime = TimeOfDay.now();
  int _selectedPriority = 3;

  String _initialName = '';
  String _initialDescription = '';
  String _initialDeadlineDate = '';
  String _initialDeadlineTime = '';
  int _initialPriority = 3;

  bool _isNameEmpty = false;
  bool _isDescriptionEmpty = false;

  late Map<String, int> _reminderOptions;
  List<String> _selectedTimes = [];

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.taskModel?.name ?? '');
    descriptionController = TextEditingController(
      text: widget.taskModel?.description ?? '',
    );

    deadlineDate =
        DateTime.tryParse(widget.taskModel?.deadlineDate ?? '') ??
        DateTime.now();
    deadlineTime =
        parseTimeOfDay(widget.taskModel?.deadlineTime) ?? TimeOfDay.now();
    _selectedPriority = widget.taskModel?.priority ?? 3;

    _initialName = nameController.text.trim();
    _initialDescription = descriptionController.text.trim();
    _initialDeadlineDate = deadlineDate.toIso8601String();
    _initialDeadlineTime = '${deadlineTime.hour.toString().padLeft(2, '0')}:${deadlineTime.minute.toString().padLeft(2, '0')}';
    _initialPriority = _selectedPriority;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _initializeReminderOptions();
    _initializeSelectedTimes();
  }

  @override
  void dispose() {
    nameController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  void _initializeReminderOptions() {
    _reminderOptions = {
      S.of(context).reminder15m: 15,
      S.of(context).reminder30m: 30,
      S.of(context).reminder1h: 60,
      S.of(context).reminder6h: 360,
      S.of(context).reminder12h: 720,
      S.of(context).reminder1d: 1440,
      S.of(context).reminder3d: 4320,
      S.of(context).reminder1w: 10080,
      S.of(context).reminder1mo: 43200,
    };
  }

  void _initializeSelectedTimes() {
    if (widget.taskModel != null) {
      _selectedTimes = widget.taskModel!.reminders.map(_minutesToText).toList();
    }
  }

  String _minutesToText(int minutes) {
    for (var entry in _reminderOptions.entries) {
      if (entry.value == minutes) return entry.key;
    }
    return minutes.toString();
  }

  // проверка изменений в данных
  bool _checkForChanges() {
    final hasNameChanged = _initialName != nameController.text;
    final hasDescriptionChanged =
        _initialDescription != descriptionController.text;
    final hasDeadlineDateChanged =
        _initialDeadlineDate != deadlineDate.toIso8601String();
    final hasDeadlineTimeChanged =
        _initialDeadlineTime != '${deadlineTime.hour.toString().padLeft(2, '0')}:${deadlineTime.minute.toString().padLeft(2, '0')}';
    final hasPriorityChanged = _initialPriority != _selectedPriority;

    return hasNameChanged ||
        hasDescriptionChanged ||
        hasDeadlineDateChanged ||
        hasDeadlineTimeChanged ||
        hasPriorityChanged;
  }

  Future<void> _saveTask() async {
    final name = nameController.text.trim();
    final description = descriptionController.text.trim();

    final languageProvider = Provider.of<LanguageProvider>(context, listen: false);
    final String currentUserLanguageCode = languageProvider.locale.languageCode;

    if (name.isEmpty || description.isEmpty) {
      setState(() {
        _isNameEmpty = name.isEmpty;
        _isDescriptionEmpty = description.isEmpty;
      });
      return;
    }

    try {
      final timeString =
          '${deadlineTime.hour.toString().padLeft(2, '0')}:'
          '${deadlineTime.minute.toString().padLeft(2, '0')}';
      final remindersMap = _selectedTimes
          .map((text) => _reminderOptions[text] ?? 0)
          .where((minutes) => minutes > 0)
          .toList();

      final taskToSave = TaskModel(
        id: widget.taskModel?.id ?? '',
        name: name,
        description: description,
        priority: _selectedPriority,
        deadlineDate: deadlineDate.toString(),
        deadlineTime: timeString,
        isDone: false,
        reminders: remindersMap,
      );

      if (widget.taskModel != null) {
        await _taskRepository.updateTask(taskToSave);
      } else {
        await _taskRepository.addTask(taskToSave);
      }

      Future(() async {
        try {
          await cancelTaskReminders(taskToSave);
          await scheduleTaskReminders(task: taskToSave,userLanguageCode: currentUserLanguageCode);
        } catch (e) {
          debugPrint('Reminder scheduling failed: $e');
        }
      });

      debugPrint('Task deadline: ${taskToSave.deadlineDateTime}');
      debugPrint('Reminders: ${taskToSave.reminders}');
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('${S.of(context).error}: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final _items =
        _reminderOptions.entries
            .map((e) => MultiSelectItem<String>(e.key, e.key))
            .toList();

    return Center(
      child: PopScope(
        canPop: !_checkForChanges(),
        onPopInvoked: (bool didPop) async {
          if (didPop) return;

          final shouldProceed = await showUnsavedChangesDialog(context);
          if (shouldProceed == true) {
            await _saveTask();
            return;
          } else if (shouldProceed == false) {
            if (mounted) Navigator.pop(context, false);
          }
        },
        child: Dialog(
          backgroundColor: Theme.of(context).colorScheme.surface,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 500),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                          mouseCursor: SystemMouseCursors.click,
                          icon: Icon(
                            Icons.cancel,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          onPressed: () async {
                            if (!_checkForChanges()) {
                              Navigator.of(context).pop();
                              return;
                            }

                            final shouldProceed =
                                await showUnsavedChangesDialog(context);
                            if (shouldProceed != null && mounted) {
                              if (shouldProceed) {
                                await _saveTask();
                              }
                              Navigator.of(context).pop();
                            }
                          },
                        ),
                      ],
                    ),
                    // название задачи
                    InputFieldWidget(
                      label: S.of(context).name,
                      controller: nameController,
                      errorText:
                          _isNameEmpty
                              ? S.of(context).field_must_be_filled
                              : null,
                    ),
                    const SizedBox(height: 16),
                    // описание
                    InputWithBorderBase(
                      name: S.of(context).description,
                      controller: descriptionController,
                      maxLines: 4,
                      errorText:
                          _isDescriptionEmpty
                              ? S.of(context).field_must_be_filled
                              : null,
                    ),
                    const SizedBox(height: 16),
                    // выбор даты и времени дедлайна
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          S.of(context).deadline,
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                        ),
                        Row(
                          children: [
                            const Icon(Icons.date_range),
                            GestureDetector(
                              onTap: () async {
                                final pickedDate = await selectDate(
                                  context: context,
                                  initialDate: deadlineDate,
                                );
                                if (pickedDate != null &&
                                    pickedDate != deadlineDate &&
                                    mounted) {
                                  setState(() {
                                    deadlineDate = pickedDate;
                                  });
                                }
                              },
                              child: Text(
                                deadlineDate.toString().split(' ').first,
                                style: TextStyle(
                                  color:
                                      Theme.of(context).colorScheme.onSurface,
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            const Icon(Icons.watch_later_outlined),
                            GestureDetector(
                              onTap: () async {
                                final pickedTime = await selectTime(
                                  context: context,
                                  initialTime: deadlineTime,
                                );
                                if (pickedTime != null &&
                                    pickedTime != deadlineTime &&
                                    mounted) {
                                  setState(() {
                                    deadlineTime = pickedTime;
                                  });
                                }
                              },
                              child: Text(
                                deadlineTime.format(context),
                                style: TextStyle(
                                  color:
                                      Theme.of(context).colorScheme.onSurface,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    // выбор приоритета
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          S.of(context).priority,
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                        ),
                        PriorityDropdown(
                          selectedPriority: _selectedPriority,
                          onChanged: (priority) {
                            if (priority != null) {
                              setState(() {
                                _selectedPriority = priority;
                              });
                            }
                          },
                          colorScheme: Theme.of(context).colorScheme,
                          textTheme: Theme.of(context).textTheme,
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          S.of(context).time_of_reminder,
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Wrap(
                            alignment: WrapAlignment.end,
                            crossAxisAlignment: WrapCrossAlignment.center,
                            spacing: 8.0,
                            runSpacing: 8.0,
                            children: [
                              ..._selectedTimes.map(
                                (time) => Chip(
                                  label: Text(
                                    time,
                                    style: TextStyle(
                                      color:
                                          Theme.of(
                                            context,
                                          ).colorScheme.onPrimary,
                                    ),
                                  ),
                                  backgroundColor:
                                      Theme.of(context).colorScheme.primary,
                                  deleteIcon: const Icon(Icons.close, size: 18),
                                  onDeleted: () {
                                    setState(() {
                                      _selectedTimes.remove(time);
                                    });
                                  },
                                ),
                              ),
                              ActionChip(
                                label: Text(
                                  _selectedTimes.isEmpty
                                      ? S.of(context).select
                                      : S.of(context).change,
                                  style: TextStyle(
                                    color:
                                        Theme.of(context).colorScheme.onSurface,
                                  ),
                                ),
                                onPressed: () async {
                                  final List<String> tempSelected = List.from(
                                    _selectedTimes,
                                  );
                                  final List<String>? result = await showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        title: Text(
                                          S.of(context).select_time,
                                          style: TextStyle(
                                            color:
                                                Theme.of(
                                                  context,
                                                ).colorScheme.onSurface,
                                          ),
                                        ),
                                        content: SingleChildScrollView(
                                          child: Wrap(
                                            spacing: 8,
                                            runSpacing: 8,
                                            children:
                                                _items.map((item) {
                                                  final label = item.label;
                                                  final value = item.value;
                                                  final isSelected =
                                                      tempSelected.contains(
                                                        value,
                                                      );
                                                  return FilterChip(
                                                    label: Text(label),
                                                    selected: isSelected,
                                                    selectedColor:
                                                        Theme.of(
                                                          context,
                                                        ).colorScheme.primary,
                                                    onSelected: (selected) {
                                                      selected
                                                          ? tempSelected.add(
                                                            value,
                                                          )
                                                          : tempSelected.remove(
                                                            value,
                                                          );
                                                      (context as Element)
                                                          .markNeedsBuild();
                                                    },
                                                  );
                                                }).toList(),
                                          ),
                                        ),
                                        actions: [
                                          TextButton(
                                            child: Text(S.of(context).cancel),
                                            onPressed:
                                                () => Navigator.pop(context),
                                          ),
                                          ElevatedButton(
                                            child: Text(S.of(context).save),
                                            onPressed:
                                                () => Navigator.pop(
                                                  context,
                                                  tempSelected,
                                                ),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                  if (result != null) {
                                    setState(() {
                                      _selectedTimes = result;
                                    });
                                  }
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 24),
                    // кнопка сохранения
                    RoundButtonWidget(
                      onPressed: () async {
                        await _saveTask();
                        if (mounted) Navigator.pop(context);
                      },
                      label: S.of(context).save,
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
