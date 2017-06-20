'use strict';

require('./index.html');
require('./assets/css/bootstrap.min.css');
require('./assets/css/main.css');

var Elm = require('./Main');

var realities = {
    red: {
        description: "red reality"
    },
    green: {
        description: "green reality"
    },
    blue: {
        description: "blue reality"
    }
};

var elm = Elm.Main.fullscreen({realities: realities});
