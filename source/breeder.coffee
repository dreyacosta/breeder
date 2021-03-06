"use strict"

_ = {}

_.VERSION = "0.0.11"

_extend = (destination, sources...) ->
  sources.forEach (source) -> destination[method] = source[method] for method of source
  destination

_curry2 = (fn) ->
  (a, b) ->
    if arguments.length is 1
      return (b) -> fn a, b
    fn a, b

_.curry = (fn) -> do (recur = (as) ->
  next = (nArgs...) ->
    args = as or []
    if args.push.apply(args, nArgs) < fn.length and nArgs.length
      return recur args
    fn args...
  if fn.length > 1 then next else fn
)

_compose = (fn1, fn2) -> -> fn1.call this, fn2.apply this, arguments

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

_prop = (property, obj) -> obj[property]

_.prop = _curry2 _prop

_pluck = (property, collection) -> _.map _.prop(property), collection

_.pluck = _.curry _pluck

_filter = (fn, collection) ->
  index  = -1
  length = collection.length
  result = []
  while ++index < length
    if fn(collection[index])
      result.push collection[index]
  result

_.filter =  _.curry _filter

_reduce = (fn, accumulator, collection) ->
  index  = -1
  length = collection.length
  while ++index < length
    accumulator = fn accumulator, collection[index]
  accumulator

_.reduce =  _.curry _reduce

_cloneObj = (obj) -> result = _extend {}, obj

_.cloneObj = _cloneObj

_concat = (list1, list2) ->
  list1 = list1 or []
  list2 = list2 or []
  length1 = list1.length
  length2 = list2.length
  result = new Array(length1 + length2)
  index = -1
  while ++index < length1
    result[index] = list1[index]
  index = -1
  while ++index < length2
    result[length1 + index] = list2[index]
  result

_prepend = (el, collection) ->
  _concat [el], collection

_.prepend = _curry2 _prepend

window._ = _ if window?
module.exports = _ if module? and module.exports?
