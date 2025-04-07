import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:task_manager_coding_test/features/tasks/data/models/task.dart';
import 'package:task_manager_coding_test/main.dart';

class CreateTaskWidget extends StatefulWidget {
  const CreateTaskWidget({super.key});

  @override
  State<CreateTaskWidget> createState() => _CreateTaskWidgetState();
}

class _CreateTaskWidgetState extends State<CreateTaskWidget> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  DateTime? _dueDate;
  TimeOfDay? _dueTime;
  int _priority = 0; // 0: None, 1: Low, 2: Medium, 3: High
  bool _isLoading = false;
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  // Format date for display (showing "Today" for today's date)
  String _formatDate(DateTime date) {
    final now = DateTime.now();
    if (date.year == now.year &&
        date.month == now.month &&
        date.day == now.day) {
      return 'Today';
    }
    return DateFormat('dd MMMM, yyyy').format(date);
  }

  // Format time for display
  String _formatTime(TimeOfDay time) {
    final now = DateTime.now();
    final dt = DateTime(now.year, now.month, now.day, time.hour, time.minute);
    return DateFormat('hh:mm a').format(dt);
  }

  // Format date and time together as requested
  String _formatDateTime(DateTime date, TimeOfDay time) {
    final dateStr = _formatDate(date);
    final timeStr = _formatTime(time);
    return '$dateStr $timeStr';
  }

  // Show date picker
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _dueDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != _dueDate) {
      setState(() {
        _dueDate = picked;
        // If date was selected but no time, default to current time
        _dueTime ??= TimeOfDay.now();
      });
    }
  }

  // Show time picker
  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _dueTime ?? TimeOfDay.now(),
    );
    if (picked != null && picked != _dueTime) {
      setState(() {
        _dueTime = picked;
      });
    }
  }

  // Create task
  Future<void> _createTask() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
    });

    String? formattedDueDate;
    int? dueDateMillis;

    // Prepare the date-time string and milliseconds
    if (_dueDate != null && _dueTime != null) {
      final dueDateTime = DateTime(
        _dueDate!.year,
        _dueDate!.month,
        _dueDate!.day,
        _dueTime!.hour,
        _dueTime!.minute,
      );

      // Store as milliseconds for sorting/comparison
      dueDateMillis = dueDateTime.millisecondsSinceEpoch;

      // Format as requested
      formattedDueDate = _formatDateTime(_dueDate!, _dueTime!);
    }

    // Create a task object
    final task = Task(
      title: _titleController.text,
      description: _descriptionController.text,
      date: formattedDueDate!,
      priority: _priority == 0
          ? TaskPriority.low.name
          : _priority == 1
              ? TaskPriority.medium.name
              : TaskPriority.high.name,
      status: TaskStatus.incomplete.name, // 0 for not completed
    );

    // Save to database
    final result = await sqflite.createTask(task);

    setState(() {
      _isLoading = false;
    });

    if (result != -1) {
      // Task created successfully
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Task created successfully')),
        );
        Navigator.pop(
            context, true); // Return true to indicate task was created
      }
    } else {
      // Failed to create task
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to create task')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        top: 16,
        left: 16,
        right: 16,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header with close button
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'New Task',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Title field
              Container(
                decoration: BoxDecoration(
                  color: isDarkMode ? Colors.black12 : Colors.grey[100],
                  borderRadius: BorderRadius.circular(10),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                child: TextFormField(
                  controller: _titleController,
                  decoration: const InputDecoration(
                    hintText: 'Title',
                    border: InputBorder.none,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a title';
                    }
                    return null;
                  },
                  style: const TextStyle(fontSize: 16),
                ),
              ),
              const SizedBox(height: 12),

              // Description field
              Container(
                decoration: BoxDecoration(
                  color: isDarkMode ? Colors.black12 : Colors.grey[100],
                  borderRadius: BorderRadius.circular(10),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                child: TextFormField(
                  controller: _descriptionController,
                  decoration: const InputDecoration(
                    hintText: 'Notes',
                    border: InputBorder.none,
                  ),
                  minLines: 3,
                  maxLines: 5,
                  style: const TextStyle(fontSize: 16),
                ),
              ),
              const SizedBox(height: 16),

              // Due date & time combined
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: Icon(Icons.calendar_today,
                    color: Theme.of(context).colorScheme.primary),
                title: const Text('Due Date & Time'),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      (_dueDate != null && _dueTime != null)
                          ? '${_formatDate(_dueDate!)} ${_formatTime(_dueTime!)}'
                          : 'None',
                      style: TextStyle(
                        color: (_dueDate != null && _dueTime != null)
                            ? null
                            : Colors.grey,
                      ),
                    ),
                    const Icon(Icons.chevron_right),
                  ],
                ),
                onTap: () async {
                  await _selectDate(context);
                  if (_dueDate != null && mounted) {
                    await _selectTime(context);
                  }
                },
              ),

              // Priority picker
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: Icon(Icons.flag,
                    color: Theme.of(context).colorScheme.primary),
                title: const Text('Priority'),
                trailing: DropdownButton<int>(
                  value: _priority,
                  underline: const SizedBox(),
                  items: const [
                    DropdownMenuItem(
                      value: 0,
                      child: Text('None'),
                    ),
                    DropdownMenuItem(
                      value: 1,
                      child: Text('Low'),
                    ),
                    DropdownMenuItem(
                      value: 2,
                      child: Text('Medium'),
                    ),
                    DropdownMenuItem(
                      value: 3,
                      child: Text('High'),
                    ),
                  ],
                  onChanged: (value) {
                    setState(() {
                      _priority = value!;
                    });
                  },
                ),
              ),

              const SizedBox(height: 24),

              // Create button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _createTask,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: _isLoading
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.white),
                          ),
                        )
                      : const Text(
                          'Create Task',
                          style: TextStyle(fontSize: 16),
                        ),
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
