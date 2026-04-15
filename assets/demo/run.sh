#!/usr/bin/env bash
# kage-bunshin /brainstorm demo output
# Used by demo/brainstorm.tape via VHS

# ANSI color codes
CYAN='\033[1;36m'
YELLOW='\033[1;33m'
MAGENTA='\033[1;35m'
RESET='\033[0m'

clear

# Title
printf "${CYAN}🥷 kage-bunshin${RESET}\n"
printf "Multi-agent system for thinking, not code.\n\n"
sleep 1.5

# Simulated command input
printf "${YELLOW}> /brainstorm \"Ideas for monthly passive income\"${RESET}\n\n"
sleep 1.5

# Team spawning
printf "🌀 Spawning team...\n"
sleep 0.7
printf "   → ideator   💡  divergent thinker\n"
sleep 0.5
printf "   → analyst   🔍  critical evaluator\n\n"
sleep 1.2

# Collaboration rounds
printf "💡 Round 1: ideator generates 7 ideas\n"
sleep 0.9
printf "🔍 Round 2: analyst evaluates (F/I/N/R)\n"
sleep 0.9
printf "🎯 Round 3: consensus reached — Top 3\n\n"
sleep 1.3

# Top 3 results
printf "🏆 Results:\n"
sleep 0.4
printf "   1. Go × Cloud Run Boilerplate   3.8/5\n"
sleep 0.5
printf "   2. LicenseLane GitHub App       3.8/5\n"
sleep 0.5
printf "   3. ReleaseRadar SEO             3.4/5\n\n"
sleep 1.3

# Notebook save
printf "💾 Saved to Notebook:\n"
sleep 0.4
printf "   notebook/ideas/2026-04-15-passive-income.md\n"
sleep 0.5
printf "   notebook/reviews/2026-04-15-evaluation.md\n\n"
sleep 1.6

# Closing
printf "${MAGENTA}✨ Your thinking, multiplied.${RESET}\n"
sleep 3
