export PATH="$HOME/.local/bin:$PATH"

# ── Secrets / API tokens ──────────────────────────────────────────
if [ -f ~/.secrets ]; then
    set -a
    . ~/.secrets
    set +a
fi

# ── Bail out early if non-interactive (protects scp/rsync/sftp) ──
[[ $- != *i* ]] && return

# ── History ──────────────────────────────────────────────────────
export HISTSIZE=10000
export HISTFILESIZE=20000
export HISTCONTROL=ignoreboth:erasedups
shopt -s histappend

# ── Better globbing ──────────────────────────────────────────────
shopt -s globstar 2>/dev/null
shopt -s nocaseglob 2>/dev/null

# ── Prompt ───────────────────────────────────────────────────────
_h=$(hostname -s)

# Colors (256-color safe, ASCII safe)
_c_rst='\[\e[0m\]'
_c_bold='\[\e[1m\]'
_c_green='\[\e[38;5;114m\]'
_c_cyan='\[\e[38;5;80m\]'
_c_blue='\[\e[38;5;75m\]'
_c_red='\[\e[38;5;203m\]'
_c_yellow='\[\e[38;5;220m\]'
_c_dim='\[\e[38;5;242m\]'

# Detect GPU machines by the presence of nvidia-smi
if [[ -n "$SSH_CONNECTION" ]] && command -v nvidia-smi &>/dev/null; then
    # ── CLUSTER NODE ── cache GPU & job info once at shell startup ─

    # GPU info (single nvidia-smi call)
    _gpu_lines=$(nvidia-smi --query-gpu=name --format=csv,noheader)
    _gpu_name=${_gpu_lines%%$'\n'*}        # first line
    _gpu_name=${_gpu_name#NVIDIA }         # strip redundant prefix
    _gpu_count=$(wc -l <<< "$_gpu_lines")
    _gpu_tag="${_gpu_name} x$(( _gpu_count ))"
    unset _gpu_lines _gpu_name _gpu_count

    # SLURM job timing (single scontrol call)
    _job_start_epoch=""
    _job_limit_secs=""
    if [[ -n "$SLURM_JOB_ID" ]]; then
        _sctl=$(scontrol show job "$SLURM_JOB_ID" 2>/dev/null)
        _sctl_start=$(grep -oP 'StartTime=\K\S+' <<< "$_sctl")
        _sctl_tlimit=$(grep -oP 'TimeLimit=\K\S+' <<< "$_sctl")
        [[ -n "$_sctl_start" ]] && \
            _job_start_epoch=$(date -d "$_sctl_start" +%s 2>/dev/null)
        # Parse TimeLimit (formats: MM:SS, HH:MM:SS, D-HH:MM:SS)
        if [[ -n "$_sctl_tlimit" && "$_sctl_tlimit" != "UNLIMITED" ]]; then
            _job_limit_secs=0
            _tl="$_sctl_tlimit"
            if [[ "$_tl" == *-* ]]; then
                (( _job_limit_secs += ${_tl%%-*} * 86400 ))
                _tl="${_tl#*-}"
            fi
            IFS=: read -ra _tl_parts <<< "$_tl"
            case ${#_tl_parts[@]} in
                3) (( _job_limit_secs += 10#${_tl_parts[0]}*3600 + 10#${_tl_parts[1]}*60 + 10#${_tl_parts[2]} )) ;;
                2) (( _job_limit_secs += 10#${_tl_parts[0]}*60   + 10#${_tl_parts[1]} )) ;;
                1) (( _job_limit_secs += 10#${_tl_parts[0]} )) ;;
            esac
            unset _tl _tl_parts
        fi
        unset _sctl _sctl_start _sctl_tlimit
    fi

    # PROMPT_COMMAND: countdown timer with color (pure builtins, no fork)
    # Color uses raw \001/\002 (readline markers) since it's expanded after PS1 decoding
    _job_timer=""
    _gpu_prompt_timer() {
        if [[ -n "$_job_start_epoch" && -n "$_job_limit_secs" ]]; then
            local _now _remaining _rh _rm _clr
            printf -v _now '%(%s)T' -1
            _remaining=$(( _job_limit_secs - (_now - _job_start_epoch) ))
            (( _remaining < 0 )) && _remaining=0
            _rh=$(( _remaining / 3600 )); _rm=$(( (_remaining % 3600) / 60 ))
            if (( _remaining >= 1800 )); then
                _clr=$'\001\e[38;5;114m\002'   # green  (>30 min)
            elif (( _remaining >= 600 )); then
                _clr=$'\001\e[38;5;220m\002'   # orange (10-30 min)
            else
                _clr=$'\001\e[38;5;203m\002'   # red    (<10 min)
            fi
            printf -v _job_timer '%s%d:%02d%s' "$_clr" "$_rh" "$_rm" $'\001\e[0m\002'
        else
            _job_timer=""
        fi
    }
    PROMPT_COMMAND="_gpu_prompt_timer"

    # Build PS1 — colors baked in now; $_job_timer deferred to each prompt
    PS1="${_c_dim}--[${_c_rst}${_c_bold}${_c_red}${_h}${_c_rst}"
    PS1+="${_c_dim} · ${_c_rst}${_c_yellow}${_gpu_tag}${_c_rst}"
    PS1+='${_job_timer:+'"${_c_dim}"' · '"${_c_rst}"'${_job_timer}}'
    PS1+="${_c_dim}]--${_c_rst} ${_c_green}\u${_c_rst} ${_c_blue}\w${_c_rst}"
    PS1+="\n${_c_yellow}\$${_c_rst} "

    unset _gpu_tag
else
    # ── Jump box / local ── clean and familiar ───────────────────
    PS1="${_c_green}\u${_c_rst}${_c_dim}@${_c_rst}${_c_cyan}${_h}${_c_rst}${_c_dim}:${_c_rst}${_c_blue}\w${_c_rst}${_c_dim}\$${_c_rst} "
fi

unset _h _c_rst _c_bold _c_green _c_cyan _c_blue _c_red _c_yellow _c_dim

# ── Source aliases ───────────────────────────────────────────────
[ -f ~/.bash_aliases ] && . ~/.bash_aliases

