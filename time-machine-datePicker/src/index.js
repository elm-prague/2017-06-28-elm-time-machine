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

var elm = Elm.Main.fullscreen({realities: realities});

//follow up on this example with Remote Data - lets load the dinosaurs from an API
//but not only dinosaurs can kill you, what about Rabbit of Caerbannog?
//no we want to print way to kill you - do we need two methods?
//no! Extensible type aka abstract class - DangerousAnimal