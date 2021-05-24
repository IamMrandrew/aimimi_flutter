import * as functions from "firebase-functions";
import * as admin from "firebase-admin";
import fire from "firebase";
admin.initializeApp();
const firebase = admin.firestore();

exports.dailySchedule = functions.pubsub
  .schedule("0 0 * * * ")
  .onRun(async (context) => {
    console.log("This will be run every day at 00:00!");
    const usersQuerySnapshot = await firebase.collection("users").get();

    usersQuerySnapshot.docs.forEach(async (user) => {
      const goalQuerySnapshot = await firebase
        .collection("users")
        .doc(user.id)
        .collection("goals")
        .get();

      goalQuerySnapshot.docs.forEach((goal) => {
        const checkedIn = goal.data()["checkedIn"];
        const checkInSuccess = goal.data()["checkInSuccess"];
        const dayPassed = goal.data()["dayPassed"];
        const timespan = goal.data()["goal"]["timespan"];

        if (!checkedIn) {
          const newAccuracy = (checkInSuccess / (dayPassed + 1)) * 100;
          // Clear check in, day passed and update accuracy in user's goal
          firebase
            .collection("users")
            .doc(user.id)
            .collection("goals")
            .doc(goal.id)
            .update({
              checkIn: 0,
              dayPassed: dayPassed + 1,
              accuracy: newAccuracy,
            })
            .then(() => {
              // Update accuracy in goal's user
              firebase
                .collection("goals")
                .doc(goal.id)
                .collection("users")
                .doc(user.id)
                .update({
                  accuracy: newAccuracy,
                });

              // Move to completed/ delete in user's goal
              const completedAGoal = dayPassed + 1 >= timespan;
              const completeSuccessful = newAccuracy >= 60;

              if (completedAGoal) {
                firebase
                  .collection("users")
                  .doc(user.id)
                  .collection("goals")
                  .doc(goal.id)
                  .delete();
                if (completeSuccessful) {
                  firebase
                    .collection("users")
                    .doc(user.id)
                    .collection("completed")
                    .doc(goal.id)
                    .set(goal.data()["goal"]);
                  firebase.collection("feeds").add({
                    content: `${user.data()["username"]}  completed ${
                      goal.data()["title"]
                    }!!`,
                    createdAt: fire.firestore.Timestamp.now(),
                    createdBy: {
                      uid: user.id,
                      username: user.data()["username"],
                    },
                    goalID: goal.id,
                    likes: [],
                  });
                }
              }
            });
        } else {
          // Clear check in, reset checked in in user's goal
          firebase
            .collection("users")
            .doc(user.id)
            .collection("goals")
            .doc(goal.id)
            .update({
              checkIn: 0,
              checkedIn: false,
            });
        }
      });
    });

    return null;
  });
