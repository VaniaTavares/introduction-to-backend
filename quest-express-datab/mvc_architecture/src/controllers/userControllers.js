const { userModel } = require("../models");

const getUsersController = (req, res) => {
  const users = userModel.getUsers();
  res.status(200).json(users);
};

const getUserByIdController = (req, res) => {
  const userId = parseInt(req.params.id);
  let user = userModel.getUserById(userId);
  if (user) res.status(200).json(user);
  else res.status(404).send("There's no user with that id");
};
module.exports = { getUsersController, getUserByIdController };
