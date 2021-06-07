class InvitationsController < ApplicationController

    def create
        @event = Event.find_by(id: params[:event_id])
        if @event.host == current_user
            @invitee = User.find_by(name: params[:invitation]["invitee"])
            @invitation = current_user.sent_invitations.build(event_id: params[:event_id],
                                                              invitee_id: @invitee&.id,
                                                              body: params[:invitation][:body],
                                                              status: 'pending')

            if @invitation.save
                flash[:notice] = "Successfully sent invitation!"
                redirect_to event_path(@event)
                return
            end
        end
        flash.now[:alert] = "Unable to send invitation"
        render 'events/show', locals: { event: @event }
    end

end
