'use strict';

require('./index.html');
require('./assets/css/bootstrap.min.css');
require('./assets/css/main.css');

var Elm = require('./Main');

var realities = {
    red: {
        description: "red reality",
        actionA: "action A",
        actionB: "action B",
        result: "result"
    },
    green: {
        description: "green reality",
        actionA: "action A",
        actionB: "action B",
        result: "result"
    },
    blue: {
        description: "blue reality",
        actionA: "action A",
        actionB: "action B",
        result: "result"
    }
};

var elm = Elm.Main.fullscreen({realities: realities, time: Date.now()});
