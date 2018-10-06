# Description:
#   Sends a greeting everytime a user enters the channel unless they opt out 
#
# Notes:
#   Ignores usernames starting with 'Guest' followed by digits
#   Users can opt out by replying the bot 'Understood' 
#   Users can opt in again by messaging the bot "Reset Greeting"
#  
# Author:
#   iojw (http://github.com/iojw)

module.exports = (robot) ->
  # IRC nickname of the bot
  bot_nick = process.env.HUBOT_IRC_NICK
  # regexp for Guest nicknames
  guest_nick = /^(Guest|Terasologist)\d*$/i
  # greeting message sent to users
  greeting_msg = "Hello! Welcome to #terasology!\n" +
                 "This channel is in Moderated mode, where only voiced members can talk. This is because of a large amount of spam affecting the channel.\n" +
                 "!!If you are not a robot then PM any operator to get voice!!\n" +
                 "Alternatively, visit our Discord at http://discord.gg/Terasology\n" +
                 "We will try our best to respond to your messages as soon as possible, please be patient " +
                 "and understand that not every online user will be watching the chat all the time.\n" +
                 "Do check out https://github.com/MovingBlocks/Terasology/wiki/Using-IRC for more details about our IRC channel.\n" +
                 "If you would like to learn more about Terasology, be sure to visit http://forum.terasology.org for our forums " +
                 "and http://github.com/MovingBlocks/Terasology for our Github repo!\n"
  understood_msg = "Reply 'Understood' if you do not want to receive this greeting again."

  robot.respond /understood.*/i, (msg) ->
    opt_out = JSON.parse(robot.brain.get 'greeting') or []
    username = msg.message.user.name
    room = msg.message.user.room
    if not room?
      if username not in opt_out and not guest_nick.test(username)
        opt_out.push username
        robot.brain.set('greeting', JSON.stringify(opt_out))
        robot.brain.save()
        msg.send "You will not receive this greeting anymore. Message 'Reset Greeting' to me in private if you would like to undo this."
      else if guest_nick.test(username)
        msg.send "Guest accounts cannot opt out."
      else
        msg.send "You have already opted out of the greeting."

  robot.respond /reset greeting.*/i, (msg) ->
    opt_out = JSON.parse(robot.brain.get 'greeting') or []
    username = msg.message.user.name
    room = msg.message.user.room
    if not room?
      if username in opt_out
        opt_out.splice(opt_out.indexOf(username), 1)
        robot.brain.set('greeting', JSON.stringify(opt_out))
        robot.brain.save()
        msg.send "You will receive the greeting the next time you join the channel."
      else
        msg.send "You haven't opted out yet!"

  robot.enter (msg) ->
    opt_out = JSON.parse(robot.brain.get 'greeting') or []
    username =  msg.message.user.name
    if username not in opt_out and username isnt bot_nick
      msg.sendPrivate greeting_msg
      if not guest_nick.test(username)
        msg.sendPrivate understood_msg
