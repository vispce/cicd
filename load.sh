#!/bin/bash
echo "This is git push every day"
echo ""

datetime=$(date +%Y_%m_%d_%H_%M_%S)
total=31

for i in $(seq 1 $total); do
    filename="${datetime}_${i}.txt"
    echo "$filename" > /dev/null
    sleep 1
    # 普通进度条（无颜色）
    percent=$((i * 100 / total))
    filled=$((i * 40 / total))
    bar=$(printf "%${filled}s" | tr ' ' '+')
    space=$((40 - filled))
    
    printf "\r[%-40s] %3d%% (%d/%d) - %s" \
           "$bar" "$percent" "$i" "$total" "$filename"
    
done

echo -e "\n\n✓ All $total files created and committed"
