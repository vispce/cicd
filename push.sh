#!/bin/bash
# 精简版Nginx日志每日备份脚本

# ==================== 配置 ====================
NGINX_LOG_DIR="/var/log/nginx"
BACKUP_DIR="/var/log/nginx_backup"
LOG_FILES="access.log error.log"
RETENTION_DAYS=30
DATE=$(date +%Y-%m-%d)

# ==================== 执行 ====================

echo "[$(date '+%Y-%m-%d %H:%M:%S')] 开始备份Nginx日志..."

# 创建备份目录
mkdir -p "${BACKUP_DIR}/${DATE}"

# 备份每个日志文件
for log in $LOG_FILES; do
    src="${NGINX_LOG_DIR}/${log}"
    dst="${BACKUP_DIR}/${DATE}/${log}.${DATE}"
    
    if [ -f "$src" ] && [ -s "$src" ]; then
        # 复制并清空原文件
        cp "$src" "$dst"
        > "$src"
        
        # 压缩备份
        gzip -f "$dst"
        
        echo "  备份: $log -> ${log}.${DATE}.gz"
    else
        echo "  跳过: $log (不存在或为空)"
    fi
done

# 重新加载nginx（让nginx使用新日志文件）
if command -v nginx &>/dev/null; then
    nginx -s reload
    echo "Nginx已重载"
fi

# 清理过期备份（保留30天）
find "$BACKUP_DIR" -name "*.log.*.gz" -mtime +$RETENTION_DAYS -delete
find "$BACKUP_DIR" -type d -empty -delete

echo "[$(date '+%Y-%m-%d %H:%M:%S')] 备份完成"
