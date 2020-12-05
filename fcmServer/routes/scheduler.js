var schedule = require("node-schedule");
var manager = require("./fcmManager");
var admin = require("firebase-admin");

//매일 8, 10, 12, 14, 16, 18, 20에 실행된다.
function schedulerfun() {
  return schedule.scheduleJob("0 0 8,10,12,14,16,18,20,22 * * *", async () => {
    const data = manager();

    var tokens = [];

    for(var token of data.token){
      tokens.push(token.data().token);
    }

    //firebase admin 메시지 코드
    const message = {
      notification: {
        icon: null,
        title: data.title,
        body: data.content,
        sound: "default",
      },
      android: {
        notification: {
          click_action: "news_intent",
        },
      },
      apns: {
        payload: {
          aps: {
            category: "INVITE_CATEGORY",
          },
        },
      },
    };

    admin
      .messaging()
      .sendToDevice(tokens, message)
      .then((response) => {
        // Response is a message ID string.
        console.log("Successfully sent message:", response);
      })
      .catch((error) => {
        console.log("Error sending message:", error);
      });

    console.log("알림을 정시에 보냈습니다.");
  });
}

exports.schedulerfun = schedulerfun();
