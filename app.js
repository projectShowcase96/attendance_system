const path = require('path');
const express = require('express');
const hbs = require('express-handlebars');


// image upload lib
const multer = require('multer');
const storage = multer.diskStorage({
    destination: function (req, file, cb) {
        cb(null, './fp_images')
    },
    filename: function (req, file, cb) {
        cb(null, Date.now() + '-' + file.originalname)
    }
});
// const upload = multer({ dest: 'fp_images/' });
const upload = multer({ storage }).single('inputFingerprint');

const keys = require('./configs/keys');

const app = express();

// Pass static asset url host names to hbs templates
app.locals.hostName = keys.host + ':' + keys.port;


// 
// app.use(express.json());
app.use(express.urlencoded({ extended: true })); // To take value from Form as req.body


// Tell express, where your asset/static files (js, css, image, etc..) are
app.use('/static', express.static(path.resolve(__dirname, 'public')));


// Set express-handlebers as express view engine
app.engine('hbs', hbs({ extname: 'hbs', layoutsDir: path.resolve(__dirname, './views/'), defaultLayout: 'defaultHtmlLayout' }));
app.set('view engine', 'hbs');


// DB Connection
const connection = require('./configs/db-conn');


// app.get('/', function (req, res) {
//     res.send('Hello World')
// });


// Template link - https://startbootstrap.com/themes/sb-admin-2/

app.get('/', function (req, res) {
    // console.log(req);
    // res.status(200).send('Hello world');

    return res.render('./userTemplates/home', {

        // pass value to html template
        
    });
});

// register new student handler
app
    .route('/register-new')
    .get(function (req, res, next) {

        return res.render('./userTemplates/register-new-student', {

            // pass value to html template
            
        });
    })
    .post(function (req, res, next) {

        if (req.body.inputName !== '') {

            upload(req, res, function (err) {

                console.log(req.body, req.file);

                // Run DB query
                connection.query({
                    sql: 'INSERT INTO `student` (`regi_no`, `name`, `gender`, `fp_url`, `register_date`) VALUES (?, ?, ?, ?, ?)',
                    
                    values: [req.body.inputRegi, req.body.inputName, req.body.inputGender, '', req.body.inputRegiDate],
                
                }, function(error, results, fields) {
                
                    if (error) throw error;

                    console.log(results);

                    
                });
                
                // Terminate connection
                connection.end(function(err) {
                    // The connection is terminated now
                });

                return res.redirect('/register-new');
            });
        }
    
    });






// Insert New Class. Class Topic handler
app
    .route('/register-new-class')
    .get(function (req, res, next) {

        return res.render('./userTemplates/register-new-class', {
            // pass value to html template
        });
    })
    .post(function (req, res, next) {

        if (req.body.inputTopicName !== '') {

            upload(req, res, function (err) {

                console.log(req.body, req.file);

                // Run DB query
                connection.query({
                    sql: 'INSERT INTO `class` (`date`, `topic`, `start_time`) VALUES (?, ?, ?)',
                    
                    values: [req.body.inputClassDate, req.body.inputTopicName, req.body.inputClassStartTime],
                
                }, function(error, results, fields) {
                
                    if (error) throw error;

                    console.log(results);

                    
                });
                
                // Terminate connection
                connection.end(function(err) {
                    // The connection is terminated now
                });

                return res.redirect('/register-new-class');
            });

        }

    });


//student list handlebars
app.get('/student-list', function (req, res) {

    // Run DB query
    connection.query({
        sql: 'SELECT * FROM `student`',
    
        values: [],

    }, 
    function(error, results, fields) {

        if (error) throw error;

        console.log(results);

        return res.render('./userTemplates/student-list', {
        
            // Prepare page data
            'pageTitle': 'Student List',
            'data': results
    
        });
    });

});




// select topic and get total daily present on particular class topic handler
app.get('/select-per-class-for-present', function (req, res) {
    
    // console.log(req.query)

    if (typeof req.query.inputClassTopicId !== 'undefined') {

        // console.log('I am hit');

        let class_id = parseInt(req.query.inputClassTopicId);

        // Run DB query
        connection.query({
            sql: 'SELECT * FROM `class`; SELECT * FROM `student` WHERE `regi_no` in (SELECT `regi_no` FROM `attendance_log` WHERE `class_id` in (SELECT `class_id` FROM `class` WHERE `class_id` = ?))',
            
            values: [class_id],

        }, function (error, results, fields) {

            if (error) throw error;

            // console.log(results);

            return res.render('./userTemplates/daily-present-list', {
                
                // Prepare page data
                'pageTitle': 'Present Status Per Class',
                'classListData': results[0],
                'presentStudentList': results[1],
                
            });
        });
        
    }
    else {
        // Run DB query
        connection.query({
            sql: 'SELECT * FROM `class`',
            
            values: [],

        }, function (error, results, fields) {

            if (error) throw error;

            // console.log(results);

            return res.render('./userTemplates/select-per-class-for-present', {
                
                // Prepare page data
                'pageTitle': 'Select Class Topic',
                'classListData': results
            });
        });
    }
});



