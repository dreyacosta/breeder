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

_.curry = (fn) ->
  _curryN fn.length, fn

_compose = (fn1, fn2) ->
  ->
    fn1.call this, fn2.apply this, arguments

_.compose = _compose

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