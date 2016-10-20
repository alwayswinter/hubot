# Description:
#   A random showthought from /r/showerthought 
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   showerthought - random dose of insight from /r/showerthought 
#
# Author:
#   dmorse
module.exports = (robot) ->
    robot.respond /showerthought/i, (msg) ->
        msg.http("https://www.reddit.com/r/showerthoughts.json")
        .get() (err, res, body) ->
            try
                data = JSON.parse body
                children = data.data.children
                thought = msg.random(children).data

                thoughttext = thought.title.replace(/\*\.\.\.$/,'') +
                ' ' + thought.selftext.replace(/^\.\.\.\s*/, '')

                msg.send thoughttext.trim()
