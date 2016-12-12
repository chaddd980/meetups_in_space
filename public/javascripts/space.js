// $("#join").on('click', function(ev) {
//   ev.preventDefault();
//   var username = $("#username");
//   var meetup = $(location).attr('pathname').split('/');
//   var meetup_id = meetup[meetup.length - 1]
//   var request = $.ajax({
//     method: "POST",
//     url: "/join_this_meetup"
//   });
//   request.done(function() {
//     $("#users").append(meetup_id)
//   });
// })
