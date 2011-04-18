class Event < ActiveRecord::Base
  extend ActiveSupport::Memoizable

  has_many :event_rubyists
  has_many :speakers, :source => :account, :through => :event_rubyists, :source => :rubyist
  has_many :event_time_slits
  has_many :time_slits, :through => :event_time_slits, :order => 'start_at'
  has_one :event_room
  has_one :room, :through => :event_room
  belongs_to :parent_event, :class_name => 'Event'
  has_many :children, :class_name => 'Event', :foreign_key => :parent_event_id

  scope :at, lambda {|room| {:joins => :event_room, :conditions => {:event_rooms => {:room_id => room}}}}
  scope :on, lambda {|day| {:joins => :time_slits, :conditions => {:time_slits => {:start_at => (from = Time.parse(day))..from.end_of_day}}}}
  scope :root, :conditions => {:parent_event_id => nil}

  def title
    I18n.locale.to_s == 'ja' ? (title_ja || title_en) : (title_en || title_ja)
  end

  def abstract
    I18n.locale.to_s == 'ja' ? (abstract_ja || abstract_en) : (abstract_en || abstract_ja)
  end

  def detail
    I18n.locale.to_s == 'ja' ? (detail_ja || detail_en) : (detail_en || detail_ja)
  end

  def from
    time_slits.first.start_at
  end

  def to
    time_slits.last.end_at
  end

  def date
    from.to_date
  end

  def time
    returning [self.from, self.to] do |arr|
      def arr.from; first; end
      def arr.to; last; end
    end
  end

  def minutes
    (to - from).to_i / 60
  end

  def presenter_name_without_afffiliation
    presenter_name ? presenter_name.gsub(/\(.+\)/, '') : ""
  end

  def presenter_profile
    I18n.locale.to_s == 'ja' ? (presenter_profile_ja || presenter_profile_en) : (presenter_profile_en || presenter_profile_ja)
  end

  def time_slot
    "#{from.strftime("%H:%M")} - #{to.strftime("%H:%M")}"
  end

  def room_name
    room.name
  end

  def has_movies?
    ! vimeo_id.blank? || ! nicovideo_id.blank?
  end

  memoize :from, :to, :date, :time
end
