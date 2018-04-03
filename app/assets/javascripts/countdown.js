// http://hilios.github.io/jQuery.countdown/examples/bootstrap.html
// Turn on Bootstrap -- tooltip :when user point mouse will pop up the message box
// $('[data-toggle="tooltip"]').tooltip();

// http://hilios.github.io/jQuery.countdown/
//https://stackoverflow.com/questions/25274723/customize-jquery-countdown-ruby-on-rails
// 2nd ans

$(document).ready(function () {
    $('.countdown').each(function () {
        $(this).countdown({
            until: new Date($(this).data('until')),
            format: $(this).data('outformat'),
            labels: ['Years', 'Months', 'Weeks', 'Days', 'Hrs', 'Minutes', 'Seconds'],
            onExpiry: function() {
                $('#bid_info_bid_price').prop("disabled", true);
                $('#bid_info_form').remove();
                alert('Bidding is now Closed!!!!');
            }
        });
    });
});

// function onCloseBid() {
//     $('#bid_info_bid_price').prop("disabled", true);
//     $('#bid_info_form').remove();
//     alert('Bidding is now Closed!!!!')
// }
