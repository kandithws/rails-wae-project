/// <reference path="jquery.d.ts" />
// https://github.com/typescript-ruby/typescript-rails/issues/26
// https://stackoverflow.com/questions/45544752/calling-a-typescript-method-from-your-html-button-onclick-event
var HelloTypeScript = (function () {
    function HelloTypeScript() {
    }
    HelloTypeScript.prototype.say = function () {
        console.log('HEEEEE HAAA');
        //return alert("Hello, TypeScript! " + new Date());
        // https://stackoverflow.com/questions/35014205/typescript-error-calling-jquery-getjson-function
        $.getJSON('http://localhost:3000/items.json', function (data, textStatus, jqXHR) {
            // var repos: Repo[] = data;
            //...
            alert(JSON.stringify(data));
        });
    };
    return HelloTypeScript;
}());
app = new HelloTypeScript();
