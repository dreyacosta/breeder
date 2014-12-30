# breeder [![Build Status](https://travis-ci.org/dreyacosta/breeder.svg?branch=master)](https://travis-ci.org/dreyacosta/breeder)
> Functional JavaScript helper library (work in progress)

## Usage

### _.curry(fn)

Creates a new function of `fn` with the given arguments. When invoked return
will return another function with missing arguments, either return the
result if all arguments are provided.

```js
var _add10 = function (a) {
  return a + 10
};

var add10 = _.curry(_add10);

add10(90); // 100
add10(25); // 35
```

### _.map(iteratee, collection)

Return a new a list applying the iteratee provide function for each element of
the collection.

```js
var numbers = [5, 15, 25];

var add100 = function(value) { return value + 100 };

_.map(add100, numbers); // [105, 115, 125]
```

### _.compose(fn1, fn2, fn3)

Return a composition of a list of functions. Each functions consume the return
value of right function (right to left).

```js
var _sum = function (a, b) {
  return a + b;
};

var _double = function (a) {
  return a * 2;
};

var _plus100 = function (a) {
  return a + 100;
};

var _message = function (a) {
  return "Result is: " + a;
};

var sumDoublePlus100Message = _.compose(_message, _plus100, _double, _sum);
sumDoublePlus100Message(6, 4); // "Result is: 120";
```