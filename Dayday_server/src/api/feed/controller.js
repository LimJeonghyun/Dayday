const repository = require("./repository");

exports.index = async (req, res) => {
  const date = req.params.date;
  const user = req.user;

  const { page = 1, size = 20 } = req.query;
  console.log(user.id);
  const items = await repository.index(page, size, date, user.id);
  res.send({ result: "ok", data: items });
};

exports.store = async (req, res) => {
  const body = req.body;
  const user = req.user;

  const result = await repository.create(user.id, body.title, body.content);
  if (result.affectedRows > 0) {
    res.send({ result: "ok", data: result.insertId });
  } else {
    res.send({ result: "fail", message: "오류가 발생하였습니다." });
  }
};

exports.show = async (req, res) => {
  const id = req.params.id;
  const user = req.user;

  const item = await repository.show(id);
  item["is_me"] = user.id == item.user_id;
  console.log("show : " + user.id + " " + item.user_id);
  res.send({ result: "ok", data: item });
};

exports.update = async (req, res) => {
  const id = req.params.id;
  const body = req.body;
  const user = req.user;
  const item = await repository.show(id);
  if (user.id !== item.user_id) {
    res.send({ result: "fail", message: "타인의 글을 수정할 수 없습니다." });
  }
  const result = await repository.update(body.title, body.content, id);
  if (result.affectedRows > 0) {
    res.send({ result: "ok", data: body });
  } else {
    res.send({ result: "fail", message: "오류가 발생하였습니다." });
  }
};

exports.destroy = async (req, res) => {
  const id = req.params.id;
  const user = req.user;
  const item = await repository.show(id);
  if (user.id !== item.user_id) {
    res.send({ result: "fail", message: "타인의 글을 삭제 할수 없습니다." });
  } else {
    repository.delete(id);
    res.send({ result: "ok", data: id });
  }
};
