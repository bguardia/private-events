class EventsController < ApplicationController
    before_action :authenticate_user!, except: [:index, :show]

    def index
        @events = Event.all
    end

    def show
        @event = Event.find(params[:id])
    end

    def new
        @event = current_user.hosted_events.build
    end

    def create
        @event = current_user.hosted_events.build(event_params)

        if @event.save
            flash[:notice] = "Successfully created event!"
            redirect_to event_path(@event)
        else
            flash.now[:alert] = "There was a problem creating your event."
            render "new"
        end
    end

    def edit
        begin
            @event = current_user.hosted_events.find(params[:id])
        rescue
            if Event.find_by(id: params[:id])
                flash[:alert] = "You don't have permission to edit that event."
            else
                flash[:alert] = "That event doesn't exist."
            end
            redirect_to root_path
        end
    end

    def update
        begin
            @event = current_user.hosted_events.find(params[:id])
        rescue
            if Event.find_by(id: params[:id])
                flash[:alert] = "You don't have permission to edit that event."
            else
                flash[:alert] = "That event doesn't exist."
            end
            redirect_to root_path
        end

        if @event.update(event_params)
            flash[:notice] = "Successfully updated event."
            redirect_to event_path(@event)
        else
            flash[:alert] = "There was a problem updating your event."
            render "edit"
        end
    end

    def destroy
        begin
            @event = current_user.hosted_events.find(params[:id])
        rescue
            if Event.find_by(id: params[:id])
                flash[:alert] = "You don't have permission to delete that event."
            else
                flash[:alert] = "That event doesn't exist."
            end
            redirect_to root_path
        end

        @event.destroy
        redirect_to root_path
    end

    private
    def event_params
        params.require(:event).permit(:title, :body, :start_date, :end_date)
    end
end
