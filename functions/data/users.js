const users = [
  {
    name: "Conceição",
    email: "conceicao@celoreis.dev",
    age: 57,
    password: "123456",
    profilePhoto:
      "https://firebasestorage.googleapis.com/v0/b/tinder-clone-9de83.appspot.com/o/scripted_photos%2Fconceicao%2F1.jpg?alt=media&token=358f1689-238a-4851-946b-c349dec04c39&_gl=1*1rgc4l3*_ga*MTM0Mjg4MTU3Ni4xNjg0MjM2NTYy*_ga_CW55HF8NVT*MTY4NTQ1MzAzNi45LjEuMTY4NTQ1OTQ0OC4wLjAuMA..",
    photos: [
      "https://firebasestorage.googleapis.com/v0/b/tinder-clone-9de83.appspot.com/o/scripted_photos%2Fconceicao%2F2.jpg?alt=media&token=358f1689-238a-4851-946b-c349dec04c39&_gl=1*1rgc4l3*_ga*MTM0Mjg4MTU3Ni4xNjg0MjM2NTYy*_ga_CW55HF8NVT*MTY4NTQ1MzAzNi45LjEuMTY4NTQ1OTQ0OC4wLjAuMA..",
      "https://firebasestorage.googleapis.com/v0/b/tinder-clone-9de83.appspot.com/o/scripted_photos%2Fconceicao%2F4.jpg?alt=media&token=358f1689-238a-4851-946b-c349dec04c39&_gl=1*1rgc4l3*_ga*MTM0Mjg4MTU3Ni4xNjg0MjM2NTYy*_ga_CW55HF8NVT*MTY4NTQ1MzAzNi45LjEuMTY4NTQ1OTQ0OC4wLjAuMA..",
      "https://firebasestorage.googleapis.com/v0/b/tinder-clone-9de83.appspot.com/o/scripted_photos%2Fconceicao%2F5.jpg?alt=media&token=358f1689-238a-4851-946b-c349dec04c39&_gl=1*1rgc4l3*_ga*MTM0Mjg4MTU3Ni4xNjg0MjM2NTYy*_ga_CW55HF8NVT*MTY4NTQ1MzAzNi45LjEuMTY4NTQ1OTQ0OC4wLjAuMA..",
    ],
    priority: 4,
  },
  {
    name: "Descubra",
    email: "descubra@celoreis.dev",
    age: 41,
    password: "123456",
    profilePhoto:
      "https://firebasestorage.googleapis.com/v0/b/tinder-clone-9de83.appspot.com/o/scripted_photos%2Fdescubra%2F1.jpg?alt=media&token=358f1689-238a-4851-946b-c349dec04c39&_gl=1*1rgc4l3*_ga*MTM0Mjg4MTU3Ni4xNjg0MjM2NTYy*_ga_CW55HF8NVT*MTY4NTQ1MzAzNi45LjEuMTY4NTQ1OTQ0OC4wLjAuMA..",
    photos: [
      "https://firebasestorage.googleapis.com/v0/b/tinder-clone-9de83.appspot.com/o/scripted_photos%2Fdescubra%2F2.jpg?alt=media&token=358f1689-238a-4851-946b-c349dec04c39&_gl=1*1rgc4l3*_ga*MTM0Mjg4MTU3Ni4xNjg0MjM2NTYy*_ga_CW55HF8NVT*MTY4NTQ1MzAzNi45LjEuMTY4NTQ1OTQ0OC4wLjAuMA..",
    ],
    priority: 8,
  },
  {
    name: "Iraci",
    email: "iraci@celoreis.dev",
    age: 62,
    password: "123456",
    profilePhoto:
      "https://firebasestorage.googleapis.com/v0/b/tinder-clone-9de83.appspot.com/o/scripted_photos%2Firaci%2F1.jpeg?alt=media&token=358f1689-238a-4851-946b-c349dec04c39&_gl=1*1rgc4l3*_ga*MTM0Mjg4MTU3Ni4xNjg0MjM2NTYy*_ga_CW55HF8NVT*MTY4NTQ1MzAzNi45LjEuMTY4NTQ1OTQ0OC4wLjAuMA..",
    photos: [
      "https://firebasestorage.googleapis.com/v0/b/tinder-clone-9de83.appspot.com/o/scripted_photos%2Firaci%2F2.jpeg?alt=media&token=358f1689-238a-4851-946b-c349dec04c39&_gl=1*1rgc4l3*_ga*MTM0Mjg4MTU3Ni4xNjg0MjM2NTYy*_ga_CW55HF8NVT*MTY4NTQ1MzAzNi45LjEuMTY4NTQ1OTQ0OC4wLjAuMA..",
    ],
    priority: 9,
  },
  {
    name: "Josefina",
    email: "josefina@celoreis.dev",
    age: 45,
    password: "123456",
    profilePhoto:
      "https://firebasestorage.googleapis.com/v0/b/tinder-clone-9de83.appspot.com/o/scripted_photos%2Fjosefina%2F1.jpg?alt=media&token=358f1689-238a-4851-946b-c349dec04c39&_gl=1*1rgc4l3*_ga*MTM0Mjg4MTU3Ni4xNjg0MjM2NTYy*_ga_CW55HF8NVT*MTY4NTQ1MzAzNi45LjEuMTY4NTQ1OTQ0OC4wLjAuMA..",
    photos: [
      "https://firebasestorage.googleapis.com/v0/b/tinder-clone-9de83.appspot.com/o/scripted_photos%2Fjosefina%2F2.jpg?alt=media&token=358f1689-238a-4851-946b-c349dec04c39&_gl=1*1rgc4l3*_ga*MTM0Mjg4MTU3Ni4xNjg0MjM2NTYy*_ga_CW55HF8NVT*MTY4NTQ1MzAzNi45LjEuMTY4NTQ1OTQ0OC4wLjAuMA..",
      "https://firebasestorage.googleapis.com/v0/b/tinder-clone-9de83.appspot.com/o/scripted_photos%2Fjosefina%2F3.jpg?alt=media&token=358f1689-238a-4851-946b-c349dec04c39&_gl=1*1rgc4l3*_ga*MTM0Mjg4MTU3Ni4xNjg0MjM2NTYy*_ga_CW55HF8NVT*MTY4NTQ1MzAzNi45LjEuMTY4NTQ1OTQ0OC4wLjAuMA..",
      "https://firebasestorage.googleapis.com/v0/b/tinder-clone-9de83.appspot.com/o/scripted_photos%2Fjosefina%2F4.jpg?alt=media&token=358f1689-238a-4851-946b-c349dec04c39&_gl=1*1rgc4l3*_ga*MTM0Mjg4MTU3Ni4xNjg0MjM2NTYy*_ga_CW55HF8NVT*MTY4NTQ1MzAzNi45LjEuMTY4NTQ1OTQ0OC4wLjAuMA..",
    ],
    priority: 7,
  },
  {
    name: "Lací",
    email: "laci@celoreis.dev",
    age: 53,
    password: "123456",
    profilePhoto:
      "https://firebasestorage.googleapis.com/v0/b/tinder-clone-9de83.appspot.com/o/scripted_photos%2Flaci%2F1.jpeg?alt=media&token=358f1689-238a-4851-946b-c349dec04c39&_gl=1*1rgc4l3*_ga*MTM0Mjg4MTU3Ni4xNjg0MjM2NTYy*_ga_CW55HF8NVT*MTY4NTQ1MzAzNi45LjEuMTY4NTQ1OTQ0OC4wLjAuMA..",
    photos: [
      "https://firebasestorage.googleapis.com/v0/b/tinder-clone-9de83.appspot.com/o/scripted_photos%2Flaci%2F2.jpeg?alt=media&token=358f1689-238a-4851-946b-c349dec04c39&_gl=1*1rgc4l3*_ga*MTM0Mjg4MTU3Ni4xNjg0MjM2NTYy*_ga_CW55HF8NVT*MTY4NTQ1MzAzNi45LjEuMTY4NTQ1OTQ0OC4wLjAuMA..",
    ],
    priority: 6,
  },
  {
    name: "Lucia",
    email: "lucia@celoreis.dev",
    age: 68,
    password: "123456",
    profilePhoto:
      "https://firebasestorage.googleapis.com/v0/b/tinder-clone-9de83.appspot.com/o/scripted_photos%2Flucia%2F1.jpg?alt=media&token=358f1689-238a-4851-946b-c349dec04c39&_gl=1*1rgc4l3*_ga*MTM0Mjg4MTU3Ni4xNjg0MjM2NTYy*_ga_CW55HF8NVT*MTY4NTQ1MzAzNi45LjEuMTY4NTQ1OTQ0OC4wLjAuMA..",
    photos: [
      "https://firebasestorage.googleapis.com/v0/b/tinder-clone-9de83.appspot.com/o/scripted_photos%2Flucia%2F2.jpg?alt=media&token=358f1689-238a-4851-946b-c349dec04c39&_gl=1*1rgc4l3*_ga*MTM0Mjg4MTU3Ni4xNjg0MjM2NTYy*_ga_CW55HF8NVT*MTY4NTQ1MzAzNi45LjEuMTY4NTQ1OTQ0OC4wLjAuMA..",
    ],
    priority: 5,
  },
  {
    name: "Marta",
    email: "marta@celoreis.dev",
    age: 60,
    password: "123456",
    profilePhoto:
      "https://firebasestorage.googleapis.com/v0/b/tinder-clone-9de83.appspot.com/o/scripted_photos%2Fmarta%2F1.jpeg?alt=media&token=358f1689-238a-4851-946b-c349dec04c39&_gl=1*1rgc4l3*_ga*MTM0Mjg4MTU3Ni4xNjg0MjM2NTYy*_ga_CW55HF8NVT*MTY4NTQ1MzAzNi45LjEuMTY4NTQ1OTQ0OC4wLjAuMA..",
    photos: [
      "https://firebasestorage.googleapis.com/v0/b/tinder-clone-9de83.appspot.com/o/scripted_photos%2Fmarta%2F2.jpeg?alt=media&token=358f1689-238a-4851-946b-c349dec04c39&_gl=1*1rgc4l3*_ga*MTM0Mjg4MTU3Ni4xNjg0MjM2NTYy*_ga_CW55HF8NVT*MTY4NTQ1MzAzNi45LjEuMTY4NTQ1OTQ0OC4wLjAuMA..",
      "https://firebasestorage.googleapis.com/v0/b/tinder-clone-9de83.appspot.com/o/scripted_photos%2Fmarta%2F3.jpeg?alt=media&token=358f1689-238a-4851-946b-c349dec04c39&_gl=1*1rgc4l3*_ga*MTM0Mjg4MTU3Ni4xNjg0MjM2NTYy*_ga_CW55HF8NVT*MTY4NTQ1MzAzNi45LjEuMTY4NTQ1OTQ0OC4wLjAuMA..",
    ],
    priority: 3,
  },
  {
    name: "Oralda",
    email: "oralda@celoreis.dev",
    age: 47,
    password: "123456",
    profilePhoto:
      "https://firebasestorage.googleapis.com/v0/b/tinder-clone-9de83.appspot.com/o/scripted_photos%2Foralda%2F1.jpeg?alt=media&token=358f1689-238a-4851-946b-c349dec04c39&_gl=1*1rgc4l3*_ga*MTM0Mjg4MTU3Ni4xNjg0MjM2NTYy*_ga_CW55HF8NVT*MTY4NTQ1MzAzNi45LjEuMTY4NTQ1OTQ0OC4wLjAuMA..",
    photos: [
      "https://firebasestorage.googleapis.com/v0/b/tinder-clone-9de83.appspot.com/o/scripted_photos%2Foralda%2F2.jpeg?alt=media&token=358f1689-238a-4851-946b-c349dec04c39&_gl=1*1rgc4l3*_ga*MTM0Mjg4MTU3Ni4xNjg0MjM2NTYy*_ga_CW55HF8NVT*MTY4NTQ1MzAzNi45LjEuMTY4NTQ1OTQ0OC4wLjAuMA..",
      "https://firebasestorage.googleapis.com/v0/b/tinder-clone-9de83.appspot.com/o/scripted_photos%2Foralda%2F3.jpeg?alt=media&token=358f1689-238a-4851-946b-c349dec04c39&_gl=1*1rgc4l3*_ga*MTM0Mjg4MTU3Ni4xNjg0MjM2NTYy*_ga_CW55HF8NVT*MTY4NTQ1MzAzNi45LjEuMTY4NTQ1OTQ0OC4wLjAuMA..",
    ],
    priority: 10,
  },
];

exports.users = users;
