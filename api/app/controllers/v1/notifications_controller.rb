class V1::NotificationsController < ApplicationController
  def index
    user = User.find(params[:user_id])
    notifications = user.passive_notifications.includes({visitor: {avatar_attachment: :blob}})

    render json: notifications.as_json(include: [{visitor: {methods: :avatar_url}}])
  end

  def show
    user = User.find(params[:user_id])
    notifications = user.passive_notifications

    render json: notifications
  end

  def unchecked
    user = User.find(params[:user_id])
    count = user.passive.notifications.where(checked: false).count

    render json: count
  end

  def checked
    user = User.find(params[:user_id])
    notifications = user.passive.notifications.where(checked: false)

    render json: notifications

    notifications.each do |notice|
      notifications.update_attributes(checked: true)
    end
  end
end
