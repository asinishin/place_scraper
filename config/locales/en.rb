# encoding: UTF-8

{
  :'en' =>
{
###
#  General formats.
#
  :date => {
    :formats => {
      # Use the strftime parameters for formats.
      # When no format has been given, it uses default.
      # You can provide other formats here if you like!
      :default => "%m-%d-%Y",
      :short   => "%b %d, %Y",
      :long    => "%B %d, %Y"
    },
    :day_names => %w[ Sunday Monday Tuesday Wednesday Thursday Friday Saturday ],
    :abbr_day_names => %w[ Sun Mon Tue Wed Thu Fri Sat ],
    
    # Don't forget the nil at the beginning; there's no such thing as a 0th month
    :month_names => %w[ ~ January February March April May June July August September October November December ],
    :abbr_month_names => %w[ ~ Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec ],
    # Used in date_select and datetime_select.
    :order => [ :month, :day, :year ]
  },

  :time => {
    :formats => {
      :default => "%d %b %Hh",
      :short   => "%b %d, %H:%M",
      :long    => "%B %d, %Y %H:%M"
    },
    :am => "am",
    :pm => "pm"
  }
}

}
