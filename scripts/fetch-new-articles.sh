#!/bin/bash
# fetch-new-articles.sh
# 检测并抓取万维钢·现代思维工具100讲的新文章
# 依赖：Chrome (已登录得到) + web-access CDP proxy 已运行
#
# 用法：./scripts/fetch-new-articles.sh
# 或定期调用 (e.g., 每周一次)

set -e

OUTDIR="$(dirname "$0")/../sources"
CDP_PROXY="http://localhost:3456"
COURSE_URL="https://www.dedao.cn/course/article?id=qzk8vQM4oYjrXm1Ao9Xw6bEOLl5GPx"

echo "=== wan-sir article fetcher ==="
echo "Output dir: $OUTDIR"
mkdir -p "$OUTDIR"

# 检查 CDP proxy
if ! curl -s "$CDP_PROXY/health" > /dev/null 2>&1; then
  echo "ERROR: CDP proxy not running at $CDP_PROXY"
  echo "Run: node ~/.claude/skills/web-access/scripts/cdp-proxy.mjs &"
  exit 1
fi

# 打开课程页
echo "Opening course page..."
RESULT=$(curl -s "$CDP_PROXY/new?url=$COURSE_URL")
TARGET=$(echo "$RESULT" | python3 -c "import sys,json;print(json.load(sys.stdin)['targetId'])")
echo "Tab: $TARGET"
sleep 3

# 获取当前文章总数
COUNT=$(curl -s -X POST "$CDP_PROXY/eval?target=$TARGET" \
  -d "document.querySelectorAll('.article-list-title').length" \
  | python3 -c "import sys,json;print(json.load(sys.stdin)['value'])")
echo "Found $COUNT articles in course listing"

# 已存在的文件数
EXISTING=$(ls "$OUTDIR"/wan_modern_tool_*.md 2>/dev/null | wc -l | tr -d ' ')
echo "Already fetched: $EXISTING articles"

if [ "$COUNT" -le "$EXISTING" ]; then
  echo "No new articles. Done."
  curl -s "$CDP_PROXY/close?target=$TARGET" > /dev/null
  exit 0
fi

echo "New articles detected: $((COUNT - EXISTING)). Fetching..."

# 逐一点击新文章（从 EXISTING 开始）
for i in $(seq "$EXISTING" $((COUNT - 1))); do
  NUM=$(printf "%04d" $((i + 1)))
  OUTFILE="$OUTDIR/wan_modern_tool_${NUM}.md"

  if [ -f "$OUTFILE" ]; then
    echo "[$NUM] already exists, skip"
    continue
  fi

  # 点击并等待
  TITLE=$(curl -s -X POST "$CDP_PROXY/eval?target=$TARGET" \
    -d "(function(){document.querySelectorAll('.article-list-title')[$i].click();return document.querySelectorAll('.article-list-title')[$i].innerText.trim()})()" \
    | python3 -c "import sys,json;print(json.load(sys.stdin).get('value',''))")
  sleep 3

  # 获取 ID 和内容
  INFO=$(curl -s "$CDP_PROXY/info?target=$TARGET")
  ART_ID=$(echo "$INFO" | python3 -c "import sys,json;u=json.load(sys.stdin).get('url','');print(u.split('id=')[-1] if 'id=' in u else '')")

  CONTENT=$(curl -s -X POST "$CDP_PROXY/eval?target=$TARGET" \
    -d "(function(){var c=document.querySelector('.article-content,.article-body,.ql-editor');return c?c.innerText:''})()" \
    | python3 -c "import sys,json;print(json.load(sys.stdin).get('value',''))")

  if [ -z "$CONTENT" ]; then
    echo "[$NUM] $TITLE — content empty, skipping"
    continue
  fi

  printf -- "---\ntitle: \"%s\"\nsource: \"https://www.dedao.cn/course/article?id=%s\"\nauthor: 万维钢\ncourse: 万维钢·现代思维工具100讲\nindex: %d\nfetched: %s\n---\n\n# %s\n\n%s\n" \
    "$TITLE" "$ART_ID" "$((i + 1))" "$(date +%Y-%m-%d)" "$TITLE" "$CONTENT" > "$OUTFILE"

  echo "[$NUM] $TITLE — saved ($(wc -c < "$OUTFILE") bytes)"
done

curl -s "$CDP_PROXY/close?target=$TARGET" > /dev/null
echo "=== Done ==="
