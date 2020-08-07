

const admin = require('firebase-admin');
const functions = require('firebase-functions');
const express = require('express');
const passbook = require('passbook');

admin.initializeApp();
const app = express();
app.get('/pass', (request, response) => {
    if (
        !request.query ||
        !request.query.name || request.query.name === "" ||
        !request.query.phone || request.query.phone === "" ||
        !request.query.mail || request.query.mail === "" ||
        !request.query.birthday || request.query.birthday === "" ||
        !request.query.foregroundColor || request.query.foregroundColor === "" ||
        !request.query.backgroundColor || request.query.backgroundColor === "" ||
        !request.query.labelColor || request.query.labelColor === ""
    ) {
        response.status(401).send();
        console.log("error -> aborting");
        return;
    }

    let template = passbook('storeCard', {
        passTypeIdentifier: 'pass.eu.deltasiege.buisnesswallet',
        teamIdentifier: 'AXLC3PQNC8',
        organizationName: 'Deltasiege.eu',
        serialNumber: '829283',
        description: ' ',
        logoText: '  ' + request.query.name,
        labelColor: request.query.labelColor,
        foregroundColor: request.query.foregroundColor,
        backgroundColor: request.query.backgroundColor
    });

    template.fields.barcode = {
        'format': 'PKBarcodeFormatQR',
        'message': 'MECARD:N:' + request.query.name + ';BDAY:' + request.query.birthday + ';TEL:' + request.query.phone + ';EMAIL:' + request.query.mail + ';;',
        'messageEncoding': 'iso-8859-1'
    };

    template.keys('keys', '');
    template.loadImagesFrom('images');
    let pass = template.createPass();

    pass.secondaryFields.add({ key: "email", label: "Email:", value: request.query.mail });
    pass.secondaryFields.add({ key: "phone", label: "Tel.:", value: request.query.phone });


    pass.render(response, function (error) {
        if (error)
            console.log(error)
    });
});

exports.app = functions.https.onRequest(app);