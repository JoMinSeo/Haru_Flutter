var admin = require('firebase-admin');
var firestore = require('@google-cloud/firestore');
var serviceAccount = require('constants/privateKey.json');
var topicName = 'industry-tech';
 
admin.initializeApp({
  credential: admin.credential.cert(serviceAccount)
})

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

admin.messaging().send(message)
  .then((response) => {
    // Response is a message ID string.
    console.log('Successfully sent message:', response);
  })
  .catch((error) => {
    console.log('Error sending message:', error);
  });
