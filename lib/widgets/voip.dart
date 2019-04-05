import 'dart:async';
import 'dart:core';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_webrtc/webrtc.dart';
import 'package:quela/bloc/blocs.dart';
import 'package:quela/models/doctor.dart';
import 'package:quela/models/patient.dart';
import 'package:quela/pages/doctor/dashboard_body.dart';
import 'package:quela/utils/hex_code.dart';
import 'package:quela/widgets/voip_signaling.dart';

class VoipConnection extends StatefulWidget {
  static String tag = 'call';

  // Needs to be set in here.
  final String ip = '192.168.1.108';

  final Patient patient;
  final Doctor doctor;
  final bool isDoctor;

  VoipConnection({Key key, this.patient, this.doctor, @required this.isDoctor})
      : super(key: key);

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
  final Future<String> userId = new Auth().getUser();
  bool isOnline;

  _VoipConnectionState({Key key, @required this.serverIP});

  @override
  initState() {
    super.initState();
    initRenderers();
    _connect();
    _selfId = _initUserName();
    isOnline = false;
  }

  _initUserName() async {
    String _id;
    _id = await userId;
    return _id;
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

  Widget _testChildBuilder(entity) {
    // _invitePeer(context, entity.id, false),
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 45.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(50.0),
            child: Image.network(
              entity.profilePic,
              width: 150,
              height: 150,
              fit: BoxFit.fill,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 25.0),
          child: Text(
            "${entity.name} ${entity.surname}",
            softWrap: true,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        (entity is PatientId)
            ? Container()
            : Text(
                "Hearth and Brain Specialist",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.w400,
                  fontSize: 20.0,
                ),
              ),
        Padding(
          padding: const EdgeInsets.only(top: 5.0),
          child: (entity is PatientId)
              ? Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 15.0, top: 15.0),
                      child: RaisedButton(
                        onPressed: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DetailsPage(
                                      patient: entity,
                                    ),
                              ),
                            ),
                        child: Container(
                          width: 70.0,
                          height: 70.0,
                          child: Icon(
                            Icons.dehaze,
                            color: Colors.white,
                          ),
                        ),
                        shape: CircleBorder(),
                        color: Colors.blue,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 15.0),
                      child: RaisedButton(
                        onPressed: isOnline
                            ? () => _invitePeer(context, entity.id, false)
                            : null,
                        child: Container(
                          width: 70.0,
                          height: 70.0,
                          child: Icon(
                            Icons.call,
                            color: Colors.white,
                          ),
                        ),
                        shape: CircleBorder(),
                        color: Colors.blue,
                      ),
                    ),
                  ],
                )
              : Padding(
                  padding: const EdgeInsets.only(top: 25.0),
                  child: RaisedButton(
                    onPressed: isOnline
                        ? () => _invitePeer(context, entity.id, false)
                        : null,
                    child: Container(
                      width: 70.0,
                      height: 70.0,
                      child: Icon(
                        Icons.call,
                        color: Colors.white,
                      ),
                    ),
                    shape: CircleBorder(),
                    color: Colors.blue,
                  ),
                ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final List availableEntities = _buildPatientPeerMergedList(_peers,
        widget.isDoctor ? widget.doctor.patientId : widget.patient.doctorId);
    return Scaffold(
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
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
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
                        margin: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                        child: RTCVideoView(_remoteRenderer),
                        decoration: BoxDecoration(color: Colors.black54),
                      )),
                  Positioned(
                    left: 20.0,
                    top: 20.0,
                    child: Container(
                      width: orientation == Orientation.portrait ? 90.0 : 120.0,
                      height:
                          orientation == Orientation.portrait ? 120.0 : 90.0,
                      child: RTCVideoView(_localRenderer),
                      decoration: BoxDecoration(color: Colors.black54),
                    ),
                  ),
                ]),
              );
            })
          : // this is the part i will fix first. => The way it listed
          ListView.builder(
              padding: const EdgeInsets.symmetric(
                vertical: 50.0,
                horizontal: 15.0,
              ),
              shrinkWrap: true,
              itemCount: widget.isDoctor
                  ? widget.doctor.patientId.length
                  : widget.patient.doctorId.length,
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, i) {
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10.0),
                  width: 230.0,
                  height: 200.0,
                  decoration: BoxDecoration(
                    color: _colorBuilder(availableEntities),
                    borderRadius: BorderRadius.all(Radius.circular(120.0)),
                  ),
                  child: _testChildBuilder(widget.isDoctor
                      ? widget.doctor.patientId[i]
                      : widget.patient.doctorId[i]),
                );
              },
            ),
    );
  }

  Color _colorBuilder(List available) {
    Color online = Colors.green;
    Color offline = Colors.red;

    print(available);

    if (widget.isDoctor && available.isNotEmpty) {
      for (int i = 0; i < available.length; i++)
        for (int j = 0; j < widget.doctor.patientId.length; j++)
          if (widget.doctor.patientId[j].id == available[i].id) {
            isOnline = true;
            return online;
          }
    } else if (!widget.isDoctor && available.isNotEmpty) {
      for (int i = 0; i < available.length; i++)
        for (int j = 0; j < widget.patient.doctorId.length; j++)
          if (available[i].id == widget.patient.doctorId[j].id) {
            isOnline = true;
            return online;
          }
    }

    isOnline = false;
    return offline;
  }

  _buildPatientPeerMergedList(List peers, List entity) {
    List _available = [];
    int peerLen;

    // This is required for null exception
    if (peers == null)
      peerLen = 0;
    else
      peerLen = peers.length;

    for (int i = 0; i < entity.length; i++)
      for (int j = 0; j < peerLen; j++)
        if (peers[j]['id'] == entity[i].id) _available.insert(i, entity[i]);

    return _available;
  }
}
