import 'dart:async';

//
// import 'package:audioplayers/audioplayers.dart';
//
//
//
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_module/utils/Colors.dart';
// import 'package:flutter_module/utils/Dimens.dart';
// enum PlayerState { stopped, playing, paused }
// enum PlayingRouteState { speakers, earpiece }
//
// class PlayerWidget extends StatefulWidget {
//   final String url;
//   // final PlayerMode mode;
//   final String fileduration;
//   // PlayerWidget(
//   //     {Key key, @required this.url, this.mode = PlayerMode.MEDIA_PLAYER,this.fileduration})
//   //     : super(key: key);
//
//   @override
//   State<StatefulWidget> createState() {
//     return _PlayerWidgetState(url, mode,);
//   }
// }
//
//
// class _PlayerWidgetState extends State<PlayerWidget> {
//   String url;
//   // PlayerMode mode;
//   // AudioPlayer _audioPlayer;
//   // AudioPlayerState _audioPlayerState;
//   Duration _duration;
//   Duration _position;
//
//   PlayerState _playerState = PlayerState.stopped;
//   PlayingRouteState _playingRouteState = PlayingRouteState.speakers;
//   StreamSubscription _durationSubscription;
//   StreamSubscription _positionSubscription;
//   StreamSubscription _playerCompleteSubscription;
//   StreamSubscription _playerErrorSubscription;
//   StreamSubscription _playerStateSubscription;
//
//   // get _isPlaying => _playerState == PlayerState.playing;
//   bool _isPlaying = false;
//   get _isPaused => _playerState == PlayerState.paused;
//   get _durationText => _duration?.toString()?.split('.')?.first ?? '';
//   get _positionText => _position?.toString()?.split('.')?.first ?? '';
//
//   get _isPlayingThroughEarpiece =>
//       _playingRouteState == PlayingRouteState.earpiece;
//
//   _PlayerWidgetState(this.url, this.mode);
//
//
//   // String _file;
//   // Map<String, dynamic> _mediaInfoCache;
//   // final Map<String, Future<String>> _thumbnails = <String, Future<String>>{};
//   // final MediaInfo _mediaInfo = MediaInfo();
//
//
//   @override
//   void initState() {
//     super.initState();
//     _initAudioPlayer();
//   }
//
//   @override
//   void dispose() {
//     _durationSubscription?.cancel();
//     _positionSubscription?.cancel();
//     _playerCompleteSubscription?.cancel();
//     _playerErrorSubscription?.cancel();
//     _playerStateSubscription?.cancel();
//     _audioPlayer.stop();
//
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//
//       int mNewDuration=0;
//       String durationtext="";
//     if(url.contains(".oga")){
//       if(widget.fileduration!=null && widget.fileduration!="null" && widget.fileduration!=""){
//         int dur = int.parse(widget.fileduration)*1000;
//         mNewDuration=dur;
//         durationtext="00:00:"+widget.fileduration.toString();
//       }
//     }
//
//     return Container(
//         color: white,
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: <Widget>[
//             Row(
//               children: [
//                 IconButton(
//                   onPressed: () {
//                     print(_isPlaying);
//                     _isPlaying ? _pause() : _play();
//                   },
//                   iconSize: 40.0,
//                   icon: Icon(_isPlaying ? Icons.pause : Icons.play_arrow),
//                   color: unselectedtab,
//                 ),
//                 Slider(
//                   onChanged: (v) {
//                    if (mNewDuration!=0){
//                      final Position = v * mNewDuration;
//                      _audioPlayer.seek(Duration(milliseconds: Position.round()));
//                    }else{
//                      final Position = v * _duration.inMilliseconds;
//                      _audioPlayer.seek(Duration(milliseconds: Position.round()));
//                    }
//                   },
//                   value: (mNewDuration!=0)? (_position != null &&
//                       _duration != null &&
//                       _position.inMilliseconds > 0 &&
//                       _position.inMilliseconds < mNewDuration)
//                       ? _position.inMilliseconds / mNewDuration
//                       : 0.0  : (_position != null &&
//                           _duration != null &&
//                           _position.inMilliseconds > 0 &&
//                           _position.inMilliseconds < _duration.inMilliseconds)
//                       ? _position.inMilliseconds / _duration.inMilliseconds
//                       : 0.0,
//                 ),
//               ],
//             ),
//             (mNewDuration!=0)?  Text(
//               _position != null
//                   ? '${_positionText ?? ''} / ${durationtext ?? ''}' : _duration != null ? durationtext : '',
//               style: TextStyle(
//                   fontSize: textSizeMedium, color: textColorSecondary),
//             ): Text(
//               _position != null
//                   ? '${_positionText ?? ''} / ${_durationText ?? ''}' : _duration != null ? _durationText : '',
//               style: TextStyle(
//                   fontSize: textSizeMedium, color: textColorSecondary),
//             ),
//           ],
//         ));
//   }
//
//   void _initAudioPlayer() async{
//     // _audioPlayer = AudioPlayer(mode: mode);
//     // _durationSubscription = _audioPlayer.onDurationChanged.listen((duration) {
//     //  setState(() => _duration = duration);
//     // });
//     //
//     //
//     // _positionSubscription =
//     //     _audioPlayer.onAudioPositionChanged.listen((p) => setState(() {
//     //           _position = p;
//     //         }));
//     //
//     // _playerCompleteSubscription =
//     //     _audioPlayer.onPlayerCompletion.listen((event) {
//     //   _onComplete();
//     //   setState(() {
//     //     _position = _duration;
//     //   });
//     // });
//     //
//     //
//     // _playerErrorSubscription = _audioPlayer.onPlayerError.listen((msg) {
//     //   print('audioPlayer error : $msg');
//     //   setState(() {
//     //     _playerState = PlayerState.stopped;
//     //     _duration = Duration(seconds: 0);
//     //     _position = Duration(seconds: 0);
//     //   });
//     // });
//     //
//     // _audioPlayer.onPlayerStateChanged.listen((state) {
//     //   if (!mounted) return;
//     //   setState(() {
//     // //    _audioPlayerState = state;
//     //   });
//     // });
//     //
//     // _audioPlayer.onNotificationPlayerStateChanged.listen((state) {
//     //   if (!mounted) return;
//     //   setState(() {
//     //
//     //   });
//     // });
//     // _playingRouteState = PlayingRouteState.speakers;
//     // _play();
//   }
//
//   Future<int> _play() async {
//     setState(() {
//       _isPlaying = true;
//     });
//     final playPosition = (_position != null &&
//             _duration != null &&
//             _position.inMilliseconds > 0 &&
//             _position.inMilliseconds < _duration.inMilliseconds)
//         ? _position
//         : null;
//     final result = await _audioPlayer.play(url, position: playPosition);
//     if (result == 1) setState(() => _playerState = PlayerState.playing);
//
//     // default playback rate is 1.0
//     // this should be called after _audioPlayer.play() or _audioPlayer.resume()
//     // this can also be called everytime the user wants to change playback rate in the UI
//     _audioPlayer.setPlaybackRate(playbackRate: 1.0);
//
//     return result;
//   }
//
//   Future<int> _pause() async {
//     setState(() {
//       _isPlaying = false;
//     });
//     final result = await _audioPlayer.pause();
//     if (result == 1) setState(() => _playerState = PlayerState.paused);
//     return result;
//   }
//
//
//   Future<int> _stop() async {
//     final result = await _audioPlayer.stop();
//     if (result == 1) {
//       setState(() {
//         _playerState = PlayerState.stopped;
//         _position = Duration();
//       });
//     }
//     return result;
//   }
//
//   void _onComplete() {
//     setState(() {
//       _playerState = PlayerState.stopped;
//       _isPlaying = false;
//     });
//   }
// }
