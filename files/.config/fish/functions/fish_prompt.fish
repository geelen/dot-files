function fish_prompt --description 'Write out the prompt'
	set -l pr_prompt (test $status -eq 0; and echo '\001\033[32m\002⚡\001\033[0m\002'; or echo '\001\033[31m\002⚡\001\033[0m\002')
	set -l duration $CMD_DURATION
	set -l pr_timestamp (date '+%a %H:%M:%S')
	set -l pr_user (whoami)
	set -l pr_hostname (hostname | cut -d . -f 1)
  set -l pr_host (echo "\001\033[33m\002$pr_hostname\001\033[0m\002")
	set -l pr_duration (test -n "$duration"; and echo " ($duration)")
	set -l pr_term (test $TERM = 'screen'; and echo "[screen/$WINDOW] ")
	set -l pr_cwd (project_pwd)
	set -l pr_git_info (git_cwd_info)
	echo -e "\001\033[90m\002$pr_timestamp$pr_duration\001\033[0m\002 $pr_user\001\033[90m\002@\001\033[0m\002$pr_host \001\033[90m\002$pr_term\001\033[0m\002$pr_cwd\001\033[90m\002$pr_git_info\001\033[0m\002\n$pr_prompt "
end
