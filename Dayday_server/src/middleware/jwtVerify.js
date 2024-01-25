const jwt = require("jsonwebtoken");
const privateKey = "my-secret-key";

module.exports = async (req, res, next) => {
  const token = req.header("token");

  jwt.verify(token, privateKey, function (err, decoded) {
    if (err) {
      return res.send(err);
    }
    req.user = decoded;
    next();
  });
};
