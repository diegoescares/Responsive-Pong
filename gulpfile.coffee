
gulp         = require("gulp")
coffee       = require("gulp-coffee")
stylus       = require("gulp-stylus")
watch        = require("gulp-watch")
livereload   = require("gulp-livereload")
include      = require("gulp-include")
prefix       = require("gulp-autoprefixer")
concat       = require("gulp-concat")
pug          = require("gulp-pug")
addsrc       = require("gulp-add-src")
changed      = require("gulp-changed")

path_dev     = "dev"
path_dist    = "dist"

files =

	pug:
		watch:          path_dev + "/pug/**/*.pug"
		src:            path_dev + "/pug/**/*.pug"
		destDist:       path_dist

	stylus:
		watch:          path_dev + "/stylus/**/*.styl"
		src:            path_dev + "/stylus/*.styl"
		destDist:       path_dist + "/css"

	coffee:
		watch:          path_dev + "/coffee/**/**/*.coffee"
		src:            path_dev + "/coffee/app.coffee"
		destDist:       path_dist + "/js"
		plugins:		[
							"bower_components/angular/angular.min.js"
						]

gulp.task "default", ->

	livereload.listen()
	gulp.watch(path_dist + "/css/*.css").on "change", livereload.changed

	gulp.watch files.pug.watch,        [ "build:html" ]
	gulp.watch files.stylus.watch,      [ "build:css" ]
	gulp.watch files.coffee.watch,      [ "build:js" ]

	return


gulp.task 'build', [
	'build:html'
	'build:js'
	'build:css'
]

gulp.task "build:html", ->
	gulp.src(files.pug.src)
		.pipe(pug(pretty: true))
		.pipe(gulp.dest(files.pug.destDist))
	return

gulp.task "build:css", ->
	gulp.src(files.stylus.src)
		.pipe(stylus({'include css': true}))
		.pipe(prefix())
		.pipe(gulp.dest(files.stylus.destDist))
	return

gulp.task "build:js", ->
	gulp.src(files.coffee.src)
		.pipe(include())
		.pipe(coffee(bare: true))
		.pipe(addsrc.prepend(files.coffee.plugins))
		.pipe(concat("main.js"))
		.pipe(gulp.dest(files.coffee.destDist))
	return


