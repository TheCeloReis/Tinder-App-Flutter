const serviceAccount = require("./env/service-account.json");
const { users } = require("./data/users");

const admin = require("firebase-admin");
const { getFirestore } = require("firebase-admin/firestore");

admin.initializeApp({
  credential: admin.credential.cert(serviceAccount),
});

let db = getFirestore();

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

  console.log(`Created user ${authResponse.displayName} ${authResponse.uid}`);

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
    console.log(`Created swipes for ${user.displayName} ${user.uid}`);
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

  for (const user of users.users) {
    if (user.email === "admin@celoreis.dev") continue;

    await deleteUser(user.uid);
    console.log(`Deleted user ${user.displayName} ${user.uid}`);
  }

  const chats = await db.collection("chats").get();
  for (const chat of chats.docs) {
    await chat.ref.delete();
  }
}

(async function main() {
  await deleteAllUsers();
  await createAllMatches();
})();
