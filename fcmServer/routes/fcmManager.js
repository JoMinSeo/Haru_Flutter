var admin = require('firebase-admin');
let db = admin.firestore();


//firestore에서 db안에있는 일정데이터를 모두 가져오는 함수
export default async() => {
  var today = Date.now();
  let docRef = db.collections('schedules').where('date', '==', today);
  let getDoc = docRef.get().then(doc => {
    if(!doc.exists) {
      console.log('No such Documents!');
    }else{
      console.log('Document data:', doc.data());
    }
  }).catch(err => {
    console.log('Error getting document', err);
  });

  return getDoc;
}
