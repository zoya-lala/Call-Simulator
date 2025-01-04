enum CallState {
  Idle, // The app is in an idle state, no ongoing or incoming calls
  Ringing, // An incoming call is being simulated
  InCall, // The user is currently in a call
  CallEnded, // The call has ended (optional, if you want to handle post-call UI)
}
