#{ spawn } = require 'child_process'
module.exports = (robot) ->
   robot.hear /\bfun\b/i, (res) ->
      res.send "FUN!"

   robot.respond /bored/i, (res) ->
      res.reply "Me too!!!"

   #robot.respond /hello/i, (res) ->
   #   output = spawn 'python', ['-u', 'py_scripts/HelloWorld.py']
   #   output.stdout.on 'data', (data) ->
   #     res.send data.toString()

   robot.respond /hello/i, (res) ->
      output = require('child_process').spawn('python', ['-u', 'scripts/py_scripts/hello.py'])
      output.stdout.on 'data', (data) ->
        res.send data.toString()

   robot.respond /create (.*)/i, (res) ->
      args = res.match[1]
      robot.brain.set 'create', args
      res.send "create " + args

   robot.respond /destroy (.*)/i, (res) ->
      args = res.match[1]
      robot.brain.set 'destroy', args
      res.send "destroy " + args

   robot.respond /version (.*)/i, (res) ->
      args = res.match[1]
      robot.brain.set 'version', args
      create = robot.brain.get('create')
      destroy = robot.brain.get('destroy')
      if !create?
         res.send "Error must do create command first"
      else if !destroy?
         res.send "Error must do destroy command first"
      else 
         res.send "create " + create + " destroy " + destroy + " version " + args
