/// <reference path="jquery.d.ts" />
// https://github.com/typescript-ruby/typescript-rails/issues/26



// https://stackoverflow.com/questions/45544752/calling-a-typescript-method-from-your-html-button-onclick-event
class HelloTypeScript {
    say() {
        console.log('HEEEEE HAAA');
        //return alert("Hello, TypeScript! " + new Date());
        // https://stackoverflow.com/questions/35014205/typescript-error-calling-jquery-getjson-function
        $.getJSON('http://localhost:3000/items.json', (data: any, textStatus: string, jqXHR: JQueryXHR) => {
            // var repos: Repo[] = data;
            //...
            alert(JSON.stringify(data));
        })

    }
}

app = new HelloTypeScript();

// class HelloTypeScript {
//     say() :string{
//         return "Hello, TypeScript! " + new Date();
//     }
// }
//
// $(() => {
//     var hello = new HelloTypeScript();
//     $('#hello').alert(hello.say());
// });
