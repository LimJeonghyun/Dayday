require("dotenv").config();
const express = require("express");
const bodyParser = require("body-parser");
const hbs = require("express-hbs");
const app = express();
const port = process.env.PORT || 3000;

// 핸들바 설정
app.engine(
  "hbs",
  hbs.express4({
    defaultLayout: __dirname + "/views/layouts/web",
  })
);
app.set("view engine", "hbs");
app.set("views", __dirname + "/views");
// puclic 디렉토리를 서버의 정적 파일 디렉토리로 사용
app.use(express.static("public"));

const router = require("./src/router");

app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: true }));

app.use("/", router);

app.listen(port, () => {
  console.log(`웹서버 구동... ${port}`);
});
