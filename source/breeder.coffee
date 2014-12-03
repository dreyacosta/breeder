"use strict"

_ = {}

curry2 = (fn) ->
  (a, b) ->
    if arguments.length is 1
      return (b) ->
        fn a, b
    fn a, b

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

_prop = (property, obj) ->
  obj[property]

_.prop = curry2 _prop

_pluck = (property, collection) ->
  _.map _.prop(property), collection

_.pluck = _.curry _pluck

_.filter = (fn, collection) ->
  index  = -1
  length = collection.length
  result = []
  while ++index < length
    if fn(collection[index])
      result.push collection[index]
  result

window._ = _ if window?
module.exports = _ if module? and module.exports?