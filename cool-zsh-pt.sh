apt update

sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

echo "# FROM cool-zsh-pt.sh SCRIPT" >> $HOME/.zshrc

echo "ZSH_THERE=fino" >> $HOME/.zshrc

apt install -y git
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

echo "plugins=(git zsh-syntax-highlighting colorize grc tmux)" >> $HOME/.zshrc
echo 'ZSH_COLORIZE_STYLE="colorful"' >> $HOME/.zshrc
echo "ZSH_TMUX_AUTOSTART=true" >> $HOME/.zshrc

apt install -y tmux
apt install -y grc
apt install -y exa
apt install -y ccrypt
apt install -y kitty

sed -i '/source $ZSH\/oh-my-zsh.sh/d' $HOME/.zshrc
echo "source \$ZSH/oh-my-zsh.sh" >> $HOME/.zshrc

echo "alias cat='ccat'" >> $HOME/.zshrc
echo "alias ls='exa -a --color=always --group-directories-first --icons' #my preferred listing" >> $HOME/.zshrc
echo "alias la='exa -a --color=always --group-directories-first --icons'  # all files and dirs" >> $HOME/.zshrc
echo "alias ll='exa -l --color=always --group-directories-first --icons'  # long format" >> $HOME/.zshrc
echo "alias lt='exa -aT --color=always --group-directories-first --icons' # tree listing" >> $HOME/.zshrc
echo "alias l.='exa -a --icons | egrep \"^\.\"'" >> $HOME/.zshrc

mkdir -p $HOME/.config/kitty

cat <<'EOF' > /root/.config/kitty/kitty.conf
# updated to include the tokyonights color scheme

# Font Settings
font_family      Hack
italic_font      auto
bold_font        auto
bold_italic_font auto
font_size        14.0

# The cursor shape can be one of (block, beam, underline)
cursor_shape     beam

# The interval (in seconds) at which to blink the cursor. Set to zero to
# disable blinking.
cursor_blink_interval     0.5

# Number of lines of history to keep in memory for scrolling back
scrollback_lines 2000

# Program with which to view scrollback in a new window. The scrollback buffer is passed as
# STDIN to this program. If you change it, make sure the program you use can
# handle ANSI escape sequences for colors and text formatting.
scrollback_pager less +G -R

# Wheel scroll multiplier (modify the amount scrolled by the mouse wheel)
wheel_scroll_multiplier 5.0

# The interval between successive clicks to detect double/triple clicks (in seconds)
click_interval 0.5

# Characters considered part of a word when double clicking. In addition to these characters
# any character that is marked as an alpha-numeric character in the unicode
# database will be matched.
select_by_word_characters :@-./_~?&=%+#

# Hide mouse cursor after the specified number of seconds of the mouse not being used. Set to
# zero or a negative number to disable mouse cursor hiding.
mouse_hide_wait 0.0


# Delay (in milliseconds) between screen updates. Decreasing it, increases fps
# at the cost of more CPU usage. The default value yields ~100fps which is more
# that sufficient for most uses.
# repaint_delay    10
repaint_delay    10

# Delay (in milliseconds) before input from the program running in the terminal
# is processed. Note that decreasing it will increase responsiveness, but also
# increase CPU usage and might cause flicker in full screen programs that
# redraw the entire screen on each loop, because kitty is so fast that partial
# screen updates will be drawn.
input_delay 3

# Visual bell duration. Flash the screen when a bell occurs for the specified number of
# seconds. Set to zero to disable.
visual_bell_duration 0.0

# Enable/disable the audio bell. Useful in environments that require silence.
enable_audio_bell no

# The modifier keys to press when clicking with the mouse on URLs to open the URL
open_url_modifiers ctrl+shift

# The program with which to open URLs that are clicked on. The special value "default" means to
# use the operating system's default URL handler.
open_url_with default

# The value of the TERM environment variable to set
term xterm-kitty

# The color for the border of the active window
active_border_color #ffffff

# The color for the border of inactive windows
inactive_border_color #cccccc

# ============= Tokyo Nights Color Theme =============
background #1a1b26
foreground #c0caf5
selection_background #33467c
selection_foreground #c0caf5
url_color #73daca
cursor #c0caf5
cursor_text_color #1a1b26

# Tabs
active_tab_background #7aa2f7
active_tab_foreground #16161e
inactive_tab_background #292e42
inactive_tab_foreground #545c7e
tab_bar_background #15161e

# normal
color0 #15161e
color1 #f7768e
color2 #9ece6a
color3 #e0af68
color4 #7aa2f7
color5 #bb9af7
color6 #7dcfff
color7 #a9b1d6

# bright
color8 #414868
color9 #f7768e
color10 #9ece6a
color11 #e0af68
color12 #7aa2f7
color13 #bb9af7
color14 #7dcfff
color15 #c0caf5

# extended colors
color16 #ff9e64
color17 #db4b4b
# ====================================================

# KEY MAPS
# ===================================
# Clipboard
map super+v             paste_from_clipboard
map ctrl+shift+s        paste_from_selection
map super+c             copy_to_clipboard
map shift+insert        paste_from_selection

