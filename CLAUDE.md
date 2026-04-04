# Kage Bunshin - Second Brain Agent System

開発以外の知的作業を複数の特化型エージェントが協力して行うClaude Code用OSSエージェントシステム。

## アーキテクチャ

### Agents (`.claude/agents/`)
4種の特化型エージェント。各エージェントは固有の思考スタイルを持ち、成果物を自ら書き出す。
- **ideator** - 発散思考、ブレインストーミング、創造的アイデア生成
- **analyst** - 批判的分析、リスク評価、品質レビュー、実現可能性判断
- **planner** - タスク分解、スケジューリング、依存関係管理
- **researcher** - 深い調査、情報収集、多角的検証

### Skills (`.claude/skills/`)
複数エージェントをオーケストレーションするワークフロー。
- `/brainstorm` - ideator + analyst による多角的アイデア出し
- `/evaluate` - researcher + analyst による構造化評価
- `/plan-project` - researcher + planner による目標分解
- `/retrospect` - analyst による振り返りとNotebook保存
- `/notebook` - Notebook の検索・管理操作

### Notebook
ユーザー固有のデータを保存する**別リポジトリ**。成果物はすべてフロントマター付きMarkdownで構造化。

#### Notebook設定
```json
// .claude/settings.local.json
{
  "env": {
    "NOTEBOOK_PATH": "/path/to/your/notebook-repo"
  },
  "permissions": {
    "additionalDirectories": ["/path/to/your/notebook-repo"]
  }
}
```

- `NOTEBOOK_PATH`: Notebookリポジトリの絶対パス
- `additionalDirectories`: Notebookは外部リポジトリのため、Claude Codeのファイル操作許可範囲に追加が必要

#### Notebookエントリ形式
```markdown
---
title: エントリ名
type: idea | decision | learning | plan | evaluation | research | note
date: YYYY-MM-DD
project: プロジェクト名
tags: [tag1, tag2]
related: [path/to/related.md]
---
本文
```

## ルール
- 各エージェントは成果物を自ら書き出す
- Notebook未設定の場合、成果物の永続化はスキップし結果のみ出力する
- 各エージェントは自身の専門領域外の作業を行わない
- スキルは必ず複数エージェントの協調で動作する
- 出力言語はユーザーの言語に合わせる（デフォルト: 日本語）
- Notebookへの書き込みは必ず構造化フロントマター付き
