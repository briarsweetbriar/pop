/*global module:false*/
module.exports = function(grunt) {

  // Project configuration.
  grunt.initConfig({
    // Metadata.
    pkg: grunt.file.readJSON('package.json'),
    banner: '/*! <%= pkg.title || pkg.name %> - v<%= pkg.version %> - ' +
      '<%= grunt.template.today("yyyy-mm-dd") %>\n' +
      '<%= pkg.homepage ? "* " + pkg.homepage + "\\n" : "" %>' +
      '* Copyright (c) <%= grunt.template.today("yyyy") %> <%= pkg.author.name %>;' +
      ' Licensed <%= _.pluck(pkg.licenses, "type").join(", ") %> */\n',
    // Task configuration.
    coffeelint: {
      app: ['app/*.coffee'],
      tests: {
        files: {
          src: ['test/**/*.coffee']
        },
        options: {
          'missing_fat_arrows': {
            'level': 'warn'
          },
          'newlines_after_classes': {
            'level': 'error'
          },
          'no_empty_param_list': {
            'level': 'error'
          },
          'arrow_spacing': {
            'level': 'error'
          },
          'line_endings': {
            'level': 'error'
          },
          'no_trailing_whitespace': {
            'level': 'error'
          }
        }
      }
    },
    coffee: {
      options: {
        bare: true
      },
      glob_to_multiple: {
        expand: true,
        cwd: 'app',
        src: ['**/*.coffee'],
        dest: 'tmp',
        ext: '.js'
      }
    },
    qunit: {
      files: ['test/unit-test.html']
    },
    watch: {
      coffee: {
        files: ['app/**/*.coffee'],
        tasks: ['coffee', 'concat:app', 'concat:test', 'qunit']
      }
    },
    concat: {
      app: {
        options: {
          banner: '<%= banner %>',
          stripBanners: true
        },
        src: ['bower_components/paper/dist/paper-core.js',
          'tmp/utilityBelt.js', 'tmp/game.js', 'tmp/language.js',
          'tmp/round.js', 'tmp/quiz.js', 'tmp/question.js',
          'tmp/balloon.js', 'tmp/main.js'],
        dest: 'dist/<%= pkg.name %>-<%= pkg.version %>.js'
      },
      test: {
        files: {
          'tmp/pop.js': ['dist/<%= pkg.name %>-<%= pkg.version %>.js'],
          'tmp/compiled_tests.js': ['tmp/test/**/*.js'],
        }
      }
    },
    uglify: {
      options: {
        banner: '<%= banner %>'
      },
      dist: {
        src: '<%= concat.app.dest %>',
        dest: 'dist/<%= pkg.name %>-<%= pkg.version %>.min.js'
      }
    }
  });

  // These plugins provide necessary tasks.
  grunt.loadNpmTasks('grunt-contrib-concat');
  grunt.loadNpmTasks('grunt-contrib-uglify');
  grunt.loadNpmTasks('grunt-contrib-qunit');
  grunt.loadNpmTasks('grunt-coffeelint');
  grunt.loadNpmTasks('grunt-contrib-watch');
  grunt.loadNpmTasks('grunt-contrib-coffee');

  // Default task.
  grunt.registerTask('default', ['coffeelint', 'coffee', 'concat:app',
    'concat:test', 'qunit', 'uglify'])

};
