module AxeHelper
  RSpec::Matchers.define :be_accessible do
    match do |page|
      check
    end

    failure_message do |actual|
      check
    end

    failure_message_when_negated do |actual|
      check
    end

    def check
      expect(page).to be_axe_clean
    end
  end
end
