import 'package:cloud_firestore/cloud_firestore.dart';

import 'global.dart';

/// Collections
final usersRef = FirebaseFirestore.instance.collection('Users');
final settingRef = firestore.collection('Settings');

////
CollectionReference userAccomplishments(String userid) =>
    usersRef.doc(userid).collection('Accomplishments');

CollectionReference userCustom(String userid) =>
    usersRef.doc(userid).collection('Custom');

CollectionReference userMental(String userid) =>
    usersRef.doc(userid).collection('Mental');

CollectionReference userPhysical(String userid) =>
    usersRef.doc(userid).collection('Physical');

CollectionReference userPurpose(String userid) =>
    usersRef.doc(userid).collection('Purpose');

CollectionReference userEmotional(String userid) =>
    usersRef.doc(userid).collection('Emotional');

DocumentReference userReadings(String userid) =>
    usersRef.doc(userid).collection('Readings').doc('readings');

CollectionReference freeReadings(String userid) =>
    usersRef.doc(userid).collection('FreeReadings');

CollectionReference currentExercises(String userid) =>
    usersRef.doc(userid).collection('CurrentExercise');

CollectionReference guided(String userid) =>
    usersRef.doc(userid).collection('Guided');

CollectionReference freeExercises(String userid) =>
    usersRef.doc(userid).collection('Free');

final routineRef = firestore.collection('Routines');
final utilRef = firestore.collection('Utils');

final scriptRef = firestore.collection('Scripts');
final lsrtRef = firestore.collection('Lsrt');
final erRef = firestore.collection('Er');
final connectionRef = firestore.collection('Connection');
final gratitudeRef = firestore.collection('Gratitude');
final coldRef = firestore.collection('Cold');
final dietRef = firestore.collection('Diet');
final sexualRef = firestore.collection('Sexual');
final movementRef = firestore.collection('Movement');
final goalsRef = firestore.collection('Goals');
final bdRef = firestore.collection('Behavioral Design');
final actionRef = firestore.collection('Actions');

CollectionReference userListening(String userid) =>
    usersRef.doc(userid).collection('Listenings');

CollectionReference todayRoutines(String userid) =>
    usersRef.doc(userid).collection('TodayRoutines');

CollectionReference accomplsihmentRef(String userid) =>
    usersRef.doc(userid).collection('Accomplish');
