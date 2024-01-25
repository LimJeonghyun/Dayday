const { pool } = require("../../data");

exports.register = async (email, password, name) => {
  const query = "INSERT INTO user (email, password, name) VALUES (?, ?, ?)";
  return await pool(query, [email, password, name]);
};

exports.login = async (email, password) => {
  console.log(email + "+" + password);
  const query = "SELECT * FROM user WHERE email = ? AND password = ?";
  let result = await pool(query, [email, password]);
  return result.length < 0 ? null : result[0];
};

exports.find = async (email) => {
  let result = await pool("SELECT count(*) count FROM user where email = ?", [
    email,
  ]);
  return result.length < 0 ? null : result[0];
};

exports.findByemail = async (email) => {
  const query = "SELECT count(*) FROM user WHERE email = ?";
  let result = await pool(query, [email]);
  return result.length < 0 ? null : result[0];
};
