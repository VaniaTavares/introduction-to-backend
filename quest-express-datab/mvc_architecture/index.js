const app = require("./src/app");

const PORT = 3000;

app.listen(PORT, () =>
  console.log(`Server listening to port: http://localhost:${PORT}`)
);
