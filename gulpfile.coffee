gulp = require 'gulp'
del = require 'del'
sass = require 'gulp-sass'
coffee = require 'gulp-coffee'

gulp.task 'default', ->
  gulp.watch 'src/css/*.*',  ['compile-css']
  gulp.watch 'src/html/*.*', ['compile-html']
  gulp.watch 'src/js/*.*',   ['compile-js']

gulp.task 'clean', ->
  del 'dist/**/*'

gulp.task 'compile',
          ['compile-css', 'compile-js', 'compile-html', 'compile-fonts']

gulp.task 'compile-css', ->
  del('dist/css/**/*').then ->
    gulp.src 'src/css/**/*.sass'
      .pipe sass(outputStyle: 'compressed', quiet: true)
      .pipe gulp.dest 'dist/css/'

gulp.task 'compile-js', ->
  del('dist/js/**/*').then ->
    gulp.src 'src/js/**/*.coffee'
      .pipe coffee(bare: true)
      .pipe gulp.dest 'dist/js'

gulp.task 'compile-html', ->
  del('dist/html/**/*').then ->
    gulp.src 'src/html/**/*'
      .pipe gulp.dest 'dist/html'

gulp.task 'compile-fonts', ->
  del('dist/fonts/**/*').then ->
    gulp.src 'src/fonts/**/*'
      .pipe gulp.dest 'dist/fonts'
