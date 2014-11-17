"use strict"

gulp         = require "gulp"
coffee       = require "gulp-coffee"
concat       = require "gulp-concat"
ugligy       = require "gulp-uglify"
browserify   = require "browserify"
sourceStream = require "vinyl-source-stream"
buffer       = require "vinyl-buffer"
karma        = require("karma").server

meta =
  build  : "build"
  name   : "breeder"
  source : "source"
  specs  : "specs"

source =
  breeder : "./" + meta.source + "/" + meta.name + ".coffee"
  specs   : "./" + meta.specs + "/*.spec.coffee"

test = [
  "./" + meta.build + "/" + meta.name + ".js"
  "./" + meta.build + "/" + meta.name + ".spec.js"
]

gulp.task "breeder", ->
  gulp.src source.breeder
    .pipe concat "breeder.coffee"
    .pipe coffee()
    .pipe gulp.dest meta.build

gulp.task "browserify", ->
  bundler = browserify
    entries: [source.breeder]
    extensions: [".coffee"]
    debug: true

  bundler.bundle()
    .pipe sourceStream meta.name + ".js"
    .pipe buffer()
    .pipe gulp.dest meta.build

gulp.task "specs", ->
  gulp.src source.specs
    .pipe concat "breeder.spec.coffee"
    .pipe coffee()
    .pipe gulp.dest meta.build

gulp.task "test", ["browserify", "specs"], (done) ->
  karma.start
    autoWatch: "disable"
    basePath: "./"
    browsers: ["PhantomJS"]
    colors: true
    files: test
    frameworks: ["jasmine"]
    port: 8001
    reporters: ["progress"]
    singleRun: true
  , done

gulp.task "default", ->
  gulp.watch source.breeder, ["test"]
  gulp.watch source.specs, ["test"]