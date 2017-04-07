require "comprehension/version"

module Comprehension
  module ProcExtension
    def lazy_comprehension(first_enum, *rest_enums)
      enum_for(:comprehension, first_enum, *rest_enums)
    end

    def comprehension(first_enum, *rest_enums)
      return lazy_comprehension(first_enum, *rest_enums).map(&:itself) unless block_given?

      if rest_enums.empty?
        first_enum.each {|x| yield self.(x) }
      else
        first_enum.each do |x|
          ->(*rest_elts) { yield(self.(x, *rest_elts)) }.comprehension(*rest_enums)
        end
      end
    end
  end
end

Proc.include Comprehension::ProcExtension
