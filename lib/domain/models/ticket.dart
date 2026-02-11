import 'package:flutter/material.dart';

enum RepairStatus {
  received('New', Color(0xFF3B82F6), Colors.white, Icons.fiber_new_outlined),
  inProgress(
    'In Process',
    Color(0xFFF9A20B),
    Colors.black,
    Icons.sync_outlined,
  ),
  waiting(
    'Waiting for Parts',
    Color(0xFFF97316),
    Colors.white,
    Icons.hourglass_empty_outlined,
  ),
  ready(
    'Ready for Pickup',
    Color(0xFF10B981),
    Colors.white,
    Icons.check_circle_outlined,
  ),
  completed(
    'Completed',
    Color(0xFF6B7280),
    Colors.white,
    Icons.task_alt_outlined,
  );

  final String label;
  final Color backgroundColor;
  final Color textColor;
  final IconData icon;

  const RepairStatus(
    this.label,
    this.backgroundColor,
    this.textColor,
    this.icon,
  );
}

class TicketActivity {
  final String title;
  final String date;
  final String author;
  final String? note;
  final bool isRecent;

  const TicketActivity({
    required this.title,
    required this.date,
    required this.author,
    this.note,
    this.isRecent = false,
  });
}

class RepairTicket {
  final String id;
  final String deviceName;
  final String category;
  final RepairStatus status;
  final IconData icon;
  final String? clientName;
  final String? clientPhone;
  final String? technician;
  final String? technicianName;
  final String? createdAt;
  final double? price;
  final String? description;
  final String? devicePassword;
  final List<TicketActivity>? history;

  const RepairTicket({
    required this.id,
    required this.deviceName,
    required this.category,
    required this.status,
    required this.icon,
    this.clientName,
    this.clientPhone,
    this.technician,
    this.technicianName,
    this.createdAt,
    this.price,
    this.description,
    this.devicePassword,
    this.history,
  });
}
