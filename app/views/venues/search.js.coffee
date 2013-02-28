$("#search-results").empty()
if <%= @venues.length %> is 0
  $("#search-results").html("<p class='center'>No results found :(<p>")
else
  $("#search-results").html("<%= escape_javascript(render('venues/headline')) %><%= escape_javascript(render(@venues)) %>")
