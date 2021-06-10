class AttendeesController < ApplicationController
    before_action :authenticate_user!

    def create
        @event = Event.find(params[:event_id])
        if @event.openness == 'public' || @event.invitees.exists?(current_user.id)
            @event.attendees << current_user
            @event.invitations.where(invitee_id: current_user.id)&.update(status: 'accepted')
            flash[:notice] = "You have successfully joined this event!"
        else
            flash[:alert] = "You need to be invited to join this event."
        end

        redirect_to event_path(@event)
    end

    def destroy
        @event = Event.find(params[:event_id])
        @user = User.find(params[:id])
        if @user == current_user
            @event.attendees.destroy(@user)
            @event.invitations.where(invitee_id: current_user.id)&.update(status: 'pending')
        end
        redirect_to event_path(@event)
    end
end
