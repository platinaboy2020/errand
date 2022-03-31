<<<<<<< HEAD
const express = require("express");
const router = express.Router();
const userController = require("../controllers/userController");
const auth = require("../middleware/jvt");
const { body, validationResult } = require("express-validator");

// Get user from database
router.post(
    "/register",
    body("email").isEmail(),
    body("username").isLength({ min: 5, max: 25 }),
    body("password").isLength({ min: 5, max: 25 }),
    userController.register
);
router.post("/login", userController.login);
router.get("/authentication", auth, userController.authenticate);

module.exports = router;
=======
const express = require("express");
const router = express.Router();
const userController = require("../controllers/userController");
const auth = require("../middleware/jvt");
const { body, validationResult } = require("express-validator");

// Get user from database
router.post(
    "/register",
    body("email").isEmail(),
    body("username").isLength({ min: 5, max: 25 }),
    body("password").isLength({ min: 5, max: 25 }),
    userController.register
);
router.post("/login", userController.login);
router.get("/authentication", auth, userController.authenticate);

module.exports = router;
>>>>>>> a049ffc655f3c8e1a8dcf4c8d0321fc6b4d2c3f9
