import 'package:flutter/material.dart';

class InCallControls extends StatelessWidget {
  final VoidCallback onMute;
  final VoidCallback onEndCall;
  final VoidCallback onSwitchCamera;
  final bool isVideo;
  final bool isMuted;
  final bool isFrontCamera;

  const InCallControls({
    Key? key,
    required this.onMute,
    required this.onEndCall,
    required this.onSwitchCamera,
    this.isVideo = false,
    this.isMuted = false,
    this.isFrontCamera = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        IconButton(
          icon: Icon(isMuted ? Icons.mic_off : Icons.mic),
          color: isMuted ? Colors.red : Colors.black,
          tooltip: 'Mute/Unmute',
          onPressed: onMute,
        ),
        IconButton(
          icon: const Icon(Icons.call_end, color: Colors.red),
          tooltip: 'End Call',
          onPressed: onEndCall,
        ),
        if (isVideo)
          IconButton(
            icon: Icon(
              isFrontCamera ? Icons.replay : Icons.refresh,
            ),
            tooltip: 'Switch Camera',
            onPressed: onSwitchCamera,
          ),
      ],
    );
  }
}
