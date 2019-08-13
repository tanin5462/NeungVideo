import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:neung_video/models/video_model.dart';
import 'package:neung_video/screens/video_player.dart';

class VideoListView extends StatefulWidget {
  @override
  _VideoListViewState createState() => _VideoListViewState();
}

class _VideoListViewState extends State<VideoListView> {
  // Variable
  Firestore fireStore = Firestore.instance;
  StreamSubscription<QuerySnapshot> subscription;
  List<DocumentSnapshot> snapshots;
  List<VideoModel> videoModels = [];

  // Methods
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    readFirestore();
  }

  Future<void> readFirestore() async {
    CollectionReference collectionReference = fireStore.collection('video');
    subscription = await collectionReference.snapshots().listen((dataSnapshot) {
      snapshots = dataSnapshot.documents;
      for (var snapshot in snapshots) {
        String nameString = snapshot.data['Name'];
        String detailString = snapshot.data['Details'];
        String picturePath = snapshot.data['PicturePath'];
        String videoPath = snapshot.data['VideoPath'];

        // print(
        //     'Name = $nameString,Details = $detailString , picturePath= $picturePath,videoPath= $videoPath');

        VideoModel videoModel =
            VideoModel(nameString, detailString, picturePath, videoPath);
        setState(() {
          videoModels.add(videoModel);
        });
      }
    });
  }

  Widget showVideoListView() {
    return ListView.builder(
      itemCount: videoModels.length,
      itemBuilder: (
        BuildContext context,
        int index,
      ) {
        // Click able row is GestureDetector ทำให้สามารถใส่ Event ได้
        return GestureDetector(
          child: Row(
            children: <Widget>[
              showImage(index),
              showText(index),
            ],
          ),
          onTap: () {
            MaterialPageRoute materialPageRoute = MaterialPageRoute(
              builder: (BuildContext context) => VideoPlayer(
                videoModel: videoModels[index],
              ),
            );
            Navigator.of(context).push(materialPageRoute);
          },
        );
      },
    );
  }

  Widget showImage(int index) {
    return Container(
      padding: EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0),
      width: MediaQuery.of(context).size.width * 0.5,
      child: Image.network(
        videoModels[index].picturePath,
        fit: BoxFit.contain,
      ),
    );
  }

  Widget showText(int index) {
    return Column(
      children: <Widget>[showName(index), showDetails(index)],
    );
  }

  Widget showName(int index) {
    return Container(
      padding: EdgeInsets.all(8.0),
      width: MediaQuery.of(context).size.width * 0.5,
      alignment: Alignment.topLeft,
      child: Text(
        videoModels[index].name,
        style: TextStyle(fontSize: 24, color: Colors.blueGrey),
      ),
    );
  }

  Widget showDetails(int index) {
    String detailShort = videoModels[index].detail;
    if (detailShort.length > 50) {
      detailShort = detailShort.substring(0, 50);
      detailShort = '$detailShort ...';
    }
    return Container(
      width: MediaQuery.of(context).size.width * 0.5,
      child: Text(detailShort),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(child: showVideoListView());
  }
}
