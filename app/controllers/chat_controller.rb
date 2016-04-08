class ChatController < WebsocketRails::BaseController
  include ActionView::Helpers::SanitizeHelper

  def system_msg_ctrl(ev, msg)
    broadcast_message ev,
                      user_name: 'INFO',
                      received: Time.now.to_s(:short),
                      msg_body: msg
  end

  def user_msg(ev, msg)
    broadcast_message ev,
                      user_name: connection_store[:user][:user_name],
                      received: Time.now.strftime('%H:%M:%S'),
                      msg_body: ERB::Util.h(msg)
  end

  def client_connected_ctrl
    # empty
  end

  def new_message_ctrl
    user_msg :new_message, message[:msg_body].dup
  end

  def new_user_ctrl
    connection_store[:user] = { user_name: sanitize(message[:user_name]) }
    broadcast_user_list
    system_msg_ctrl :new_message,
                    "#{connection_store[:user][:user_name]} joined the chat"
  end

  def change_username
    connection_store[:user][:user_name] = sanitize(message[:user_name])
    broadcast_user_list
  end

  def delete_user
    system_msg_ctrl :new_message,
                    "#{connection_store[:user][:user_name]} has left"
    connection_store[:user] = nil
    broadcast_user_list
  end

  def broadcast_user_list
    users = connection_store.collect_all(:user)
    broadcast_message :user_list, users
  end
end
