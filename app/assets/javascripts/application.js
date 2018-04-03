//= require jquery
//= require bootstrap-sprockets
//= require jquery_ujs
//= require jquery_nested_form
//= require best_in_place
//= require best_in_place.purr
//= require jquery.purr
//= require moment
//= require bootstrap-datetimepicker
//= require jquery.countdown
//= require jquery.countdown-es
//= require_tree .
// https://github.com/typescript-ruby/typescript-rails/issues/26
// https://stackoverflow.com/questions/45544752/calling-a-typescript-method-from-your-html-button-onclick-event
var HelloTypeScript = (function () {
    function HelloTypeScript() {
    }
    HelloTypeScript.prototype.say = function () {
        console.log('HEEEEE HAAA');
        //return alert("Hello, TypeScript! " + new Date());
        // https://stackoverflow.com/questions/35014205/typescript-error-calling-jquery-getjson-function
        $.getJSON('/items.json', function (data, textStatus, jqXHR) {
            alert(JSON.stringify(data));
        });
    };
    return HelloTypeScript;
}());
var ItemJSController = (function () {
    function ItemJSController() {
    }
    ItemJSController.prototype.closeDeal = function () {
        var c = confirm("Are you sure that you want to close this deal?");
        console.log("THIS IS THE OUTPUT : " + c);
    };
    return ItemJSController;
}());
var item_js = new ItemJSController();
var app = new HelloTypeScript();


