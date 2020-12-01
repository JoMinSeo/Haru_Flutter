var schedule = require("node-schedule");
var logger = require("./logger");
var manager = require("./fcmManager");
var admin = require("firebase-admin");

//매일 8, 10, 12, 14, 16, 18, 20에 실행된다.
export default async () => {
  schedule.scheduleJob("0 0 8,10,12,14,16,18,20,22 * * *", async () => {
    manager();

    //firebase admin 메시지 코드
    const message = {
      token: "afkjfkajflkajflafj",
      notification: {
        icon: null,
        title: "자세한 내용 보기",
        body: "",
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
      topic: topicName,
    };

    admin
      .messaging()
      .send(message)
      .then((response) => {
        // Response is a message ID string.
        logger.green("Successfully sent message:", response);
      })
      .catch((error) => {
        logger.red("Error sending message:", error);
      });

    logger.yellow("알림을 정시에 보냈습니다.");
  });
};
