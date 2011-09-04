module SongsHelper

  def display_nillable(object)
    return object || "<em>nil</em>"
  end

end
