require('dotenv').config();
const express = require('express');
const morgan = require('morgan');
const bodyParser = require('body-parser');
// const routes = require('./routes');
// const bodyParser = require("body-parser");

const app = express();

// Import Routes
const authRoute = require('./routes/user');
const departmentRoute = require('./routes/department');
const labRoute = require('./routes/lab');
const softwareRoute = require('./routes/software');
const labSoftwareRoute = require('./routes/lab_software');
const subjectSoftwareRoute = require('./routes/subject_software');
const courseRoute = require('./routes/course');
const semesterAcademicRoute = require('./routes/semester_academic');
const dayRoute = require('./routes/day');
const periodRoute = require('./routes/period');
const subjectRoute = require('./routes/subject');
const weekRoute = require('./routes/week');
const timetablingRoute = require('./routes/timetabling');
const gaRoute = require('./routes/ga');

// Middleware
app.use(express.json());
app.use(morgan('tiny'));

// Route Middleware
app.use('/api/user', authRoute);
app.use('/api/department', departmentRoute);
app.use('/api/lab', labRoute);
app.use('/api/software', softwareRoute);
app.use('/api/lab-software', labSoftwareRoute);
app.use('/api/subject-software', subjectSoftwareRoute);
app.use('/api/course', courseRoute); // Lop hoc phan
app.use('/api/semester', semesterAcademicRoute);
app.use('/api/day', dayRoute);
app.use('/api/period', periodRoute);
app.use('/api/subject', subjectRoute);
app.use('/api/week', weekRoute);
app.use('/api/timetable', timetablingRoute);
app.use('/api/ga', gaRoute);

app.listen(process.env.PORT || 4006, () => {
    console.log(`Server is running at port ${process.env.PORT || 4006} `);
});
