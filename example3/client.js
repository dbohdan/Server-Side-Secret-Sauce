var inputElem = document.querySelector('#input');
var chatAreaElem = document.querySelector('#chat');
var sendElem = document.querySelector('#send');

var post_chat_message = function(text) {
    var p = document.createElement("p");
    var textNode = document.createTextNode(text);
    p.appendChild(textNode);
    chatAreaElem.appendChild(p);
    // Scroll chat to the bottom.
    chatAreaElem.scrollTop = chatAreaElem.scrollHeight;
};

var ws = new WebSocket("ws://localhost:8082/", "ex3");

ws.onopen = function(event) {
    var sendFunc = function() {
        ws.send(input.value);
        input.value = '';
    }

    sendElem.addEventListener('click', sendFunc);
    inputElem.addEventListener('keypress', function(event) {
        var key = event.which || event.keyCode;
        if (key === 13) { sendFunc(); }
    });
}
ws.onmessage = function(event) {
    post_chat_message(event.data);
};
ws.onclose = function(event) {
    post_chat_message('Connection closed.');
}
