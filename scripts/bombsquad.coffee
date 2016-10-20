# Description:
#   A spin on Russian roulette  
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   hubot bombsquad - try to defuse the bomb

wires = [
    "blue",
    "yellow",
    "green",
    "black",
    "red"
]

color = "null"
module.exports = (robot) ->
    robot.respond /bombsquad/i, (msg) ->
        robot.brain.set 'activated', 1
        wire = msg.random wires 
        msg.send "Bomb activated. You have 10 seconds to pick a wire..." 
        msg.send "blue | yellow | green | black | red..." 

        timerID = setTimeout () ->
            msg.send "Time is up!"
            msg.reply "***BOOM!***"
            robot.brain.set 'activated', 0 
        , 10000

        robot.hear /(blue|red|yellow|green|black)/i, (res) ->
            color = res.match[1]

            isActivated = robot.brain.get('activated')

            if isActivated
                if color is wire 
                    robot.brain.set 'activated', 0 
                    res.reply "The device has been deactivated"
                    clearTimeout( timerID )
                    return
                else
                    robot.brain.set 'activated', 0 
                    res.reply wire
                    res.reply "***BOOM!***"
                    clearTimeout( timerID )
                    return



