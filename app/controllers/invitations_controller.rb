class InvitationsController < ApplicationController

    def create
        @event = Event.find_by(id: invitation_params[:event_id])
        if @event.host == current_user
            @invitee = User.find_by(invitation_params[:invitee])
            @invitation = current_user.sent_invitations.build(event_id: @event.id,
                                                              invitee_id: @invitee&.id,
                                                              body: invitation_params[:body],
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

    private
    def invitation_params
        params.require(:invitation).permit(:event_id, :body, invitee: {} )
    end

end
