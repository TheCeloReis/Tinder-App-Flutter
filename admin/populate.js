const serviceAccount = require("./env/service-account.json");
const { users } = require("./data/users");

const admin = require("firebase-admin");
const { getFirestore } = require("firebase-admin/firestore");

async function createUser({ name, email, password, photos, profilePhoto }) {
  const authResponse = await admin.auth().createUser({
    email,
    password,
    displayName: name,
  });

  const docRef = db.collection("users").doc(authResponse.uid);
  docRef.set({
    id: authResponse.uid,
    name,
    age: 18,
    bio: "",
    photos_path: photos,
    profile_photo_path: profilePhoto,
  });
}

async function createAllMatches() {
  for (const user of users) {
    await createUser(user);
  }
}

async function deleteUser(uid) {
  await admin.auth().deleteUser(uid);
  await db.collection("users").doc(uid).delete();
}

async function deleteAllUsers() {
  const users = await admin.auth().listUsers();

  for (const user of users.users) {
    if (user.email === "admin@celoreis.dev") continue;

    await deleteUser(user.uid);
  }
}

let db = null;

function intialize() {
  admin.initializeApp({
    credential: admin.credential.cert(serviceAccount),
  });

  db = getFirestore();
}

(async function main() {
  intialize();

  createAllMatches();
})();
