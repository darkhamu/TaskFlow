import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:task_flow/models/task_model.dart';
import 'package:task_flow/providers/parsers.dart';
import 'package:task_flow/widgets/base/input_field_widget.dart';
import 'package:task_flow/widgets/base/input_with_border_base.dart';
import 'package:task_flow/widgets/base/round_button_widget.dart';

import '../../generated/l10n.dart';

class TaskScreen extends StatefulWidget {
  final TaskModel? taskModel;

  const TaskScreen({super.key, this.taskModel});

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  DateTime deadlineDate = DateTime.now();
  TimeOfDay deadlineTime = TimeOfDay.now();

  int _selectedPriority = 3;

  String _initialName = '';
  String _initialDescription = '';
  String _initialDeadlineDate = '';
  String _initialDeadlineTime = '';
  int _initialPriority = 0;
  final userId = FirebaseAuth.instance.currentUser!.uid;

  bool _isNameEmpty = false;
  bool _isDescriptionEmpty = false;

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
    _initialDeadlineTime = deadlineTime.toString();
    _initialDeadlineDate = deadlineDate.toString();
    _initialPriority = _selectedPriority;
  }

  Future<void> _saveTask() async {
    final name = nameController.text.trim();
    final description = descriptionController.text.trim();

    if (name.isEmpty || description.isEmpty) {
      setState(() {
        _isNameEmpty = name.isEmpty;
        _isDescriptionEmpty = description.isEmpty;
      });
      return;
    }
    try {
      final timeString = '${deadlineTime.hour}:${deadlineTime.minute}';
      if (widget.taskModel != null) {
        await FirebaseDatabase.instance
            .ref()
            .child('$userId/tasks/${widget.taskModel!.id}')
            .update({
              'name': name,
              'description': description,
              'priority': _selectedPriority.toString(),
              'deadlineDate': deadlineDate.toString(),
              'deadlineTime': timeString,
              'isDone': false,
            });
      } else {
        await FirebaseDatabase.instance.ref('$userId/tasks').push().set({
          'name': name,
          'description': description,
          'priority': _selectedPriority.toString(),
          'deadlineDate': deadlineDate.toString(),
          'deadlineTime': timeString,
          'isDone': false,
        });
      }
      if (mounted) {
        setState(() {
          _initialName = name;
          _initialDescription = description;
          _initialPriority = _selectedPriority;
          _initialDeadlineDate = deadlineDate.toString();
          _initialDeadlineTime = timeString;
        });
        Navigator.pop(context);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${S.of(context).error}: $e'),
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        );
      }
    }
  }

  // проверка изменений в данных
  bool _checkForChanges() {
    final hasNameChanged = _initialName != nameController.text;
    final hasDescriptionChanged =
        _initialDescription != descriptionController.text;
    final hasDeadlineDateChanged =
        _initialDeadlineDate != deadlineDate.toIso8601String();
    final hasDeadlineTimeChanged =
        _initialDeadlineTime != '${deadlineTime.hour}:${deadlineTime.minute}';
    final hasPriorityChanged = _initialPriority != _selectedPriority;

    return hasNameChanged ||
        hasDescriptionChanged ||
        hasDeadlineDateChanged ||
        hasDeadlineTimeChanged ||
        hasPriorityChanged;
  }

  @override
  void dispose() {
    nameController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: PopScope(
        canPop: !_checkForChanges(),
        onPopInvoked: (bool didPop) async {
          if (didPop) return;

          final shouldProceed = await _showUnsavedChangesDialog();
          if (shouldProceed == true) {
            await _saveTask();
          } else if (shouldProceed == false && mounted) {
            Navigator.of(context).pop(null);
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
                              await _showUnsavedChangesDialog();
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
                            onTap:
                                () => _selectDate(deadlineDate, deadlineTime),
                            child: Text(
                              deadlineDate.toString().split(' ').first,
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.onSurface,
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          const Icon(Icons.watch_later_outlined),
                          GestureDetector(
                            onTap: () => _selectTime(deadlineTime),
                            child: Text(
                              deadlineTime.format(context),
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.onSurface,
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
                      DropdownButton(
                        value: _selectedPriority,
                        dropdownColor: Theme.of(context).colorScheme.surface,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                        items: [
                          DropdownMenuItem(
                            value: 1,
                            child: Text(
                              S.of(context).urgent,
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.onSurface,
                              ),
                            ),
                          ),
                          DropdownMenuItem(
                            value: 2,
                            child: Text(
                              S.of(context).important,
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.onSurface,
                              ),
                            ),
                          ),
                          DropdownMenuItem(
                            value: 3,
                            child: Text(
                              S.of(context).medium,
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.onSurface,
                              ),
                            ),
                          ),
                          DropdownMenuItem(
                            value: 4,
                            child: Text(
                              S.of(context).have_to_do,
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.onSurface,
                              ),
                            ),
                          ),
                          DropdownMenuItem(
                            value: 5,
                            child: Text(
                              S.of(context).if_possible,
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.onSurface,
                              ),
                            ),
                          ),
                        ],
                        onChanged: (priority) {
                          if (priority != null) {
                            _selectedPriority = priority;
                            setState(() {});
                          }
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  // кнопка сохранения
                  RoundButtonWidget(
                    onPressed: _saveTask,
                    label: S.of(context).save,
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // методы открытия обработчиков даты и времени
  Future<void> _selectDate(DateTime initialDate, TimeOfDay initialTime) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      firstDate: DateTime.now(),
      initialDate: initialDate,
      lastDate: DateTime(2127),
    );

    if (pickedDate != null && pickedDate != deadlineDate && mounted) {
      setState(() {
        deadlineDate = pickedDate;
      });
      _selectTime(initialTime);
    }
  }

  Future<void> _selectTime(TimeOfDay initialTime) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: initialTime,
    );

    if (pickedTime != null && pickedTime != deadlineTime && mounted) {
      setState(() {
        deadlineTime = pickedTime;
      });
    }
  }

  Future<bool?> _showUnsavedChangesDialog() async {
    return showDialog<bool>(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text(S.of(context).unsaved_data),
            content: Text(S.of(context).want_to_save),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text(
                  S.of(context).cancel,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: Text(
                  S.of(context).save,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
              ),
            ],
          ),
    );
  }
}
