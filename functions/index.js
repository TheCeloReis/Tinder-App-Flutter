/**
 * Import function triggers from their respective submodules:
 *
 * const {onCall} = require("firebase-functions/v2/https");
 * const {onDocumentWritten} = require("firebase-functions/v2/firestore");
 *
 * See a full list of supported triggers at https://firebase.google.com/docs/functions
 */

const { onRequest } = require("firebase-functions/v2/https");
const logger = require("firebase-functions/logger");
const { users } = require("./data/users");
const { getFirestore } = require("firebase-admin/firestore");
const admin = require("firebase-admin");
const { setGlobalOptions } = require("firebase-functions/v2");

setGlobalOptions({ maxInstances: 10 });
admin.initializeApp();
let db = getFirestore();

// Create and deploy your first functions
// https://firebase.google.com/docs/functions/get-started

exports.helloWorld = onRequest(async (request, response) => {
  logger.info("Hello logs!", { structuredData: true });

  await deleteAllUsers();
  await createAllMatches();

  response.send("Deletei tudo e cadastrei as novinhas, papai!");
});

async function createUser({
  name,
  email,
  age,
  password,
  photos,
  profilePhoto,
  priority,
}) {
  const authResponse = await admin.auth().createUser({
    email,
    password,
    displayName: name,
  });

  const docRef = db.collection("users").doc(authResponse.uid);
  await docRef.set({
    id: authResponse.uid,
    name,
    age,
    bio: "",
    photos_path: photos,
    profile_photo_path: profilePhoto,
    typing_to: "",
    typing_at: 0,
    priority,
  });

  logger.info(`Created user ${authResponse.displayName} ${authResponse.uid}`);

  return authResponse;
}

async function createAllMatches() {
  const createdUsers = [];

  for (const user of users) {
    createdUsers.push(await createUser(user));
  }

  for (const user of createdUsers) {
    await Promise.all(
      createdUsers
        .filter((u) => u.uid !== user.uid)
        .map((u) =>
          db
            .collection("users")
            .doc(user.uid)
            .collection("swipes")
            .doc(u.uid)
            .set({ liked: false, id: u.uid })
        )
    );
    logger.info(`Created swipes for ${user.displayName} ${user.uid}`);
  }
}

async function deleteUser(uid) {
  await admin.auth().deleteUser(uid);
  await db.collection("users").doc(uid).delete();

  const swipes = await db
    .collection("users")
    .doc(uid)
    .collection("swipes")
    .get();

  for (const swipe of swipes.docs) {
    await swipe.ref.delete();
  }
}

async function deleteAllUsers() {
  const users = await admin.auth().listUsers();

  users.users.forEach((u) => logger.info(u.email));

  for (const user of users.users) {
    await deleteUser(user.uid);
    logger.info(`Deleted user ${user.displayName} ${user.uid}`);
  }

  const chats = await db.collection("chats").get();
  for (const chat of chats.docs) {
    await chat.ref.delete();
  }
}
