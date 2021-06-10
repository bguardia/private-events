class InvitationsController < ApplicationController
    before_action :authenticate_user!

    def index
        @sent_invitations = current_user.sent_invitations.all
        @received_invitations = current_user.received_invitations.all
    end

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

    def update
        @invitation = current_user.received_invitations.find_by(id: response_params[:id])

        if @invitation&.update(response_params)
            @invitation.event << current_user if @invitation.status == 'accepted'
            flash[:notice] = "Successfully responded to invitation!"
        else
            flash[:alert] = "Unable to respond to invitation."
        end
        redirect_to user_path(current_user)
    end

    def destroy
        @invitation = current_user.sent_invitations.find_by(id: params[:id])

        if @invitation&.destroy
            flash[:notice] = "Successfully deleted invitation"
        else
            flash[:alert] = "Unable to delete invitation."
        end

        redirect_to invitations_path
    end

    private
    def invitation_params
        params.require(:invitation).permit(:event_id, :body, :status, invitee: {} )
    end

    def response_params
        params.require(:invitation).permit(:id, :status)
    end

end