# Scrolling
map ctrl+shift+up        scroll_line_up
map ctrl+shift+down      scroll_line_down
map ctrl+shift+k         scroll_line_up
map ctrl+shift+j         scroll_line_down
map ctrl+shift+page_up   scroll_page_up
map ctrl+shift+page_down scroll_page_down
map ctrl+shift+home      scroll_home
map ctrl+shift+end       scroll_end
map ctrl+shift+h         show_scrollback

# Window management
map super+n             new_os_window
map super+w             close_window
map ctrl+shift+enter    new_window
map ctrl+shift+]        next_window
map ctrl+shift+[        previous_window
map ctrl+shift+f        move_window_forward
map ctrl+shift+b        move_window_backward
map ctrl+shift+`        move_window_to_top
map ctrl+shift+1        first_window
map ctrl+shift+2        second_window
map ctrl+shift+3        third_window
map ctrl+shift+4        fourth_window
map ctrl+shift+5        fifth_window
map ctrl+shift+6        sixth_window
map ctrl+shift+7        seventh_window
map ctrl+shift+8        eighth_window
map ctrl+shift+9        ninth_window
map ctrl+shift+0        tenth_window

# Tab management
map ctrl+shift+right    next_tab
map ctrl+shift+left     previous_tab
map ctrl+shift+t        new_tab
map ctrl+shift+q        close_tab
map ctrl+shift+l        next_layout
map ctrl+shift+.        move_tab_forward
map ctrl+shift+,        move_tab_backward

# Miscellaneous
map ctrl+shift+up      increase_font_size
map ctrl+shift+down    decrease_font_size
map ctrl+shift+backspace restore_font_size

# Symbol mapping (special font for specified unicode code points). Map the
# specified unicode codepoints to a particular font. Useful if you need special
# rendering for some symbols, such as for Powerline. Avoids the need for
# patched fonts. Each unicode code point is specified in the form U+<code point
# in hexadecimal>. You can specify multiple code points, separated by commas
# and ranges separated by hyphens. symbol_map itself can be specified multiple times.
# Syntax is:
#
symbol_map codepoints Hack
#
# For example:
#
#symbol_map U+E0A0-U+E0A2,U+E0B0-U+E0B3 PowerlineSymbols

# Change the color of the kitty window's titlebar on macOS. A value of "system"
# means to use the default system color, a value of "background" means to use
# the default background color and finally you can use an arbitrary color, such
# as #12af59 or "red".
macos_titlebar_color background

allow_remote_control yes
EOF

cat <<'EOF' > /root/.tmux.conf
#
# inspired by Ham Vocke's and milosz's config files:
# https://www.hamvocke.com/blog/a-guide-to-customizing-your-tmux-conf/
# https://sleeplessbeastie.eu/2016/08/22/how-to-create-basic-tmux-setup/
#
# last updated: 2021-06-28
#

# remap bind key from 'Ctrl-b' to 'Ctrl-a'
unbind C-b
set-option -g prefix C-a
bind-key C-a send-prefix

# Set the default terminal type
set -g default-terminal "screen-256color"

# source config with C-a + r
bind-key r source-file ~/.tmux.conf \; display-message "~/.tmux.conf reloaded"

# open config with C-a then shift+M
bind-key M split-window -h "vim ~/.tmux.conf"

# enable mouse mode (>tmux 2.1)
# clickable windows, panes, resizable panes
set -g mouse on

# start counting windows and panels from 1
set -g base-index 1
set-window-option -g pane-base-index 1

# don't rename windows automatically
set-option -g allow-rename off

# split panes vertically with |
# split panes horizontally with  -
bind | split-window -h
bind - split-window -v
unbind '"'
unbind %

# Vim style pane selection
bind h select-pane -L
bind l select-pane -R
bind k select-pane -U
bind j select-pane -D

# switch panes using Alt-arrow without prefix
# M is meta key, typically alt on macOS
bind -n M-Left select-pane -L
bind -n M-Right select-pane -R
bind -n M-Up select-pane -U
bind -n M-Down select-pane -D

# Shift arrow to switch windows
bind -n S-Left  previous-window
bind -n S-Right next-window

# turn off all the bell sounds
set -g visual-activity off
set -g visual-bell off
set -g visual-silence off
setw -g monitor-activity off
set -g bell-action none

# statusbar
# xterm colors    : https://jonasjacek.github.io/colors/
# strftime format : https://devhints.io/datetime
set -g status-position bottom
set -g status-style 'bg=colour235 fg=colour255'
set -g status-left "  "
set -g status-right "#[bg=colour235,fg=colour255] %a %b %e #[bg=colour235,fg=colour255] %H:%M:%S  "
set -g status-right-length 50
set -g status-left-length 50

# panes colors
set -g pane-border-style 'bg=default fg=colour19'
set -g pane-active-border-style 'bg=default fg=colour172'

# message styling
set -g message-style 'fg=colour255 bg=colour62'

setw -g mode-keys vi
EOF
