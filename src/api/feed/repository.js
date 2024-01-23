const { pool } = require("../../data");

exports.index = async (page, size, date, user_id) => {
  const offset = (page - 1) * size;
  // console.log(date);
  const query = `SELECT feed.*, u.name user_name FROM feed
  LEFT JOIN user u on u.id = feed.user_id WHERE DATE_FORMAT(feed.created_at, '%Y-%m-%d')=DATE_FORMAT(?, '%Y-%m-%d') AND feed.user_id=?
    ORDER BY feed.created_at DESC
    LIMIT ? OFFSET ?`;
  return await pool(query, [date, user_id, size, offset]);
};

exports.create = async (user, title, content) => {
  const query = `INSERT INTO feed
    (user_id, title, content)
    VALUES (?,?,?)`;
  return await pool(query, [user, title, content]);
};

exports.show = async (id) => {
  const query = `SELECT feed.*, u.name user_name FROM feed
    LEFT JOIN user u on u.id = feed.user_id WHERE feed.id = ?`;
  let result = await pool(query, [id]);
  return result.length < 0 ? null : result[0];
};

exports.update = async (title, content, id) => {
  const query = `UPDATE feed SET title = ? ,content = ? WHERE id = ?`;
  return await pool(query, [title, content, id]);
};

exports.delete = async (id) => {
  return await pool(`DELETE FROM feed WHERE id = ?`, [id]);
};
