require 'macrow/version'
require 'macrow/error'

class Macrow
  class << self
    def inherited(child)
      child.instance_variable_set(:@rule_words, rule_words.dup)
    end

    def rule_words
      @rule_words ||= []
    end

    def rules
      yield
    end

    def macro_prefix(prefix)
      @macro_prefix = prefix
    end

    def macro_suffix(suffix)
      @macro_suffix = suffix
    end

    def rule(keyword, &block)
      rule_words << keyword

      define_method "apply_rule_for_#{keyword}!" do |str, object|
        if str.include? replace_string(keyword)
          begin
            str.gsub!(replace_string(keyword), instance_exec(object, &block).to_s)
            str
          rescue NoMethodError => e
            fail Macrow::ReplaceError, "NoMethodError is raised on applying rule: '#{keyword}'. Please check your rule. Error message is '#{e.message}'"
          end
        end
      end
    end

    def replace_string(keyword)
      "#{_macro_prefix}#{keyword}#{_macro_suffix}"
    end

    private

    def _macro_prefix
      @macro_prefix ||= '${'
    end

    def _macro_suffix
      @macro_suffix ||= '}'
    end
  end

  def apply_all_rules(str, object = nil)
    return if str.nil? || !str.is_a?(String)

    dup_str = str.dup

    self.class.rule_words.each do |rule_word|
      apply_rule!(rule_word, dup_str, object)
    end

    dup_str
  end
  alias_method :apply, :apply_all_rules

  def apply_rule!(rule, str, object)
    __send__("apply_rule_for_#{rule}!", str, object)
  end

  private

  def replace_string(keyword)
    self.class.replace_string(keyword)
  end
end
