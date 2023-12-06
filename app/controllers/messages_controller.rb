class MessagesController < ApplicationController

  def create
    @new_message = current_user&.messages&.build(strong_params)
    if @new_message&.save
      @new_message.broadcast_append_to @new_message.room
    end
  end

  private

  def strong_params
    params.require(:message).permit(:room_id, :body)
  end
end
