const express = require("express");
const { userController } = require("../controllers");
const { userModel } = require("../models");

const userRoutes = express.Router();

userRoutes.get("/", userController.getUsersController);

userRoutes.get("/:id", userController.getUserByIdController);

module.exports = userRoutes;
