class NotificationsController < ApplicationController


  def index
    notifications = Notification.where(recipient_id: params[:user]).order(:created_at).limit(10)
    render :json => generate_response(notifications)
  end

  def mark_as_read
    notifications = Notification.where(id: params[:ids])
    ActiveRecord::Base.transaction do
      notifications.each do |notification|
        notification.read_at = DateTime.now
        notification.save!
      end
    end
    render json: { msg: 'Notificaciones marcadas como leidas.' }, status: 200
  rescue ActiveRecord::RecordInvalid
    flash[:notice] = 'Ocurrio un error al actualizar las notificaciones'
    render json: { msg: 'No se puede ejecutar la operacion.' }, status: 400
  end

  private

  def notification_params
    params.permit(:user)
  end

  def generate_response(notifications)
    notifications.map do |notification|
      { id: notification.id, requester: notification.requester.email, book_title: notification.copy.title, action: notification.action,
        read_at: notification.read_at }
    end
  end

end