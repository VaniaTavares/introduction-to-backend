const connection = require("./db-config");
const express = require("express");

const app = express();
const PORT = process.env.PORT || 3000;

app.use(express.json());

connection.connect((err) => {
	if (err) {
		console.error("error connecting: " + err.stack);
	} else {
		console.log(
			"connected to database with threadId :  " + connection.threadId
		);
	}
});

app.get("/api/books", (req, res) => {
	let sql = "SELECT * FROM BOOKS";
	let sqlValues = [];
	const { language, author } = req.query;

	if ((language && author) || (author && language)) {
		sql += ` WHERE language = ? AND author like ?`;
		sqlValues = [...sqlValues, language, `%${author}%`];
	} else if (language) {
		sql += " WHERE language = ?";
		sqlValues = [...sqlValues, language];
	} else if (author) {
		sql += " WHERE author like ?";
		sqlValues = [...sqlValues, `%${author}%`];
	}

	connection
		.promise()
		.query(sql, sqlValues)
		.then(([result]) => {
			console.log(result);
			res.status(200).json(result);
		})
		.catch((error) => {
			console.error(error);
			res.status(500).send("Error retrieving products from db.");
		});
});

app.get("/api/books/:id", (req, res) => {
	const bookId = req.params.id;

	connection
		.promise()
		.query("SELECT * FROM BOOKS WHERE id = ? ", [bookId])
		.then(([result]) => {
			if (result.length) res.status(200).json(result[0]);
			res.status(404).send("Book not found");
		})
		.catch((error) => {
			console.error(error);
			res.status(500).send("Error retrieving products from db.");
		});
});

app.listen(PORT, () => {
	console.log(`Server listening to port http://localhost:${PORT}`);
});
