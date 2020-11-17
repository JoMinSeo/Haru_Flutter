var admin = require('firebase-admin');
var Firestore = require('@google-cloud/firestore');
var serviceAccount = require('constants/privateKey.json');
var path = require('path');

var topicName = 'industry-tech';
let db = admin.firestore();
 
function initializeApp(){
  admin.initializeApp({
    credential: admin.credential.cert(serviceAccount)
  });
}

class FcmManager {
  constructor(){
    this.firestore = new FireStore({
      projectId: 'haru-ff3d2',
      keyFilename: path.join(__dirname, './constants/service-account.json')
    })
  }
}

function getDocument(db){
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

var message = {
  notification: {
    title: '자세한 내용 보기'
  },
  android:{
    notification:{
      click_action: 'news_intent'
    }
  },
  apns:{
    payload:{
      aps:{
        'category':'INVITE_CATEGORY'
      }
    }
  },
  topic: topicName,
};

module.exports = new FcmManager();