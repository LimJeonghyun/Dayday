const jwt = require("./jwt");
const { register, find, findId, findByemail, login } = require("./repository");
const crypto = require("crypto");

// 회원가입
exports.register = async (req, res) => {
  const { email, password, name } = req.body;

  let check = await findByemail(email);
  if (check.count > 0) {
    return res.send({
      result: "fail",
      messge: "이미 해당 이메일 가입이 되어있습니다",
    });
  }

  let { count } = await find(email);

  if (count > 0) {
    return res.send({
      result: "fail",
      messge: "중복된 이메일이 존재합니다.",
    });
  }

  const result = await crypto.pbkdf2Sync(
    password,
    process.env.SALT_KEY,
    50,
    100,
    "sha512"
  );

  const { affectedRows, insertId } = await register(
    email,
    result.toString("base64"),
    name
  );

  if (affectedRows > 0) {
    const data = await jwt.jwtSign({ id: insertId, name });
    res.send({ access_token: data });
  } else {
    res.send({ result: "fail" });
  }
};

// 로그인
exports.login = async (req, res) => {
  let { email, password } = req.body;
  let result = crypto.pbkdf2Sync(
    password,
    process.env.SALT_KEY,
    50,
    100,
    "sha512"
  );

  let item = await login(email, result.toString("base64"));

  if (item == null) {
    return res.send({
      result: "fail",
      messge: "로그인 실패.",
    });
  } else {
    console.log("성공!");
    const data = await jwt.jwtSign({ id: item.id });
    return res.send({
      result: "success",
      messge: "로그인 성공!.",
      access_token: data,
    });
  }
};

exports.userinfo = (req, res) => {
  const id = ctx.params.id;
  res.send(`${id} 님의 회원정보`);
};
