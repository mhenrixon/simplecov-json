# frozen_string_literal: true

module SimpleCov
  module Sublime
    #
    # Representation of a source file including it's coverage data, source code,
    # source lines and featuring helpers to interpret that data.
    #
    # @author Mikael Henriksson <mikael@mhenrixon.com>
    #
    class SourceFileWrapper
      #
      # Wrap the SimpleCov::SourceFile to enable hash conversion without monkey patching
      #
      # @param [SimpleCov::SourceFile] source_file the source file to generate hash for
      #
      def initialize(source_file)
        @source_file = source_file
      end

      #
      # Returns a nicely formatted hash from the source file data
      #
      #
      # @return [Hash]
      #
      def to_h
        {
          covered_percent: covered_percent,
          lines: lines,
          covered_strength: covered_strength,
          covered_lines: covered_lines_count,
          lines_of_code: lines_of_code
        }
      end

      private

      attr_reader :source_file

      # @private
      def lines
        return coverage if coverage.is_a?(Array)

        coverage.transform_keys(&:to_sym)[:lines]
      end

      def coverage
        @coverage ||=
          if SimpleCov::SourceFile.instance_methods.include?(:coverage_data)
            source_file.coverage_data
          else
            source_file.coverage
          end
      end

      # @private
      def covered_lines
        source_file.covered_lines
      end

      # @private
      def covered_lines_count
        covered_lines.count
      end

      # @private
      def covered_percent
        source_file.covered_percent
      end

      # @private
      def branches
        source_file.branches
      end

      # @private
      def branches_coverage_percent
        source_file.branches_coverage_percent
      end

      # @private
      def covered_branches
        source_file.covered_branches
      end

      # @private
      def missed_branches
        source_file.missed_branches
      end

      # @private
      def total_branches
        source_file.total_branches
      end

      # @private
      def covered_strength
        return 0.0 unless (coverage = source_file.covered_strength)

        coverage.nan? ? 0.0 : coverage
      end

      # @private
      def filename
        source_file.filename
      end

      # @private
      def lines_of_code
        source_file.lines_of_code
      end
    end
  end
end
