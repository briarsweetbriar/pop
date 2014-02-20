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
          'no_trailing_whitespace': {
            'level': 'error'
          }
        }
      }
    },
    coffee: {
      glob_to_multiple: {
        expand: true,
        cwd: 'app',
        src: ['**/*.coffee'],
        dest: 'tmp',
        ext: '.js'
      }
    },
    requirejs: {
      options: {
        optimize: "uglify2",
        baseUrl: "tmp",
        include: "main",
        mainConfigFile: "tmp/config/requirejs.js",
        name: "../bower_components/almond/almond",
        out: "tmp/<%= pkg.name %>.js"
      },
      development: {
        options: {
          optimize: 'none'
        }
      },
      production: {
        options: {
          optimize: 'uglify2'
        }
      }
    },
    qunit: {
      files: ['test/**/*.html']
    },
    watch: {
      gruntfile: {
        files: '<%= jshint.gruntfile.src %>',
        tasks: ['jshint:gruntfile']
      },
      lib_test: {
        files: '<%= jshint.lib_test.src %>',
        tasks: ['jshint:lib_test', 'qunit']
      }
    },
    concat: {
      options: {
        banner: '<%= banner %>',
        stripBanners: true
      },
      dist: {
        src: ['tmp/<%= pkg.name %>.js'],
        dest: 'dist/<%= pkg.name %>-<%= pkg.version %>.min.js'
      }
    }
  });

  // These plugins provide necessary tasks.
  grunt.loadNpmTasks('grunt-contrib-concat');
  grunt.loadNpmTasks('grunt-contrib-qunit');
  grunt.loadNpmTasks('grunt-coffeelint');
  grunt.loadNpmTasks('grunt-contrib-watch');
  grunt.loadNpmTasks('grunt-contrib-coffee');
  grunt.loadNpmTasks('grunt-contrib-requirejs');

  // Default task.
  grunt.registerTask('work', ['coffeelint', 'coffee', 'requirejs:development',
    'qunit', 'concat']);
  grunt.registerTask('production', ['coffeelint', 'coffee', 'requirejs:production',
    'qunit', 'concat']);
  grunt.registerTask('default', ['work'])

};
