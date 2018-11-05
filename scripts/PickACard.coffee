module.exports = (robot) ->
robot.respond /PickACard/i, (msg) ->
    random = (number) ->
      return Math.floor(Math.random() * 13) + 1
    
    rand = random();
    
    msg.reply("Ace") if rand == 1
    msg.reply("Two") if rand == 2
    msg.reply("Three") if rand == 3
    msg.reply("Four") if rand == 4
    msg.reply("Five") if rand == 5
    msg.reply("Six") if rand == 6
    msg.reply("Seven") if rand == 7
    msg.reply("Eight") if rand == 8
    msg.reply("Nine") if rand == 9
    msg.reply("Ten") if rand == 10
    msg.reply("Jack") if rand == 11
    msg.reply("Queen") if rand == 12
    msg.reply("King") if rand == 13
