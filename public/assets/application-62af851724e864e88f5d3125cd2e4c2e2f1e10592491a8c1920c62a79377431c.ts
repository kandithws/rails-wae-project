//= require jquery
//= require jquery_ujs

// https://github.com/typescript-ruby/typescript-rails/issues/26
// https://stackoverflow.com/questions/45544752/calling-a-typescript-method-from-your-html-button-onclick-event
class HelloTypeScript {
    say() {
        console.log('HEEEEE HAAA');
        //return alert("Hello, TypeScript! " + new Date());
        // https://stackoverflow.com/questions/35014205/typescript-error-calling-jquery-getjson-function
        $.getJSON('/items.json', (data: any, textStatus: string, jqXHR: JQueryXHR) => {

            alert(JSON.stringify(data));
        })

    }
}

app = new HelloTypeScript();

