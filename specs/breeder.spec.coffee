"use strict"

describe "Breeder", ->

  it "should curry2 a function with 2 arguments", ->
    _sum = (a, b) ->
      a + b
    sum = _.curry _sum
    partial = sum 6
    result  = partial 4
    expect(result).toEqual 10

  it "should curry a function with 2 arguments", ->
    _sum = (a, b) ->
      a + b
    sum = _.curry _sum
    partial = sum 6
    result  = partial 4
    expect(result).toEqual 10

  it "should curry a function with N arguments", ->
    _doubleAtripeBsumToCandD = (a, b, c, d) ->
      (a * 2) + (b * 3) + c + d
    doubleAtripeBsumToCandD = _.curry _doubleAtripeBsumToCandD
    partial1 = doubleAtripeBsumToCandD 5
    partial2 = partial1 4
    result   = partial2 10, 8
    expect(result).toEqual 40

  it "should compose a function from 2 functions", ->
    _sum = (a, b) ->
      a + b
    _double = (a) ->
      a * 2
    sumThenDouble = _.compose _double, _sum
    result = sumThenDouble 6, 4
    expect(result).toEqual 20

  it "should compose a function from 4 functions", ->
    _sum = (a, b) ->
      a + b
    _double = (a) ->
      a * 2
    _plus100 = (a) ->
      a + 100
    _message = (a) ->
      "Result is: #{a}"
    sumDoublePlus100Message = _.compose _message, _plus100, _double, _sum
    result = sumDoublePlus100Message 6, 4
    expect(result).toEqual "Result is: 120"

  it "should map over a collection", ->
    collection = [10, 20, 30]
    add100 = (a) ->
      a + 100
    result = _.map add100, collection
    expect(result).toEqual [110, 120, 130]

  it "should curry map over a collection", ->
    collection = [1, 2, 3]
    double = (a) ->
      a * 2
    doubleMap = _.map double
    result    = doubleMap collection
    expect(result).toEqual [2, 4, 6]

  it "should take a property from an object", ->
    user =
      username: "@dreyacosta"
      site: "http://dreyacosta.com"
    getSite = _.prop "site"
    result  = getSite user
    expect(result).toEqual "http://dreyacosta.com"

  it "should take a property from an object (curried)", ->
    fruits = [
      { name: "Apple", color: "green" }
      { name: "Kiwi", color: "brown" }
      { name: "Lemon", color: "yellow" }
    ]
    getColor = _.prop "color"
    result1  = getColor fruits[0]
    result2  = getColor fruits[1]
    expect(result1).toEqual "green"
    expect(result2).toEqual "brown"

  it "should pluck colors", ->
    fruits = [
      { name: "Apple", color: "green" }
      { name: "Kiwi", color: "brown" }
      { name: "Lemon", color: "yellow" }
    ]
    result = _.pluck "color", fruits
    expect(result).toEqual ["green", "brown", "yellow"]

  it "should filter 0 of a collection", ->
    prices  = [37, 0, 0, 89, 78, 123, 0, 1, 0]
    remove0 = (a) ->
      a isnt 0
    result = _.filter remove0, prices
    expect(result).toEqual [37, 89, 78, 123, 1]

  it "should reduce a collection", ->
    fruits = [
      { name: "Apple", color: "green" }
      { name: "Kiwi", color: "brown" }
      { name: "Lemon", color: "yellow" }
    ]
    _setPrice = (defaultPrice, accumulator, item) ->
      item.price = defaultPrice
      accumulator.push item
      accumulator
    setPrice = _.curry _setPrice
    setPriceToZero = setPrice 0
    result = _.reduce(setPriceToZero, [], fruits)
    expect(result[0].price).toEqual 0
    expect(result[1].price).toEqual 0

  it "should clone an object and be pure", ->
    user =
      username: "@dreyacosta"
      site: "http://dreyacosta.com"
    clone = _.cloneObj user
    user.username = "@drey"
    expect(clone.username).toEqual "@dreyacosta"
    expect(user.username).toEqual "@drey"

  it "should prepend an element", ->
    abc = ["a", "b", "c"]
    result = _.prepend "d", abc
    expect(result).toEqual ["d", "a", "b", "c"]

  it "should curry prepend an element", ->
    abc = ["a", "b", "c"]
    prependZ = _.prepend "Z"
    expect(prependZ(abc)).toEqual ["Z", "a", "b", "c"]