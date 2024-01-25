const express = require("express");
const router = express.Router();
const logging = require("./middleware/logging");
const verify = require("./middleware/jwtVerify");

const multer = require("multer");
const upload = multer({ dest: "storage/" });

const webController = require("./web/controller");
const apiUserController = require("./api/user/controller");
const apiFeedController = require("./api/feed/controller");
// const fileController = require("./api/file/controller");

router.use(logging);
// router.post("/api/file", upload.single("file"), fileController.upload);
// router.get("/api/file/:id", fileController.download);

router.get("/", webController.home);
router.get("/page/:page", webController.page);
router.get("/sitemap", webController.sitemap);

router.post("/api/user/register", apiUserController.register);
router.post("/api/user/login", apiUserController.login);
router.get("/api/user/mypage", verify, apiUserController.userinfo);
router.get("/api/user/:id", apiUserController.userinfo);

router.get("/api/feed/:date", verify, apiFeedController.index);
router.post("/api/feed", verify, apiFeedController.store);
router.get("/api/feed/show/:id", verify, apiFeedController.show);
router.put("/api/feed/:id", verify, apiFeedController.update);
router.delete("/api/feed/:id", verify, apiFeedController.destroy);

module.exports = router;
