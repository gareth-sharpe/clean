ECHO="echo"
DRY_RUN="true"
promotion_count=0
feature_count=0
emojis=(🔫 🔥 💀 🏴‍ 😈 💩 👾 🙌 💅 🎉 ⏰ 🎊 💣)

if [ $# -eq 0 ]
  then
    DRY_RUN="true"
  else 
    if [[ $1 == "dome" ]];
      then
        DRY_RUN="false"
    fi
fi

for branch in $(git branch -a | sed 's/^\s*//' | sed 's/^remotes\///' | grep -e 'promotion'); do
  if [[ "$(git log $branch --since "4 months ago" | wc -l)" -eq 0  ]]; then
    if [[ "$DRY_RUN" = "false"  ]]; then
      ECHO=""
    fi
    echo
    emoji=${emojis[ $RANDOM % ${#emojis[@]} ]}
    local_branch_name=$(echo "$branch" | sed 's/remotes\/origin\///')
    echo $emoji \ $local_branch_name
    promotion_count=$((promotion_count + 1))
    $ECHO git branch -d $local_branch_name
    process_id=$!
    wait $process_id
    $ECHO git push origin --delete $local_branch_name
    process_id=$!
    wait $process_id
  fi
done
echo
echo "Promotion branches deleted: $promotion_count"

for branch in $(git branch -a | sed 's/^\s*//' | sed 's/^remotes\///' | grep -e 'feature'); do
  if [[ "$(git log $branch --since "4 months ago" | wc -l)" -eq 0  ]]; then
    if [[ "$DRY_RUN" = "false"  ]]; then
      ECHO=""
    fi
    echo
    emoji=${emojis[ $RANDOM % ${#emojis[@]} ]}
    local_branch_name=$(echo "$branch" | sed 's/remotes\/origin\///')
    echo $emoji \ $local_branch_name
    feature_count=$((feature_count + 1))
    $ECHO git branch -d $local_branch_name
    process_id=$!
    wait $process_id
    $ECHO git push origin --delete $local_branch_name
    process_id=$!
    wait $process_id
  fi
done
echo
echo "Feature branches deleted: $feature_count"

count=$((promotion_count + feature_count))

echo
echo "Total branches deleted: $count"

if [[ "$DRY_RUN" = "true" ]]; 
  then 
    if [[ $2 == "hard" ]]; then
      "$(git branch -r --merged |  
      grep origin |
      grep -v '>' |
      grep -v master |
      xargs -L1 |
      awk '{sub(/origin\//,"")}' |
      xargs git push origin -d --dry-run)"
      stale="$(git branch -r --merged |  
        grep origin |
        grep -v '>' |
        grep -v master |
        xargs -L1 |
        awk '{sub(/origin\//,"");print}' | 
        wc -l)"
      echo "Stale branches deleted: $stale"
    fi
  else
    if [[ $2 == "hard" ]]; then
      "$(git branch -r --merged |  
      grep origin |
      grep -v '>' |
      grep -v master |
      xargs -L1 |
      awk '{sub(/origin\//,"");print}' |
      xargs git push origin -d)"
      stale="$(git branch -r --merged |  
        grep origin |
        grep -v '>' |
        grep -v master |
        xargs -L1 |
        awk '{sub(/origin\//,"");print}' | 
        wc -l)"
      echo "Stale branches deleted: $stale"
    fi
fi
