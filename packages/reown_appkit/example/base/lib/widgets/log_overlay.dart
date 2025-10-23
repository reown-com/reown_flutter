import 'dart:async';
import 'package:flutter/material.dart';

class LogOverlay extends StatefulWidget {
  final List<String> logs;
  final VoidCallback? onClear;
  final VoidCallback? onToggle;

  const LogOverlay({
    super.key,
    required this.logs,
    this.onClear,
    this.onToggle,
  });

  @override
  State<LogOverlay> createState() => _LogOverlayState();
}

class _LogOverlayState extends State<LogOverlay> {
  bool _isExpanded = true;
  Offset _position = const Offset(0, 100);
  bool _isDragging = false;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: _position.dx,
      top: _position.dy,
      child: GestureDetector(
        onPanStart: (details) {
          _isDragging = true;
        },
        onPanUpdate: (details) {
          if (_isDragging) {
            setState(() {
              _position += details.delta;
            });
          }
        },
        onPanEnd: (details) {
          _isDragging = false;
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: MediaQuery.of(context).size.width,
          height: (_isExpanded ? 400 : 100),
          decoration: BoxDecoration(
            color: Colors.black.withValues(alpha: 0.8),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.withValues(alpha: 0.3)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.3),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            children: [
              // Header
              Container(
                height: 48,
                decoration: BoxDecoration(
                  color: Colors.grey.withValues(alpha: 0.2),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                  ),
                ),
                child: Row(
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12),
                      child: Icon(
                        Icons.bug_report,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                    const Text(
                      'AppKit Logs',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                      icon: Icon(
                        _isExpanded
                            ? Icons.close_fullscreen
                            : Icons.open_in_full,
                        color: Colors.white,
                        size: 20,
                      ),
                      onPressed: () {
                        setState(() {
                          _isExpanded = !_isExpanded;
                        });
                      },
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.cleaning_services_rounded,
                        color: Colors.white,
                        size: 20,
                      ),
                      onPressed: widget.onClear,
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.close,
                        color: Colors.white,
                        size: 20,
                      ),
                      onPressed: widget.onToggle,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(8),
                  child: _isExpanded
                      ? _buildExpandedContent()
                      : _buildCollapsedContent(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildExpandedContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Log count
        Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Text(
            'Logs: ${widget.logs.length}',
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 12,
            ),
          ),
        ),
        // Logs list
        Expanded(
          child: widget.logs.isEmpty
              ? const Center(
                  child: Text(
                    'No logs yet',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                    ),
                  ),
                )
              : ListView.builder(
                  reverse: true, // Show newest logs at top
                  itemCount: widget.logs.length,
                  itemBuilder: (context, index) {
                    final log = widget.logs[widget.logs.length - 1 - index];
                    return Container(
                      margin: const EdgeInsets.only(bottom: 4),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.grey.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        log,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 11,
                          fontFamily: 'monospace',
                        ),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    );
                  },
                ),
        ),
      ],
    );
  }

  Widget _buildCollapsedContent() {
    return Center(
      child: Text(
        widget.logs.isEmpty
            ? 'No logs'
            : 'Latest: ${widget.logs.isNotEmpty ? widget.logs.last : ''}',
        style: const TextStyle(
          color: Colors.white,
          fontSize: 12,
        ),
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        textAlign: TextAlign.center,
      ),
    );
  }
}

class LogManager {
  static final LogManager _instance = LogManager._internal();
  factory LogManager() => _instance;
  LogManager._internal();

  final List<String> _logs = [];
  final StreamController<List<String>> _logsController =
      StreamController<List<String>>.broadcast();

  List<String> get logs => List.unmodifiable(_logs);
  Stream<List<String>> get logsStream => _logsController.stream;

  void addLog(String log) {
    _logs.add(log);
    // Keep only last 100 logs to prevent memory issues
    if (_logs.length > 100) {
      _logs.removeAt(0);
    }
    _logsController.add(List.unmodifiable(_logs));
  }

  void clearLogs() {
    _logs.clear();
    _logsController.add(List.unmodifiable(_logs));
  }

  void dispose() {
    _logsController.close();
  }
}
