$ ->
  try
    window.chatController = new Chat.Controller($('#chat').data('uri'), true);

window.Chat = {}

class Chat.User
  constructor: (@user_name) ->
  serialize: => { user_name: @user_name }

class Chat.Controller
  template: (message) ->
    html =
      """
      <div class="message" >
        <label class="label label-info">
          [#{message.received}] #{message.user_name}
        </label>&nbsp;
        #{message.msg_body}
      </div>
      """
    $(html)

  userListTemplate: (userList) ->
    userHtml = ""
    for user in userList
      userHtml = userHtml + "<li>#{user.user_name}</li>"
    $(userHtml)

  constructor: (url,useWebSockets) ->
    @messageQueue = []
    @dispatcher = new WebSocketRails(url, useWebSockets)
    @dispatcher.on_open = @createGuestUser
    @bindEvents()

  bindEvents: =>
    @dispatcher.bind 'new_message', @newMessage
    @dispatcher.bind 'user_list', @updateUserList
    $('#send').on 'click', @sendMessage
    $('#message').keypress (e) -> $('#send').click() if e.keyCode == 13

  newMessage: (message) =>
    @messageQueue.push message
    @shiftMessageQueue() if @messageQueue.length > 15
    @appendMessage message

  sendMessage: (event) =>
    event.preventDefault()
    message = $('#message').val()
    $('#message').focus()
    if message
      @dispatcher.trigger 'new_message', {user_name: @user.user_name, msg_body: message}
      $('#message').val('')

  updateUserList: (userList) =>
    $('#user-list').html @userListTemplate(userList)

  appendMessage: (message) ->
    messageTemplate = @template(message)
    $('#chat').append messageTemplate
    messageTemplate.slideDown 140
    scrdown();

  shiftMessageQueue: =>
    @messageQueue.shift()
    $('#chat div.messages:first').slideDown 100, ->
      $(this).remove()

  createGuestUser: =>
    rand_num = Math.floor(Math.random()*1000)
    @user = new Chat.User("Guest_" + rand_num)
    $('#username').html @user.user_name
    $('input#user_name').val @user.user_name
    @dispatcher.trigger 'new_user', @user.serialize()
    $('#message').focus()

   quitChat: =>
     if confirm 'Are you sure?'
       console.log('client_disconnected triggered: ', @user.user_name)
       @dispatcher.trigger 'new_message', {user_name: @user.user_name, msg_body: 'see you later, guys :)'}
       @dispatcher.trigger 'client_disconnected', @user.serialize()
