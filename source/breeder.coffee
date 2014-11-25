"use strict"

_ = {}

_sub_curry = (fn, args...) ->
  (nArgs...) ->
    fn.apply this, args.concat nArgs

_curryN = (length, fn) ->
  (args...) ->
    if args.length < length
      combined = [fn].concat args
      if length - args.length > 0
        _curryN length - args.length, _sub_curry.apply this, combined
      else
        _sub_curry.apply this, combined
    else
      fn.apply this, args

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