// Select Class Topic and get total daily absent on particular class handler
app.get('/select-per-class-for-absent', function (req, res) {
    
    // console.log(req.query)

    if (typeof req.query.inputClassTopicId !== 'undefined') {

        // console.log('I am hit');

        let class_id = parseInt(req.query.inputClassTopicId);

        // Run DB query
        connection.query({
            sql: 'SELECT * FROM `class`; SELECT * FROM `student` WHERE `regi_no` not in (SELECT `regi_no` FROM `attendance_log` WHERE `class_id` in (SELECT `class_id` FROM `class` WHERE `class_id` = ?))',
            
            values: [class_id],

        }, function (error, results, fields) {

            if (error) throw error;

            // console.log(results);

            return res.render('./userTemplates/daily-absent-list', {
                
                // Prepare page data
                'pageTitle': 'Absent Status Per Class',
                'classListData': results[0],
                'absentStudentList': results[1]
            });
        });
        
    }
    else {
        // Run DB query
        connection.query({
            sql: 'SELECT * FROM `class`',
            
            values: [],

        }, function (error, results, fields) {

            if (error) throw error;

            // console.log(results);

            return res.render('./userTemplates/select-per-class-for-absent', {
                
                // Prepare page data
                'pageTitle': 'Select Class Topic',
                'classListData': results
            });
        });
    }
});




// Select Class Topic and get total daily latecomers on particular class handler
app.get('/select-per-class-for-latecomers', function (req, res) {
    
    // console.log(req.query)

    if (typeof req.query.inputClassTopicId !== 'undefined') {

        // console.log('I am hit');

        let class_id = parseInt(req.query.inputClassTopicId);

        // Run DB query
        connection.query({
            sql: 'SELECT * FROM `class`; SELECT * FROM `student` WHERE `regi_no` in (SELECT `regi_no` FROM `attendance_log`  INNER JOIN `class` ON class.class_id = attendance_log.class_id WHERE attendance_log.entrance_time > (class.start_time + class.allowance_time) AND class.class_id = ?)',
            
            values: [class_id],

        }, function (error, results, fields) {

            if (error) throw error;

            // console.log(results);

            return res.render('./userTemplates/latecomers-list', {
                
                // Prepare page data
                'pageTitle': 'Latecomers Status Per Class',
                'classListData': results[0],
                'lateStudentList': results[1]
            });
        });
        
    }
    else {
        // Run DB query
        connection.query({
            sql: 'SELECT * FROM `class`',
            
            values: [],

        }, function (error, results, fields) {

            if (error) throw error;

            // console.log(results);

            return res.render('./userTemplates/select-per-class-for-latecomers', {
                
                // Prepare page data
                'pageTitle': 'Select Class Topic',
                'classListData': results
            });
        });
    }
});



// take attendace handler
app.get('/take-attendance-per-topic', function (req, res) {
    
    
  
        // Run DB query
        connection.query({
            sql: 'SELECT * FROM `class` WHERE `date` = CURDATE()',
            
            values: [],

        }, function (error, results, fields) {

            if (error) throw error;

            // console.log(results);

            return res.render('./userTemplates/take-attendance/take-attendance-per-topic', {
                
                // Prepare page data
                'pageTitle': 'Select Class Topic'
            });
        });

        // // Terminate connection
        // connection.end(function(err) {
        //     // The connection is terminated now
        // });

        // return res.redirect('./userTemplates/take-attendance/insert-present-student-info');

        
    
})
    // .post(function(req,res){
    //     res.render('./userTemplates/take-attendance/insert-present-student-info');
    //     if(req.query.results != 'undefined'){
    //         connection.query({
    //             sql: 'INSERT INTO `attendance_log` (`date`, `topic`, `start_time`) VALUES (?, ?, ?)',
                    
    //             values: [req.body.inputClassDate, req.body.inputTopicName, req.body.inputClassStartTime],
    //         })
    //     }
    // })
    








app.listen(keys.port);



