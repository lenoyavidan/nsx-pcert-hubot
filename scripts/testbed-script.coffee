# Description
#   A hubot script that creates a testbed based on passed in variables
#
# Commands:
#   hubot testbed - <create a testbed, must pass in a value for name>
#
# Notes:
#   <optional notes required for the script>
#
# Author:
#   Lenoy Avidan

module.exports = (robot) ->
  robot.respond /(?:deploy )?testbed(?: name)?(?: is)?(.*)/i, (res) ->
    names = res.match[1]
    names = names.replace /\s/, ""
    if !names? || names == ""
      res.reply "Error must enter name for testbed" 
    else
      res.reply "Creating testbed with name " + names
      output = require('child_process').spawn('python', ['-u', 'scripts/py_scripts/DeployTestbed.py', names])
      output.stdout.on 'data', (data) ->
        res.send data.toString()
      output.stderr.on 'dataerr', (data) ->
        res.send dataerr.toString()

  robot.respond /delete testbed(?: name)?(?: is)?(.*)/i, (res) ->
    names = res.match[1]
    names = names.replace /\s/, ""
    if !names? || names == ""
      res.reply "Error must enter name of testbed to delete" 
    else
      res.reply "Deleting testbed with name " + names
      output = require('child_process').spawn('python', ['-u', 'scripts/py_scripts/DeleteTestbed.py', names])
      output.stdout.on 'data', (data) ->
        res.send data.toString()
      output.stderr.on 'dataerr', (data) ->
        res.send dataerr.toString()
