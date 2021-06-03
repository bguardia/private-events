class AttendeesController < ApplicationController
    before_action :authenticate_user!

    def create
        @event = Event.find(params[:event_id])
        @event.attendees << current_user
        redirect_to event_path(@event)
    end

    def destroy
        @event = Event.find(params[:event_id])
        @user = User.find(params[:id])
        if @user == current_user
            @event.attendees.destroy(@user)
        end
        redirect_to event_path(@event)
    end
end
