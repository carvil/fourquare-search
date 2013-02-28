# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->
  $('#search-results, #favourites-list').on('click','.favourite', (e) ->
    e.preventDefault()
    venue_id = $(@).attr('data-id')
    $.ajax
      url: "/favourite"
      type: "POST"
      data:
        venue_id: venue_id
      success: (data, textStatus, jqXHR) =>
        if jqXHR.status is 200
          klass = if data.favourite then "icon-star" else "icon-star-empty"
          $(@).find("i").attr('class', klass)
    )
