const mysql = require('mysql');

const connection = mysql.createConnection({
    host: 'localhost',
    post: 3306,
    user: 'root',
    password: 'root',
    database: 'attendance_system',
    multipleStatements: true
});

module.exports = connection;