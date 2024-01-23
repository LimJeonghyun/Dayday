const jwt = require("jsonwebtoken");
const privateKey = "my-secret-key";

exports.jwtSign = (payload) => {
  return new Promise((resolve, reject) => {
    jwt.sign(payload, privateKey, { expiresIn: "1d" }, function (err, token) {
      if (err) {
        reject(err);
      }
      resolve(token);
    });
  });
};
