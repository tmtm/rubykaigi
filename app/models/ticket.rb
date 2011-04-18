class Ticket < ActiveRecord::Base
  belongs_to :contribution
  belongs_to :ruby_kaigi
  belongs_to :rubyist

  validates_presence_of :name

  class << self
    def generate_ticket_code
      prefix = Digest::SHA1.hexdigest(srand.to_s)[0..7].upcase
      suffix = Digest::SHA1.hexdigest(srand.to_s)[0..7].upcase
      "#{prefix}-#{suffix}"
    end

    def generate_code4url
      Digest::SHA1.hexdigest(srand.to_s)[0..31]
    end

    def build_from_contrib(*contrib)
      contribs = contrib.flatten
      contribs.map do |c|
        Ticket.new(
          :ticket_code => Ticket.generate_ticket_code,
          :ticket_type => c.contribution_type,
          :code4url => Ticket.generate_code4url,
          :name => c.name_for_ticket,
          :email => c.email_for_ticket,
          :contribution => c,
          :rubyist => c.rubyist,
          :ruby_kaigi => c.ruby_kaigi
          )
      end
    end

    def build_extra_ticket_for_rubyist(rubyist, contribution_type, extra_ticket_type = nil)
      unless Contribution::Type::ENUM.include?(contribution_type.to_s)
        raise ArgumentError, "passed contribution_type '#{contribution_type}' is invalid. it should be one of these:'#{Contribution::Type::ENUM.join(', ')}'"
      end
      Ticket.new(
        :ticket_code => Ticket.generate_ticket_code,
        :ticket_type => contribution_type.to_s,
        :extra_ticket_type => extra_ticket_type.to_s,
        :code4url => Ticket.generate_code4url,
        :name => rubyist.full_name,
        :email => rubyist.email,
        :rubyist => rubyist,
        :ruby_kaigi => RubyKaigi.latest
        )
    end

    def build_extra_ticket_for_sponsor(name, email, contribution_type, extra_ticket_type = nil)
      unless Contribution::Type::ENUM.include?(contribution_type.to_s)
        raise ArgumentError, "passed contribution_type '#{contribution_type}' is invalid. it should be one of these:'#{Contribution::Type::ENUM.join(', ')}'"
      end
      Ticket.new(
        :ticket_code => Ticket.generate_ticket_code,
        :ticket_type => contribution_type.to_s,
        :extra_ticket_type => extra_ticket_type.to_s,
        :code4url => Ticket.generate_code4url,
        :name => name,
        :email => email,
        :ruby_kaigi => RubyKaigi.latest
        )
    end
  end # eigenclass

  def to_param
    code4url
  end

  before_save do
    self.email = "N / A" if self.email.blank?
  end
end
