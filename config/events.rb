WebsocketRails::EventMap.describe do
  subscribe :client_connected, 'chat#client_connected_ctrl'
  subscribe :new_message, 'chat#new_message_ctrl'
  subscribe :new_user, 'chat#new_user_ctrl'
  subscribe :client_disconnected, 'chat#delete_user'
end
