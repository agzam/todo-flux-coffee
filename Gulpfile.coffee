gulp = require 'gulp'
browserify = require 'browserify'
source = require 'vinyl-source-stream'
$ = (require 'gulp-load-plugins')()
$.q = require 'q'

gulp.task 'compile:coffee' , ->
#  dfrd = $.q.defer()
  browserify (
    entries: [ './src/app.coffee' ]
    extensions: ['.coffee']
    debug: yes
#        cache: {}, packageCache: {}, fullPaths: yes
  )
  .transform ['coffeeify']
  .transform ['reactify', 'extension':'coffee']
  .bundle()
  .pipe source 'app.js'
  .pipe gulp.dest './dist/'

gulp.task 'default', [ 'compile:coffee' ]