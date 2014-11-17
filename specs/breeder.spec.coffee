"use strict"

describe "Breeder", ->

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