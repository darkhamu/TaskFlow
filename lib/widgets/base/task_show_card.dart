import 'dart:async';

import 'package:flutter/material.dart';
import 'package:task_flow/generated/l10n.dart';
import 'package:task_flow/models/task_model.dart';
import 'package:intl/intl.dart';

import '../../utils/reminder_service.dart';

class TaskCard extends StatefulWidget {
  final TaskModel task;
  final VoidCallback onDelete;
  final VoidCallback onComplete;
  final VoidCallback onRepeat;
  final VoidCallback onTap;
  final ColorScheme colorScheme;

  const TaskCard({
    super.key,
    required this.task,
    required this.onDelete,
    required this.onComplete,
    required this.onRepeat,
    required this.onTap,
    required this.colorScheme,
  });

  @override
  State<TaskCard> createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  late Timer _timer;
  Duration _timeLeft = Duration.zero;
  late bool _isDone;

  @override
  void initState() {
    super.initState();
    _isDone = widget.task.isDone;
    _updateTimeLeft();

    _timer = Timer.periodic(const Duration(minutes: 1), (timer) {
      if (mounted) {
        setState(() => _updateTimeLeft());
      }
    });
  }

  @override
  void didUpdateWidget(covariant TaskCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.task != widget.task) {
      _isDone = widget.task.isDone;
      _updateTimeLeft();
      if (mounted) setState(() {});
    }
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _updateTimeLeft() {
    try {
      final deadline = DateTime.parse(widget.task.deadlineDate);
      final timeParts = widget.task.deadlineTime.split(':');

      final deadlineDateTime = deadline.add(
        Duration(
          hours: int.parse(timeParts[0]),
          minutes: int.parse(timeParts[1]),
        ),
      );

      _timeLeft = deadlineDateTime.difference(DateTime.now());
    } catch (e) {
      _timeLeft = Duration.zero;
    }
  }

  Color _getCardColor() {
    if (_isDone) return Colors.grey.shade200;
    if (_timeLeft.isNegative) return Colors.grey.shade900;

    final hoursLeft = _timeLeft.inHours;

    if (hoursLeft <= 12) return Colors.red.shade400;
    if (hoursLeft <= 24) return Colors.orange.shade400;
    if (hoursLeft <= 72) return Colors.yellow.shade400;
    if (hoursLeft <= 168) return Colors.green.shade400;
    return Colors.blue.shade200;
  }

  Color _getTextColor() {
    final bgColor = _getCardColor();
    if (bgColor == Colors.grey.shade900) return Colors.white;
    if (bgColor.computeLuminance() > 0.5) return Colors.black;
    return Colors.white;
  }

  String _getTimeLeftText() {
    if (_isDone) {
      return '${S.of(context).completed} ${DateFormat('dd.MM.yyyy').format(DateTime.now())}';
    }

    if (_timeLeft.isNegative) {
      return '${S.of(context).overdue} ${-_timeLeft.inDays} ${S.of(context).days}';
    }

    return '${S.of(context).you_have}: ${_timeLeft.inDays} ${S.of(context).days} '
        '${_timeLeft.inHours.remainder(24)} ${S.of(context).hours} '
        '${_timeLeft.inMinutes.remainder(60)} ${S.of(context).minutes}';
  }

  void _handleComplete() {
    setState(() {
      cancelTaskReminders(widget.task);
      _isDone = true;
    });
    widget.onComplete();
  }

  void _handleRepeat() {
    setState(() {
      _isDone = false;
    });
    widget.onRepeat();
  }

  @override
  Widget build(BuildContext context) {
    final cardColor = _getCardColor();
    final textColor = _getTextColor();
    final s = S.of(context);

    return LayoutBuilder(
      builder: (context, constraints) {
        return Card(
          color: cardColor,
          margin: const EdgeInsets.all(8),
          child: InkWell(
            borderRadius: BorderRadius.circular(8),
            onTap: widget.onTap,
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          widget.task.name,
                          style: Theme.of(
                            context,
                          ).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: textColor,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.delete, size: 20, color: textColor),
                        onPressed: widget.onDelete,
                      ),
                    ],
                  ),
                  if (widget.task.description.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: Text(
                        widget.task.description,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: textColor.withOpacity(0.8),
                        ),
                      ),
                    ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Row(
                      children: [
                        Icon(Icons.access_time, size: 16, color: textColor),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            _getTimeLeftText(),
                            style: TextStyle(color: textColor),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        '${S.of(context).priority}: ${widget.task.priority.toString()}',
                        style: TextStyle(color: textColor),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _isDone ? _handleRepeat : _handleComplete,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: textColor.withOpacity(0.1),
                        foregroundColor: textColor,
                        padding: const EdgeInsets.symmetric(vertical: 8),
                      ),
                      child: Text(_isDone ? s.repeat : s.complete),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
