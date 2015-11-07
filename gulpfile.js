var gulp = require('gulp'),
    del = require('del'),
    sass = require('gulp-sass'),
    coffee = require('gulp-coffee');

gulp.task('default', function()
{
  gulp.watch('src/css/*.*',  ['compile-css']);
  gulp.watch('src/html/*.*', ['compile-html']);
  gulp.watch('src/js/*.*',   ['compile-js']);
});

gulp.task('clean', function()
{
  return del('dist/**/*');
});

gulp.task('compile', ['compile-css', 'compile-js', 'compile-html', 'compile-fonts']);

gulp.task('compile-css', function()
{
  return del('dist/css/**/*').then(function(){
    gulp.src('src/css/**/*.sass')
      .pipe(sass({outputStyle: 'compressed', quiet: true}).on('error', sass.logError))
      .pipe(gulp.dest('dist/css/'));
  });
});

gulp.task('compile-js', function()
{
  return del('dist/js/**/*').then(function(){
    gulp.src('src/js/**/*.coffee')
      .pipe(coffee({bare: true}).on('error', console.log))
      .pipe(gulp.dest('dist/js'))
  });
});

gulp.task('compile-html', function()
{
  return del('dist/html/**/*').then(function(){
    gulp.src(['src/html/**/*']).pipe(gulp.dest('dist/html'));
  });
});

gulp.task('compile-fonts', function()
{
  return del('dist/fonts/**/*').then(function(){
    gulp.src(['src/fonts/**/*']).pipe(gulp.dest('dist/fonts'));
  });
});
