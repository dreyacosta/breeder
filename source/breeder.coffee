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

window._ = _ if window?
module.exports = _ if module? and module.exports?