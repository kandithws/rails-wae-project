class ItemJSController {
    closeDeal(){
        var c = confirm("Are you sure that you want to close this deal?");
        console.log("THIS IS THE OUTPUT : " + c)
    }
}

item_js = new ItemJSController();