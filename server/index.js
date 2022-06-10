const express = require("express"),
  app = express(),
  router = express.Router();

app.listen(3000, _ => console.log("connected to server"));

let usersLog = [
  {
    userUid: 'eqwLGthgyHY6JAQESn6g7WPnXij2',
    loginTime: [
      '2022-04-04 14:21:29.776',
    ],
    logoutTime: [],
  }
];

let usersData = [
  {
    userUid: "eqwLGthgyHY6JAQESn6g7WPnXij2",
    info: {
      email: 'heysookim482@gmail.com',
      method: 'firebase',
      signUpDate: '2022-04-04 14:21:29.776',
      name: 'Soo Kim',
      isMale: false
    },
    data: {
      colors: [
        {
          color: 4292889676,
          title: "Study Node.js",
        },
      ],
      events: [],
    },
  },
];

app.use(express.json());
app.use(express.urlencoded({ extended: false }));

app.get("/users/data", (req, res) => {
  console.log("getting user data");
  let index = usersData.findIndex(value => value.userUid == req.query.uid);
  if (index === -1) {
    res.send({ data: null });
  } else {
    let data = usersData[index].data;
    res.send({ data });
  }
});

app.post("/users/signUp", (req, res) => {
  console.log("add user");
  let info = {
    userUid: req.body.userUid,
    info: req.body,
  };
  usersData.push(info);
  console.log(usersData);
  res.send(req.body);
});

app.post("/users/log", (req, res) => {
  console.log("user log");
  console.log(req.body);
  let index = usersLog.findIndex(value => value.userUid == req.body.userUid);

  if (index === -1) {
    let log = {
      userUid: req.body.userUid,
      loginTime: [req.body.loginTime],
      logoutTime: [],
    }
    usersLog.push(log);
  } else {
    if (req.body.loginTime != null) usersLog[index].loginTime.push(req.body.loginTime);
    if (req.body.logoutTime != null) usersLog[index].logoutTime.push(req.body.logoutTime);
  }
  console.log(usersLog);
  res.send(req.body);
});

app.post("/users/colors/:action", (req, res) => {
  console.log("user - colors");
  console.log(req.body.userColor);
  let data = req.body.userColor;
  let index = usersData.findIndex(value => value.userUid == req.body.userUid);
  let userColorData = usersData[index].data.colors;
  console.log(userColorData);
  if (req.params.action == "delete") {
    let colorIndex = usersData[index].data.colors.findIndex(value => value.color == req.body.userColor.color);
    userColorData.splice(colorIndex, 1);
  }
  if (req.params.action == "add") {
    userColorData.push(data);
  }
  console.log(userColorData);
  res.send({data});
});

app.post("/users/event/:action", (req, res) => {
  console.log("users - event");
  console.log(req.body.event);
  let data = req.body.event;
  let index = usersData.findIndex(value => value.userUid == req.body.userUid);

  if (req.params.action == "delete") {
    
  }
  if (req.params.action == "add") {
    usersData[index].data.events.push(data);
  }
  console.log(req.body);
  res.send({ data });
});