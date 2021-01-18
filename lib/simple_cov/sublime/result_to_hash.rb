# frozen_string_literal: true

module SimpleCov
  module Sublime
    #
    # Massage result into a hash that can be dumped to json by OJ
    #
    # @author Mikael Henriksson <mikael@mhenrixon.se>
    #
    class ResultToHash
      #
      # Initialize a new ResultToHash
      #
      # @param [SimpleCov::Result] result the final result from simplecov
      #
      def initialize(result)
        @result = result
        @data = {
          timestamp: result.created_at.to_i,
          command_name: result.command_name,
          coverage: {}
        }
      end

      #
      # Create a hash from the result that can be used for JSON dumping
      #
      #
      # @return [Hash]
      #
      def to_h
        extract_files
        extract_metrics
        data
      end

      private

      attr_reader :result, :data

      # @private
      def extract_files
        result.files.each do |source_file|
          next unless result.filenames.include?(source_file.filename)

          data[:coverage][source_file.filename] = SourceFileWrapper.new(source_file).to_h
        end
        data[:coverage]
      end

      # @private
      def extract_metrics
        data[:metrics] = ResultWrapper.new(result).to_h
      end
    end
  end
end
