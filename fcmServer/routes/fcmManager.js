const admin = require('firebase-admin');
const firestore = admin.firestore();

//firestore에서 db안에있는 일정데이터를 모두 가져오는 함수
async function fcmManager() {
  var today = Date.now();
  var docRef = firestore.collections('schedule').where('date', '>=', today);
  var tutorials = [];
  await docRef.get().then((snapshot) => {
    if(snapshot.empty){
      console.log("데이터가 비었습니다.");
    }
    snapshot.docs.forEach((childSnapshot) => {
      var title = childSnapshot.title;
      var content = childSnapshot.content;
      var token = childSnapshot.token;

      tutorials.push({ title: title, content: content, token: token });
      console.log(tutorials);
    });
  });

  return tutorials;
}

exports.fcmManager = fcmManager();
