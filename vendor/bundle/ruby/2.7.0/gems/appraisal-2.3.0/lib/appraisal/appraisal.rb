require 'appraisal/gemfile'
require 'appraisal/command'
require 'appraisal/utils'
require 'fileutils'
require 'pathname'

module Appraisal
  # Represents one appraisal and its dependencies
  class Appraisal
    DEFAULT_INSTALL_OPTIONS = { "jobs" => 1 }.freeze

    attr_reader :name, :gemfile

    def initialize(name, source_gemfile)
      @name = name
      @gemfile = source_gemfile.dup
    end

    def gem(*args)
      gemfile.gem(*args)
    end

    def source(*args, &block)
      gemfile.source(*args, &block)
    end

    def ruby(*args)
      gemfile.ruby(*args)
    end

    def git(*args, &block)
      gemfile.git(*args, &block)
    end

    def path(*args, &block)
      gemfile.path(*args, &block)
    end

    def group(*args, &block)
      gemfile.group(*args, &block)
    end

    def platforms(*args, &block)
      gemfile.platforms(*args, &block)
    end

    def gemspec(options = {})
      gemfile.gemspec(options)
    end

    def git_source(*args, &block)
      gemfile.git_source(*args, &block)
    end

    def write_gemfile
      File.open(gemfile_path, "w") do |file|
        signature = "# This file was generated by Appraisal"
        file.puts([signature, gemfile.to_s].join("\n\n"))
      end
    end

    def install(options = {})
      commands = [install_command(options).join(" ")]

      if options["without"].nil? || options["without"].empty?
        commands.unshift(check_command.join(" "))
      end

      command = commands.join(" || ")

      if Bundler.settings[:path]
        env = { 'BUNDLE_DISABLE_SHARED_GEMS' => '1' }
        Command.new(command, :env => env).run
      else
        Command.new(command).run
      end
    end

    def update(gems = [])
      Command.new(update_command(gems), :gemfile => gemfile_path).run
    end

    def gemfile_path
      unless gemfile_root.exist?
        gemfile_root.mkdir
      end

      gemfile_root.join(gemfile_name).to_s
    end

    def relative_gemfile_path
      File.join("gemfiles", gemfile_name)
    end

    def relativize
      current_directory = Pathname.new(Dir.pwd)
      relative_path = current_directory.relative_path_from(gemfile_root).cleanpath
      lockfile_content = File.read(lockfile_path)

      File.open(lockfile_path, 'w') do |file|
        file.write lockfile_content.gsub(/#{current_directory}/, relative_path.to_s)
      end
    end

    private

    def check_command
      gemfile_option = "--gemfile='#{gemfile_path}'"
      ['bundle', 'check', gemfile_option]
    end

    def install_command(options = {})
      gemfile_option = "--gemfile='#{gemfile_path}'"
      ['bundle', 'install', gemfile_option, bundle_options(options)].compact
    end

    def update_command(gems)
      ['bundle', 'update', *gems].compact
    end

    def gemfile_root
      project_root + "gemfiles"
    end

    def project_root
      Pathname.new(Dir.pwd)
    end

    def gemfile_name
      "#{clean_name}.gemfile"
    end

    def lockfile_path
      "#{gemfile_path}.lock"
    end

    def clean_name
      name.gsub(/[^\w\.]/, '_')
    end

    def bundle_options(options)
      full_options = DEFAULT_INSTALL_OPTIONS.dup.merge(options)
      options_strings = []
      jobs = full_options.delete("jobs")
      if jobs > 1
        if Utils.support_parallel_installation?
          options_strings << "--jobs=#{jobs}"
        else
          warn 'Your current version of Bundler does not support parallel installation. Please ' +
            'upgrade Bundler to version >= 1.4.0, or invoke `appraisal` without `--jobs` option.'
        end
      end

      path = full_options.delete("path")
      if path
        relative_path = project_root.join(options["path"])
        options_strings << "--path #{relative_path}"
      end

      full_options.each do |flag, val|
        options_strings << "--#{flag} #{val}"
      end

      options_strings.join(" ") if options_strings != []
    end
  end
end