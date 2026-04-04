<p align="center">
  <img src="assets/banner.svg" alt="Kage Bunshin - AI agents for knowledge work, not code" width="100%">
</p>

<p align="center">

[English](README.md) | [日本語](README_ja.md)

</p>

<p align="center">
  <a href="LICENSE"><img src="https://img.shields.io/badge/license-MIT-blue.svg" alt="License: MIT"></a>
  <a href="https://github.com/qkitzero/kage-bunshin/stargazers"><img src="https://img.shields.io/github/stars/qkitzero/kage-bunshin?style=social" alt="Stars"></a>
  <img src="https://img.shields.io/badge/Claude%20Code-compatible-blueviolet" alt="Claude Code compatible">
  <a href="https://github.com/qkitzero/kage-bunshin/pulls"><img src="https://img.shields.io/badge/PRs-welcome-brightgreen.svg" alt="PRs Welcome"></a>
</p>

# Kage Bunshin

複数の特化型AIエージェントが、ブレインストーミング・評価・計画・調査・振り返りなど、コーディング以外の知的作業を協力して行うClaude Code用エージェントシステムです。

---

## 特徴

**思考特化のエージェントシステム** — 多くのAIエージェントがコーディングを支援する中、Kage Bunshinはあなたの「考える力」を拡張します。アイデア創出、批判的評価、プロジェクト計画、リサーチ、振り返りをカバーします。

**Notebook** — エージェントの成果物を保存する専用のgitリポジトリ。アイデア、意思決定、学びがプロジェクトを跨いでも失われません。あなたの知識がどこにでも持ち運べます。

**多角的コラボレーション** — 異なる思考スタイルを持つ複数のエージェントが協調して取り組みます。Ideatorがアイデアを広げ、Analystがそれを研ぎ澄ます。盲点をカバーします。

**構造化されたナレッジグラフ** — 全ての出力はフロントマター、タグ、相互参照付きのMarkdownで構造化されています。人間が読んでも、機械が検索しても使いやすい形式です。

---

## クイックスタート

### 前提条件

