

alias vi='nvim --noplugin -n'
alias vim='nvim -n'
export EDITOR=nvim

#export TERM=screen-256color
ZSH_THEME=robbyrussell
plugins=(
  git
  autojump
  wd
  vi-mode
)

function def(){
  local ext="${1##*.}"

  local name="${1%%.${ext}}"
  if [ ! -z "$2" ]; then
    name="$2"
  fi

  if [ "$ext" == 'py' ]; then
    alias $name="python $(realpath \"$1\")"
  elif [ "$ext" == 'sh' ]; then
    alias $name="zsh $(realpath \"$1\")"
  fi
}

function nospace(){
  f=`echo "$*" | sed 's/\s//g' | sed 's/内部存储/\/sdcard/g'`

  echo "$f"
}

function burl() {
  local url="$1"
  if [[ "$url" == '' || "$url" == '-h' ]]; then
    cat <<EOF
Usage:
  burl <URL> [...other args of curl]
EOF
    return 0
  fi

  shift
  curl "$url"\
  --compressed \
  -H 'Connection: keep-alive'\
  -H 'sec-ch-ua: " Not A;Brand";v="99", "Chromium";v="98", "Google Chrome";v="98"'\
  -H 'sec-ch-ua-mobile: ?0'\
  -H 'sec-ch-ua-platform: "Linux"'\
  -H 'DNT: 1'\
  -H 'Upgrade-Insecure-Requests: 1'\
  -H 'User-Agent: Mozilla/5.0 (X11; Debian; Linux x86_64; rv:85.0)  AppleWebKit/537.36 (KHTML, like Gecko) Chrome/98.0.4758.87 Safari/537.36'\
  -H 'Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.9'\
  -H "origin: $(echo "$url" | sed 's!\([^\:/]\)/.*!\1!g')"\
  -H "referer: $url"\
  -H 'Sec-Fetch-Site: same-site'\
  -H 'Sec-Fetch-Mode: navigate'\
  -H 'Sec-Fetch-User: ?1'\
  -H 'Sec-Fetch-Dest: document'\
  -H 'Accept-Encoding: gzip, deflate, br'\
  -H 'Accept-Language: en-US,en;q=0.9'\
  "$@"
}

function path() {
  #local path=(${(s/:/)PATH})

  if [ -z $1 ]; then
    local i=0
    for v in $path; do
      echo -e "\e[3;36m$i\e[0m"  $v
      (( i++ ))
    done

  elif [ $1 == 'add' ]; then
    local dir="$PWD"
    if [ ! -z "$2" ]; then
      dir="$(realpath "$2")"
      if [ ! -d "$dir" ]; then
        echo "path: '$dir' is not a valid directory." >&2
        return 1
      fi
    fi

    if [ -z $3 ]; then
      path=("$dir" "${path[@]}")
    elif [ $3 == '-' ]; then
      path=( "${path[@]}" "$dir")
    else
      path=("${path[@]:0:$3}" "$dir" "${path[@]:$3}")
    fi

  elif [ $1 == 'rm' ]; then
    if [ -z $2 ]; then
      shift path
    else
      local i
      ((i = $2 + 1))
      path=("${path[@]:0:$2}" "${path[@]:$i}")
    fi

  elif [ $1 == 'set' ]; then
    local dir="$PWD"
    if [ ! -z "$2" ]; then
      dir="$(realpath "$2")"
    fi

    if path add "$2"; then
      echo 'export PATH="'"$dir"':$PATH"' >> ~/.zshrc
    fi

  else
    _bold() {
      echo -e "\e[1;33m$1\e[0m"
    }

    cat <<EOF
PATH variable operator; v0.2 (2022-03-13)

Usage:
  path add [DIR] [INDEX]
  path rm  [INDEX]
  path set [DIR]

Command:

  $(_bold add)    Add PATH
    - DIR     target directory. (default=.)
    - INDEX   set insertion position. (default=0; i.e. head; '-' indicate tail)

  $(_bold rm)     Remove PATH
    - INDEX   index of item. (default=0)

  $(_bold set)    Permanency set PATH
    - DIR     target directory. (default=.)

EOF
  fi

  export PATH
}

