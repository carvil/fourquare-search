module VenuesHelper

  def favourite_link(user, venue_id)
    if user
      klass = user.has_favourite_venue?(venue_id) ? "icon-star" : "icon-star-empty"
      link_to (content_tag :i, "", 'class' => klass), '#', class: "favourite", 'data-id' => venue_id
    else
      content_tag :p, "?"
    end
  end

end
