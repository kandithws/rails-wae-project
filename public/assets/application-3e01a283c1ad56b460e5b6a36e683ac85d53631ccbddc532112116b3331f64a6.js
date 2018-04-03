// https://stackoverflow.com/questions/45544752/calling-a-typescript-method-from-your-html-button-onclick-event
var AdminTS = (function () {
    function AdminTS() {
        var _this = this;
        var btn = document.getElementById("coolbutton");
        btn.addEventListener("click", function (e) { return _this.getTrainingName(); });
    }
    AdminTS.prototype.getTrainingName = function () {
        return alert('Hello World!!!!!!!');
    };
    return AdminTS;
}());
new AdminTS();
