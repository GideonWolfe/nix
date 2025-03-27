{ pkgs, lib, config, ... }:

with config.lib.stylix.colors.withHashtag;

{
  xdg.configFile.obs-theme = {
    enable = true;
    target = "obs-studio/themes/stylix.ovt";
    text = ''

      @OBSThemeMeta {
          name: 'Mocha';
          id: 'com.obsproject.Catppuccin.Mocha';
          extends: 'com.obsproject.Catppuccin';
          author: 'Xurdejl';
          dark: 'true';
      }

      @OBSThemeVars {
          --ctp_rosewater: #f5e0dc;
          --ctp_flamingo: #f2cdcd;
          --ctp_pink: #f5c2e7;
          --ctp_mauve: #cba6f7;
          --ctp_red: #f38ba8;
          --ctp_maroon: #eba0ac;
          --ctp_peach: #fab387;
          --ctp_yellow: #f9e2af;
          --ctp_green: #a6e3a1;
          --ctp_teal: #94e2d5;
          --ctp_sky: #89dceb;
          --ctp_sapphire: #74c7ec;
          --ctp_blue: #89b4fa;
          --ctp_lavender: #b4befe;
          --ctp_text: #cdd6f4;
          --ctp_subtext1: #bac2de;
          --ctp_subtext0: #a6adc8;
          --ctp_overlay2: #9399b2;
          --ctp_overlay1: #7f849c;
          --ctp_overlay0: #6c7086;
          --ctp_surface2: #585b70;
          --ctp_surface1: #45475a;
          --ctp_surface0: #313244;
          --ctp_base: #1e1e2e;
          --ctp_mantle: #181825;
          --ctp_crust: #11111b;
          --ctp_selection_background: #353649;
      }

      VolumeMeter {
          qproperty-foregroundNominalColor: #6fd266;
          qproperty-foregroundWarningColor: #f7853f;
          qproperty-foregroundErrorColor: #ec4675;
      }

      /* Icon Overrides */

      .icon-plus {
          qproperty-icon: url(theme:Dark/plus.svg);
      }

      .icon-minus {
          qproperty-icon: url(theme:Dark/minus.svg);
      }

      .icon-trash {
          qproperty-icon: url(theme:Dark/trash.svg);
      }

      .icon-clear {
          qproperty-icon: url(theme:Dark/entry-clear.svg);
      }

      .icon-gear {
          qproperty-icon: url(theme:Dark/settings/general.svg);
      }

      .icon-dots-vert {
          qproperty-icon: url(theme:Dark/dots-vert.svg);
      }

      .icon-refresh {
          qproperty-icon: url(theme:Dark/refresh.svg);
      }

      .icon-cogs {
          qproperty-icon: url(theme:Dark/cogs.svg);
      }

      .icon-touch {
          qproperty-icon: url(theme:Dark/interact.svg);
      }

      .icon-up {
          qproperty-icon: url(theme:Dark/up.svg);
      }

      .icon-down {
          qproperty-icon: url(theme:Dark/down.svg);
      }

      .icon-pause {
          qproperty-icon: url(theme:Dark/media-pause.svg);
      }

      .icon-filter {
          qproperty-icon: url(theme:Dark/filter.svg);
      }

      .icon-revert {
          qproperty-icon: url(theme:Dark/revert.svg);
      }

      .icon-save {
          qproperty-icon: url(theme:Dark/save.svg);
      }

      /* Media icons */

      .icon-media-play {
          qproperty-icon: url(theme:Dark/media/media_play.svg);
      }

      .icon-media-pause {
          qproperty-icon: url(theme:Dark/media/media_pause.svg);
      }

      .icon-media-restart {
          qproperty-icon: url(theme:Dark/media/media_restart.svg);
      }

      .icon-media-stop {
          qproperty-icon: url(theme:Dark/media/media_stop.svg);
      }

      .icon-media-next {
          qproperty-icon: url(theme:Dark/media/media_next.svg);
      }

      .icon-media-prev {
          qproperty-icon: url(theme:Dark/media/media_previous.svg);
      }

      /* Context Menu */
      QMenu::right-arrow {
          image: url(theme:Dark/expand.svg);
      }

      /* Dock Widget */
      QDockWidget {
          titlebar-close-icon: url(theme:Dark/close.svg);
          titlebar-normal-icon: url(theme:Dark/popout.svg);
      }

      /* Source Context Bar */
      QPushButton#sourcePropertiesButton {
          qproperty-icon: url(theme:Dark/settings/general.svg);
      }

      QPushButton#sourceFiltersButton {
          qproperty-icon: url(theme:Dark/filter.svg);
      }

      /* Scenes and Sources toolbar */
      QToolBarExtension {
          qproperty-icon: url(theme:Dark/dots-vert.svg);
      }

      /* ComboBox */
      QComboBox::down-arrow,
      QDateTimeEdit::down-arrow {
          image: url(theme:Dark/collapse.svg);
      }

      QComboBox::down-arrow:editable,
      QDateTimeEdit::down-arrow:editable {
          image: url(theme:Dark/collapse.svg);
      }

      /* Spinbox and doubleSpinbox */
      QSpinBox::up-arrow,
      QDoubleSpinBox::up-arrow {
          image: url(theme:Dark/up.svg);
      }

      QSpinBox::down-arrow,
      QDoubleSpinBox::down-arrow {
          image: url(theme:Dark/down.svg);
      }

      /* Buttons */
      QPushButton::menu-indicator {
          image: url(theme:Dark/down.svg);
      }

      /* Settings Icons */
      OBSBasicSettings {
          qproperty-generalIcon: url(theme:Dark/settings/general.svg);
          qproperty-appearanceIcon: url(theme:Dark/settings/appearance.svg);
          qproperty-streamIcon: url(theme:Dark/settings/stream.svg);
          qproperty-outputIcon: url(theme:Dark/settings/output.svg);
          qproperty-audioIcon: url(theme:Dark/settings/audio.svg);
          qproperty-videoIcon: url(theme:Dark/settings/video.svg);
          qproperty-hotkeysIcon: url(theme:Dark/settings/hotkeys.svg);
          qproperty-accessibilityIcon: url(theme:Dark/settings/accessibility.svg);
          qproperty-advancedIcon: url(theme:Dark/settings/advanced.svg);
      }

      /* Checkboxes */
      QCheckBox::indicator:unchecked,
      QGroupBox::indicator:unchecked {
          image: url(theme:Yami/checkbox_unchecked.svg);
      }

      QCheckBox::indicator:unchecked:hover,
      QGroupBox::indicator:unchecked:hover {
          border: none;
          image: url(theme:Yami/checkbox_unchecked_focus.svg);
      }

      QCheckBox::indicator:checked,
      QGroupBox::indicator:checked {
          image: url(theme:Yami/checkbox_checked.svg);
      }

      QCheckBox::indicator:checked:hover,
      QGroupBox::indicator:checked:hover {
          image: url(theme:Yami/checkbox_checked_focus.svg);
      }

      QCheckBox::indicator:checked:disabled,
      QGroupBox::indicator:checked:disabled {
          image: url(theme:Yami/checkbox_checked_disabled.svg);
      }

      /* Locked CheckBox */
      .indicator-lock::indicator:checked,
      .indicator-lock::indicator:checked:hover {
          image: url(theme:Dark/locked.svg);
      }

      /* Visibility CheckBox */
      .indicator-visibility::indicator:checked,
      .indicator-visibility::indicator:checked:hover {
          image: url(theme:Dark/visible.svg);
      }

      /* Mute CheckBox */
      .indicator-mute::indicator:checked {
          image: url(theme:Dark/mute.svg);
      }

      .indicator-mute::indicator:indeterminate {
          image: url(theme:Dark/unassigned.svg);
      }

      .indicator-mute::indicator:unchecked {
          image: url(theme:Dark/settings/audio.svg);
      }

      .indicator-mute::indicator:unchecked:hover {
          image: url(theme:Dark/settings/audio.svg);
      }

      .indicator-mute::indicator:unchecked:focus {
          image: url(theme:Dark/settings/audio.svg);
      }

      .indicator-mute::indicator:checked:hover {
          image: url(theme:Dark/mute.svg);
      }

      .indicator-mute::indicator:checked:focus {
          image: url(theme:Dark/mute.svg);
      }

      .indicator-mute::indicator:checked:disabled {
          image: url(theme:Dark/mute.svg);
      }

      .indicator-mute::indicator:unchecked:disabled {
          image: url(theme:Dark/settings/audio.svg);
      }

      /* Sources List Group Collapse Checkbox */
      .indicator-expand::indicator:checked,
      .indicator-expand::indicator:checked:hover {
          image: url(theme:Dark/expand.svg);
      }

      .indicator-expand::indicator:unchecked,
      .indicator-expand::indicator:unchecked:hover {
          image: url(theme:Dark/collapse.svg);
      }

      /* Source Icons */
      OBSBasic {
          qproperty-imageIcon: url(theme:Dark/sources/image.svg);
          qproperty-colorIcon: url(theme:Dark/sources/brush.svg);
          qproperty-slideshowIcon: url(theme:Dark/sources/slideshow.svg);
          qproperty-audioInputIcon: url(theme:Dark/sources/microphone.svg);
          qproperty-audioOutputIcon: url(theme:Dark/settings/audio.svg);
          qproperty-desktopCapIcon: url(theme:Dark/settings/video.svg);
          qproperty-windowCapIcon: url(theme:Dark/sources/window.svg);
          qproperty-gameCapIcon: url(theme:Dark/sources/gamepad.svg);
          qproperty-cameraIcon: url(theme:Dark/sources/camera.svg);
          qproperty-textIcon: url(theme:Dark/sources/text.svg);
          qproperty-mediaIcon: url(theme:Dark/sources/media.svg);
          qproperty-browserIcon: url(theme:Dark/sources/globe.svg);
          qproperty-groupIcon: url(theme:Dark/sources/group.svg);
          qproperty-sceneIcon: url(theme:Dark/sources/scene.svg);
          qproperty-defaultIcon: url(theme:Dark/sources/default.svg);
          qproperty-audioProcessOutputIcon: url(theme:Dark/sources/windowaudio.svg);
      }

      /* YouTube Integration */
      OBSYoutubeActions {
          qproperty-thumbPlaceholder: url(theme:Dark/sources/image.svg);
      }

      /* Calendar Widget */
      QDateTimeEdit::down-arrow {
          image: url(theme:Dark/down.svg);
      }

      /* Calendar Top Bar Buttons */
      #qt_calendar_monthbutton::menu-indicator {
          image: url(theme:Dark/down.svg);
      }

      QCalendarWidget #qt_calendar_prevmonth {
          qproperty-icon: url(theme:Dark/left.svg);
      }

      QCalendarWidget #qt_calendar_nextmonth {
          qproperty-icon: url(theme:Dark/right.svg);
      }
    '';
  };
}
