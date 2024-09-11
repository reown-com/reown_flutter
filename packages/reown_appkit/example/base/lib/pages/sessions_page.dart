import 'package:flutter/material.dart';
import 'package:reown_appkit/reown_appkit.dart';

import 'package:reown_appkit_dapp/utils/constants.dart';
import 'package:reown_appkit_dapp/utils/string_constants.dart';
import 'package:reown_appkit_dapp/widgets/session_item.dart';
import 'package:reown_appkit_dapp/widgets/session_widget.dart';

class SessionsPage extends StatefulWidget {
  const SessionsPage({
    super.key,
    required this.appKit,
  });

  final ReownAppKit appKit;

  @override
  SessionsPageState createState() => SessionsPageState();
}

class SessionsPageState extends State<SessionsPage> {
  Map<String, SessionData> _activeSessions = {};
  String _selectedSession = '';

  @override
  void initState() {
    _activeSessions = widget.appKit.getActiveSessions();
    widget.appKit.onSessionDelete.subscribe(_onSessionDelete);
    widget.appKit.onSessionExpire.subscribe(_onSessionExpire);
    super.initState();
  }

  @override
  void dispose() {
    widget.appKit.onSessionDelete.unsubscribe(_onSessionDelete);
    widget.appKit.onSessionExpire.unsubscribe(_onSessionExpire);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<SessionData> sessions = _activeSessions.values.toList();
    return Center(
      child: Container(
        constraints: const BoxConstraints(
          maxWidth: StyleConstants.maxWidth,
        ),
        child: Align(
          alignment: Alignment.topCenter,
          child: SingleChildScrollView(
            child: ExpansionPanelList(
              elevation: 0.0,
              materialGapSize: 0.0,
              expansionCallback: (int index, bool isExpanded) {
                setState(() {
                  _selectedSession = !isExpanded ? '' : sessions[index].topic;
                });
              },
              children: sessions
                  .map(
                    (session) => ExpansionPanel(
                      canTapOnHeader: true,
                      isExpanded: _selectedSession == session.topic,
                      backgroundColor: Colors.blue.withOpacity(0.2),
                      headerBuilder: (context, isExpanded) {
                        return SessionItem(
                          key: ValueKey(session.topic),
                          session: session,
                        );
                      },
                      body: Container(
                        height: MediaQuery.of(context).size.height - 300.0,
                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        child: _buildSessionView(),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSessionView() {
    if (_selectedSession == '') {
      return const Center(
        child: Text(
          StringConstants.noSessionSelected,
          style: StyleConstants.titleText,
        ),
      );
    }

    final SessionData session = _activeSessions[_selectedSession]!;

    return SessionWidget(
      appKit: widget.appKit,
      session: session,
    );
  }

  void _onSessionDelete(SessionDelete? event) {
    setState(() {
      if (event!.topic == _selectedSession) {
        _selectedSession = '';
      }
      _activeSessions = widget.appKit.getActiveSessions();
    });
  }

  void _onSessionExpire(SessionExpire? event) {
    setState(() {
      if (event!.topic == _selectedSession) {
        _selectedSession = '';
      }
      _activeSessions = widget.appKit.getActiveSessions();
    });
  }
}
