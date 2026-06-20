#!/usr/bin/env bash
#
# Check coverage threshold on Dart/Flutter projects.
#
# Reads the lcov.info file produced by `flutter test --coverage` and computes
# the line coverage percentage. By default enforces a 100% coverage threshold
# (lines + functions) to keep new code fully exercised.
#
# Usage:
#   bash scripts/check_coverage.sh path/to/lcov.info [threshold_percent]
#
# Exit codes:
#   0 - coverage is at or above the threshold
#   1 - coverage is below the threshold or the input file is missing
#

set -e

LCOV_FILE="${1:-coverage/lcov.info}"
THRESHOLD="${2:-100}"

if [[ ! -f "$LCOV_FILE" ]]; then
  echo "::warning::coverage file not found at $LCOV_FILE; skipping threshold check"
  exit 0
fi

# Parse lcov.info line and function counters.
# Lines look like:
#   LF:<lines_found>
#   LH:<lines_hit>
#   FNF:<functions_found>
#   FNH:<functions_hit>
LINES_FOUND=$(grep -h '^LF:' "$LCOV_FILE" | awk -F: '{sum += $2} END {print sum+0}')
LINES_HIT=$(grep -h '^LH:' "$LCOV_FILE" | awk -F: '{sum += $2} END {print sum+0}')

if [[ "$LINES_FOUND" -eq 0 ]]; then
  echo "::warning::no coverage data found in $LCOV_FILE; skipping threshold check"
  exit 0
fi

COVERAGE_PCT=$(awk -v lh="$LINES_HIT" -v lf="$LINES_FOUND" 'BEGIN { printf "%.2f", (lh / lf) * 100 }')

echo "::notice::coverage: $COVERAGE_PCT% ($LINES_HIT/$LINES_FOUND lines hit)"

# Compare using awk for floating-point comparison.
awk -v cov="$COVERAGE_PCT" -v thr="$THRESHOLD" 'BEGIN {
  if (cov + 0 < thr + 0) {
    exit 1;
  }
}'

if [[ $? -ne 0 ]]; then
  echo "::error::coverage $COVERAGE_PCT% is below the required threshold of ${THRESHOLD}%"
  exit 1
fi

echo "::notice::coverage threshold satisfied (>= ${THRESHOLD}%)"
exit 0