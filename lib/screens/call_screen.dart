import 'package:flutter/material.dart';

import '../models/call_state.dart';
import '../widgets/in_call_controls.dart';
import '../widgets/incoming_call_dialog.dart';

class CallScreen extends StatefulWidget {
  @override
  _CallScreenState createState() => _CallScreenState();
}

class _CallScreenState extends State<CallScreen> {
  CallState _callState = CallState.Idle;
  String _callType = '';
  bool _isMuted = false;
  bool _isFrontCamera = true;

  void _startCall(String type) {
    setState(() {
      _callType = type;
      _callState = CallState.InCall;
    });
  }

  void _endCall() {
    setState(() {
      _callState = CallState.Idle;
      _callType = '';
    });
  }

  void _simulateIncomingCall() {
    setState(() {
      _callState = CallState.Ringing;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _callState == CallState.InCall
              ? (_callType == 'Audio' ? 'Voice Call' : 'Video Call')
              : 'Call Simulator',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.deepPurple,
      ),
      body: Center(
        child: _buildUIBasedOnState(),
      ),
    );
  }

  Widget _buildUIBasedOnState() {
    switch (_callState) {
      case CallState.Idle:
        return _buildIdleView();
      case CallState.Ringing:
        return IncomingCallDialog(
          onAccept: () => _startCall('Audio'),
          onDecline: _endCall,
        );
      case CallState.InCall:
        return _buildInCallView();
      default:
        return _buildIdleView();
    }
  }

  Widget _buildIdleView() {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Welcome to the Call Simulator!',
            style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () => _startCall('Audio'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                  ),
                  child: const Text(
                    'Initiate Audio Call',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
                ElevatedButton(
                  onPressed: () => _startCall('Video'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                  ),
                  child: const Text(
                    'Initiate Video Call',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
                ElevatedButton(
                  onPressed: _simulateIncomingCall,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                  ),
                  child: const Text(
                    'Simulate Incoming Call',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ]);
  }

  Widget _buildInCallView() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (_callType == 'Audio')
          CircleAvatar(
            radius: 70,
            backgroundColor: Colors.grey[300],
            child: Icon(
              Icons.person,
              size: 80,
              color: Colors.grey[700],
            ),
          ),
        if (_callType == 'Video')
          Container(
            height: 250,
            width: 250,
            color: Colors.black,
            alignment: Alignment.center,
            child: const Text(
              'Video Feed',
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
        const SizedBox(height: 30),
        InCallControls(
          isFrontCamera: _isFrontCamera,
          isMuted: _isMuted,
          onMute: _toggleMute,
          onEndCall: _endCall,
          onSwitchCamera: _toggleCamera,
          isVideo: _callType == 'Video',
        ),
      ],
    );
  }

  void _toggleMute() {
    setState(() {
      _isMuted = !_isMuted;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(_isMuted ? 'Muted' : 'Unmuted'),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  void _toggleCamera() {
    setState(() {
      _isFrontCamera = !_isFrontCamera;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(_isFrontCamera ? 'Front Camera' : 'Rear Camera'),
        duration: const Duration(seconds: 1),
      ),
    );
  }
}
