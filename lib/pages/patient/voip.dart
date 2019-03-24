import 'dart:core';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_webrtc/webrtc.dart';
import 'package:quela/bloc/bloc.dart';
import 'package:quela/bloc/patient_dashboard_bloc.dart';
import 'package:quela/utils/hex_code.dart';
import 'package:quela/widgets/voip_signaling.dart';

class VoipConnection extends StatefulWidget {
  static String tag = 'call';

  // Needs to be set in here.
  final String ip = '192.168.1.108';

  VoipConnection({Key key}) : super(key: key);

  @override
  _VoipConnectionState createState() => _VoipConnectionState(serverIP: ip);
}

class _VoipConnectionState extends State<VoipConnection> {
  Signaling _signaling;
  String _displayName =
      Platform.localHostname + '(' + Platform.operatingSystem + ")";
  List<dynamic> _peers;
  var _selfId;
  RTCVideoRenderer _localRenderer = RTCVideoRenderer();
  RTCVideoRenderer _remoteRenderer = RTCVideoRenderer();
  bool _inCalling = false;
  final String serverIP;

  _VoipConnectionState({Key key, @required this.serverIP});

  @override
  initState() {
    super.initState();
    initRenderers();
    _connect();
    _selfId = "pV6PGqbsE2asoGqu7k8c"; // todo: use shared_pref to get this id
  }

  initRenderers() async {
    await _localRenderer.initialize();
    await _remoteRenderer.initialize();
  }

  @override
  void dispose() {
    if (_signaling != null) _signaling.close();
    _localRenderer.dispose();
    _remoteRenderer.dispose();
    super.dispose();
  }

  void _connect() async {
    if (_signaling == null) {
      _signaling = Signaling('ws://' + serverIP + ':4442', _displayName)
        ..connect();

      _signaling.onStateChange = (SignalingState state) {
        switch (state) {
          case SignalingState.CallStateNew:
            this.setState(() {
              _inCalling = true;
            });
            break;
          case SignalingState.CallStateBye:
            this.setState(() {
              _localRenderer.srcObject = null;
              _remoteRenderer.srcObject = null;
              _inCalling = false;
            });
            break;
          case SignalingState.CallStateInvite:
          case SignalingState.CallStateConnected:
          case SignalingState.CallStateRinging:
          case SignalingState.ConnectionClosed:
          case SignalingState.ConnectionError:
          case SignalingState.ConnectionOpen:
            break;
        }
      };

      _signaling.onPeersUpdate = ((event) {
        print(event['peers']);
        this.setState(() {
          //_selfId = event['self'];
          _peers = event['peers'];
        });
      });

      _signaling.onLocalStream = ((stream) {
        _localRenderer.srcObject = stream;
      });

      _signaling.onAddRemoteStream = ((stream) {
        _remoteRenderer.srcObject = stream;
      });

      _signaling.onRemoveRemoteStream = ((stream) {
        _remoteRenderer.srcObject = null;
      });
    }
  }

  _invitePeer(context, peerId, useScreen) async {
    if (_signaling != null && peerId != _selfId) {
      _signaling.invite(peerId, 'video', useScreen);
    }
  }

  _hangUp() {
    if (_signaling != null) {
      _signaling.bye();
    }
  }

  _switchCamera() {
    _signaling.switchCamera();
  }

  _muteMic() {}

  _buildRow(context, doctor) {
    return InkWell(
      onTap: () => _invitePeer(context, doctor.id, false),
      child: Container(
        margin: const EdgeInsets.symmetric(
          horizontal: 16.0,
          vertical: 10.0,
        ),
        width: MediaQuery
            .of(context)
            .size
            .width,
        height: 120,
        decoration: BoxDecoration(
          color: Colors.grey,
        ),
        child: Row(
          children: <Widget>[
            Image.network(
              "https://image.freepik.com/free-photo/doctor-smiling-with-stethoscope_1154-36.jpg",
            ),
            Container(
              width: 16,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: 8.0,
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: (MediaQuery
                          .of(context)
                          .size
                          .width / 100) * 12,
                      top: 8.0),
                  child: Text(
                    doctor.name + ' ' + doctor.surname,
                    style: TextStyle(
                      fontSize: 24.0,
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Container(
                  height: 16.0,
                ),
                Text(doctor.proficiency),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    PatientBloc _bloc = BlocProvider.of(context);
    return StreamBuilder(
      stream: _bloc.patient,
      builder: (context, AsyncSnapshot snapshot) {
        return snapshot.hasData
            ? Scaffold(
          appBar: AppBar(
            title: Text('Users on VOIP Server'),
            backgroundColor: HexColor("#0f1923"),
            actions: <Widget>[
              IconButton(
                icon: const Icon(Icons.settings),
                onPressed: null,
                tooltip: 'setup',
              ),
            ],
          ),
          floatingActionButtonLocation:
          FloatingActionButtonLocation.centerFloat,
          floatingActionButton: _inCalling
              ? SizedBox(
              width: 200.0,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    FloatingActionButton(
                      child: const Icon(Icons.switch_camera),
                      onPressed: _switchCamera,
                    ),
                    FloatingActionButton(
                      onPressed: _hangUp,
                      tooltip: 'Hangup',
                      child: Icon(Icons.call_end),
                      backgroundColor: Colors.pink,
                    ),
                    FloatingActionButton(
                      child: const Icon(Icons.mic_off),
                      onPressed: _muteMic,
                    )
                  ]))
              : null,
          body: _inCalling
              ? OrientationBuilder(builder: (context, orientation) {
            return Container(
              child: Stack(children: <Widget>[
                Positioned(
                    left: 0.0,
                    right: 0.0,
                    top: 0.0,
                    bottom: 0.0,
                    child: Container(
                      margin:
                      EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
                      width: MediaQuery
                          .of(context)
                          .size
                          .width,
                      height: MediaQuery
                          .of(context)
                          .size
                          .height,
                      child: RTCVideoView(_remoteRenderer),
                      decoration:
                      BoxDecoration(color: Colors.black54),
                    )),
                Positioned(
                  left: 20.0,
                  top: 20.0,
                  child: Container(
                    width: orientation == Orientation.portrait
                        ? 90.0
                        : 120.0,
                    height: orientation == Orientation.portrait
                        ? 120.0
                        : 90.0,
                    child: RTCVideoView(_localRenderer),
                    decoration:
                    BoxDecoration(color: Colors.black54),
                  ),
                ),
              ]),
            );
          })
              : // this is the part i will fix first. => The way it listed
          ListView.builder(
            shrinkWrap: true,
            padding: const EdgeInsets.all(0.0),
            itemCount: (_peers != null ? _peers.length : 0),
            itemBuilder: (context, i) {
              return _peers[i]['id'] != _selfId &&
                  _peers[i] == snapshot.data.doctorId[i].id
                  ? _buildRow(context, snapshot.data.doctorId[i])
                  : null;
            },
          ),
        )
        // Snapshot has no data
            : Scaffold(
          backgroundColor: HexColor("#0f1923"),
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
