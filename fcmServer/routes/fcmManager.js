var admin = require('firebase-admin');
let db = admin.firestore();

export default async() => {
  let docRef = db.collections('schedules');
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
