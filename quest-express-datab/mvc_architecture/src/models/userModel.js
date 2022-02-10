const fakeDB = require("../data/fakeDB.json");

const users = fakeDB.users;

const getUsers = () => users;

const getUserById = (userId) => {
  let selectedUser = users.find((user) => user.id === userId);
  return selectedUser;
};

module.exports = { getUsers, getUserById };
