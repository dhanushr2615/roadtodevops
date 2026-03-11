const express = require('express');
const app = express();
const port = 3000;
const message = process.env.PIZZA_TYPE || "Cheese";

app.get('/', (req, res) => {
 req.send('<h1>Baking a ${message} Pizza!</h1>');
});

app.listen(port, () => console.log('Pizza over ready at port ${port}'));

