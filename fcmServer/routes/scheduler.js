var schedule = require('node-schedule');
var logger = require('./logger');
var manager = require('./fcmManager');

//매일 8, 10, 12, 14, 16, 18, 20에 실행된다.
var scheduler = schedule.scheduleJob("0 0 8,10,12,14,16,18,20,22 * * *", function(){
  
    admin.messaging().send(message)
    .then((response) => {
      getDocument(db);
      // Response is a message ID string.
      logger.green('Successfully sent message:', response);
    })
    .catch((error) => {
      logger.red('Error sending message:', error);
    });
  
    logger.yellow('알림을 정시에 보냈습니다.');
  })