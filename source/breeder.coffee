"use strict"

_ = {}

_.curry = (fn) -> do (recur = (as) ->
  next = (nArgs...) ->
    args = as or []
    if args.push.apply(args, nArgs) < fn.length and nArgs.length
      return recur args
    fn args...
  if fn.length > 1 then next else fn
)

_compose = (fn1, fn2) ->
  ->
    fn1.call this, fn2.apply this, arguments

_.compose = ->
  index  = arguments.length - 1
  fn     = arguments[index]
  length = arguments.length
  while index--
    fn = _compose arguments[index], fn
  fn

_map = (iteratee, collection) ->
  index  = -1
  length = collection.length
  result = new Array(length)
  while ++index < length
    result[index] = iteratee collection[index]
  result

_.map = _.curry _map

window._ = _ if window?
module.exports = _ if module? and module.exports?