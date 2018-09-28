$(document).ready ->
  console.log("alo si")

  $.ajax({
    url: '/notifications',
    type: 'get',
    data: {user: $(".current-user-js").data("user-id")},
  }).done((data) ->
    notification = data[0]
    data.forEach((notification) ->
      $('.dropdown-menu').prepend("<li><a>#{notification.requester} te ha #{notification.action} tu ejemplar de #{notification.book_title}</a></li>")
    )).fail((data) ->
      $('.dropdown-menu').prepend("<li><a>Oops! Ha ocurrido un error al cargar las notificaciones. Intentelo mas tarde.</a></li>")
    )