- [Claude Code](https://docs.anthropic.com/en/docs/claude-code) がインストール済みであること

### セットアップ

1. リポジトリをクローンする

```bash
git clone https://github.com/qkitzero/kage-bunshin.git
```

2. `.claude/` ディレクトリを自分のプロジェクトにコピーする

```bash
cp -r kage-bunshin/.claude/ /path/to/your/project/.claude/
```

または、プラグインとしてそのまま利用することもできます。

3. (オプション) Notebookのパスを設定する

プロジェクトの `.claude/settings.local.json` に以下を追加します：

```json
{
  "env": {
    "NOTEBOOK_PATH": "/path/to/your/notebook-repo"
  },
  "permissions": {
    "additionalDirectories": ["/path/to/your/notebook-repo"]
  }
}
```

4. (オプション) 出力言語を設定する

```json
{
  "env": {
    "OUTPUT_LANGUAGE": "ja"
  }
}
```

5. Claude Codeを起動して、スキルを使い始めましょう！

---

## 使い方

Kage BunshinはClaude Codeのスキル（スラッシュコマンド）として利用します。

### ブレインストーミング

IdeatorとAnalystが協力して、多角的なアイデア出しを行います。

```
/brainstorm "新しいSaaSアプリのアイデア"
```

### 評価

ResearcherとAnalystが協力して、構造化された実現可能性評価を行います。

```
/evaluate "モバイルファーストのタスク管理アプリ"
```

### プロジェクト計画

ResearcherとPlannerが協力して、リサーチに基づいたプロジェクト計画を立てます。

```
/plan-project "個人ブログの構築"
```

### 振り返り

Analystが構造化された振り返りを行い、教訓を抽出します。

```
/learning "Q1のプロジェクト振り返り"
```

### Notebook操作

Notebookの検索・管理を行います。

```
/notebook search "API設計"
```

---

## エージェント一覧

Kage Bunshinには4種の特化型エージェントが存在します。各エージェントは固有の思考スタイルを持ち、成果物を自ら書き出します。

| エージェント | 役割 | 思考スタイル |
|---|---|---|
| Ideator | 発散思考、ブレインストーミング | 可能性を広げる。「もし〜だったら？」を繰り返し、制約を外して自由に発想する |
| Analyst | 批判的分析、リスク評価、品質レビュー | エビデンスに基づく分析。評価とレビューの両面で建設的なフィードバックを提供する |
| Planner | タスク分解、スケジューリング | 全体を俯瞰し、段階的に分解する。依存関係とリスクを考慮した現実的な計画 |
| Researcher | 深い調査、情報収集 | 多角的検証と体系的な情報整理。一次情報を重視し、バイアスに注意する |

---

## Notebook

### Notebookとは

Notebookは、エージェントの成果物を保存するための専用gitリポジトリです。通常のプロジェクトリポジトリとは別に管理されます。

### なぜ別リポジトリなのか

- **ポータビリティ**: プロジェクトが変わっても、あなたの知識は持ち運べます
- **プライバシー**: 個人的な思考やアイデアをプロジェクトリポジトリに混ぜません
- **衝突回避**: メインリポジトリのgit履歴を汚しません
- **永続性**: プロジェクトが終了しても、学びや知見は残り続けます

### ディレクトリ構造

```
notebook-repo/
├── ideas/        # アイデア（ideator）
├── reviews/      # 評価・レビュー（analyst）
├── research/     # リサーチレポート（researcher）
├── plans/        # プロジェクト計画（planner）
├── learnings/    # 振り返り・教訓（analyst via /learning）
└── index.md      # マスターインデックス（検索用）
```

### エントリの形式

全てのNotebookエントリは、フロントマター付きのMarkdownです。

```markdown
---
title: エントリ名
type: idea | review | research | plan | learning
date: YYYY-MM-DD
project: プロジェクト名
tags: [tag1, tag2]
related: [path/to/related.md]
---

本文をここに記述します。
```

---

## カスタマイズ

### 独自のエージェントを追加する

`.claude/agents/` にMarkdownファイルを作成します。

```markdown
---
name: my-agent
model: sonnet
description: >
  エージェントの説明文。
tools:
  - Read
  - Grep
  - Glob
---

# エージェント名 - Kage Bunshin

あなたはKage Bunshinの**[役割名]**エージェントです。

## 性格・思考スタイル
[エージェントの性格と思考の特徴を記述]

## 出力フォーマット
[出力のテンプレートを定義]

## Notebook連携
[Notebook保存のルールを定義]

## 制約
[エージェントの行動制約を定義]
```

### 既存エージェントの修正

`.claude/agents/` 内の対応するMarkdownファイルを直接編集してください。思考スタイル、出力フォーマット、使用するツールなどを自由にカスタマイズできます。

### カスタムスキルの作成

`.claude/skills/` にスキル定義ファイルを作成し、複数のエージェントを組み合わせた新しいワークフローを定義できます。

### Notebook構造の拡張

Notebookのディレクトリ構造は自由に拡張できます。新しいカテゴリを追加する場合は、対応するエージェントのNotebook連携セクションも更新してください。

---

## 設計思想

### 認知のパートナー

Kage Bunshinは単なるツールではなく、あなたの思考を拡張する「認知のパートナー」です。各エージェントはそれぞれ異なる思考の専門性を持っており、一人では難しい多角的な検討を、エージェント間の協調によって実現します。

### "より速く"ではなく"より良く"考える

このシステムの目的は、思考を自動化することではありません。人間が見落としがちな視点を補い、思考の質を高めることです。Analystはあなたのアイデアに穴がないか検証し、Ideatorは固定観念を打ち破る新しい可能性を提示します。

### あなたと共に育つ知識

Notebookに蓄積された知識は、時間とともに価値を増します。過去のアイデア、意思決定の記録、学んだ教訓が相互に参照され、あなただけのナレッジグラフを形成します。プロジェクトが変わっても、マシンが変わっても、あなたの知識はあなたと共に移動します。

---

<p align="center">
  このプロジェクトが役に立ったら ⭐ をお願いします
</p>
