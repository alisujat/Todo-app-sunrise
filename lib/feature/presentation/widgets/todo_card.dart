import 'package:flutter/material.dart';
import 'package:todo_app/core/widets/reusable_text.dart';

class TodoCard extends StatefulWidget {
  final String title;
  final String desc;
  final String createdAt;
  final bool isCompleted;
  final VoidCallback markComplete;
  final VoidCallback edit;
  final VoidCallback delete;
  const TodoCard({
    super.key,
    required this.title,
    required this.desc,
    required this.createdAt,
    required this.isCompleted,
    required this.markComplete,
    required this.edit,
    required this.delete,
  });

  @override
  State<TodoCard> createState() => _TodoCardState();
}

class _TodoCardState extends State<TodoCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: widget.isCompleted ? Colors.green : Colors.black12,
          ),
          color: Theme.of(context).colorScheme.onSecondary,
          borderRadius: BorderRadius.circular(12.0),
          boxShadow: [
            BoxShadow(
              color: widget.isCompleted ? Colors.green : Colors.black12,
              blurRadius: 4.0,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ReusableText(
                    text: widget.title,
                    fontWeight: FontWeight.bold,
                    textColor: Theme.of(context).colorScheme.primary,
                  ),

                  Row(
                    children: [
                      GestureDetector(
                        onTap: widget.edit,
                        child: Icon(
                          Icons.edit,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                      const SizedBox(width: 16),
                      GestureDetector(
                        onTap: widget.delete,
                        child: Icon(Icons.delete, color: Colors.red),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 4.0),
              ReusableText(
                text: widget.desc,
                fontSize: 12,
                textColor: Theme.of(context).colorScheme.primary,
              ),
              const SizedBox(height: 8.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ReusableText(
                    text: widget.createdAt,
                    fontSize: 12,
                    textColor: Theme.of(context).colorScheme.primary,
                  ),
                  GestureDetector(
                    onTap: widget.markComplete,
                    child: Row(
                      children: [
                        ReusableText(
                          text: 'Status - ',
                          fontSize: 14,
                          textColor: Theme.of(context).colorScheme.primary,
                        ),
                        const SizedBox(width: 8),
                        widget.isCompleted
                            ? ReusableText(
                                text: 'Completed',
                                fontSize: 14,
                                textColor: widget.isCompleted
                                    ? Colors.green
                                    : Theme.of(context).colorScheme.primary,
                              )
                            : ReusableText(
                                text: 'In-Completed',
                                fontSize: 14,
                                textColor: widget.isCompleted
                                    ? Colors.green
                                    : Theme.of(context).colorScheme.primary,
                              ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
