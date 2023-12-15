module RoomsHelper
  def room_link(title)
    request.protocol + request.host_with_port + "/rooms/#{title}"
  end
end
