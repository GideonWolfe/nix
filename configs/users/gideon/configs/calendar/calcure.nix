{ pkgs, lib, config, ... }:

with config.lib.stylix.colors.withHashtag;

{
  xdg.configFile.calcure = {

    enable = true;
    #onChange = manually tell darkreader to refresh somehow?
    target = "calcure/config.ini";
    text = ''
      [Parameters]
      ics_event_files = ${config.accounts.calendar.basePath}gmail/${config.accounts.calendar.accounts.gmail.primaryCollection}
      folder_with_datafiles = ~/.config/calcure
      calcurse_todo_file = ~/.local/share/calcurse/todo
      calcurse_events_file = ~/.local/share/calcurse/apts
      language = en
      default_view = calendar
      default_calendar_view = monthly
      birthdays_from_abook = Yes
      show_keybindings = Yes
      privacy_mode = No
      show_weather = No
      weather_city = 
      weather_metric_units = Yes
      minimal_today_indicator = Yes
      minimal_days_indicator = Yes
      minimal_weekend_indicator = Yes
      show_calendar_borders = No
      cut_titles_by_cell_length = No
      ask_confirmations = Yes
      ask_confirmation_to_quit = Yes
      use_unicode_icons = Yes
      show_current_time = No
      show_holidays = Yes
      show_nothing_planned = Yes
      one_timer_at_a_time = No
      holiday_country = UnitedStates
      use_persian_calendar = No
      start_week_day = 1
      weekend_days = 6,7
      refresh_interval = 1
      data_reload_interval = 0
      split_screen = Yes
      right_pane_percentage = 25
      journal_header = JOURNAL
      event_icon = •
      privacy_icon = •
      today_icon = •
      birthday_icon = ★
      holiday_icon = ⛱
      hidden_icon = ...
      done_icon = ✔
      todo_icon = •
      important_icon = ‣
      separator_icon = │
      deadline_icon = ⚑

      [Colors]
      color_today = 2
      color_events = 4
      color_days = 7
      color_day_names = 4
      color_weekends = 1
      color_weekend_names = 1
      color_hints = 7
      color_prompts = 7
      color_confirmations = 1
      color_birthdays = 1
      color_holidays = 2
      color_todo = 7
      color_done = 6
      color_title = 4
      color_calendar_header = 4
      color_important = 1
      color_unimportant = 6
      color_timer = 2
      color_timer_paused = 7
      color_time = 7
      color_deadlines = 3
      color_weather = 2
      color_active_pane = 2
      color_separator = 7
      color_calendar_border = 7
      color_ics_calendars = 2,3,1,7,4,5,2,3,1,7
      color_background = -1

      [Styles]
      bold_today = No
      bold_days = No
      bold_day_names = No
      bold_weekends = No
      bold_weekend_names = No
      bold_title = No
      bold_active_pane = No
      underlined_today = No
      underlined_days = No
      underlined_day_names = No
      underlined_weekends = No
      underlined_weekend_names = No
      underlined_title = No
      underlined_active_pane = No
      strikethrough_done = No

      [Event icons]
      travel = ✈
      plane = ✈
      voyage = ✈
      flight = ✈
      airport = ✈
      trip = 🏕
      vacation = ⛱
      holiday = ⛱
      day-off = ⛱
      hair = ✂
      barber = ✂
      beauty = ✂
      nails = ✂
      game = ♟
      match = ♟
      play = ♟
      interview = 🎙️
      conference = 🎙️
      talk = 🎙️
      dating = ♥
      concert = ♪
      dance = ♪
      music = ♪
      rehearsal = ♪
      call = 🕻
      zoom = 🕻
      deadline = ⚑
      over = ⚑
      finish = ⚑
      end = ⚑
      doctor = ✚
      dentist = ✚
      medical = ✚
      hospital = ✚
      party = ☘
      bar = ☘
      museum = ⛬
      meet = ⛬
      sport = ⛷
      gym = 🏋
      training = ⛷
      email = ✉
      letter = ✉
    '';
  };
}