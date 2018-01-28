const express = require('express');
const path = require('path');
const fileUpload = require('express-fileupload');


const app = express();
app.use(fileUpload());
let port = 5000;

// routes
app.use('/', express.static(path.join(__dirname, 'public_static')));


app.post('/upload', function(req, res) {
    // console.log(req.files);
    if (!req.files)
        return res.status(400).send('No files were uploaded.');

    // The name of the input field "file" is used to retrieve the uploaded file
    let file = req.files.sampleFile;

    // Use the mv() method to place the file somewhere on your server
    file.mv('./images/img.jpg', function(err) {
        if (err)
            return res.status(500).send(err);
        setTimeout(function(){ res.send('File uploaded!'); }, 3000);
    });
});


app.listen(port, function(){
   console.log('app is listen on port ' + port);
});
