# PowerShell validation script for Milestone 02 repository artifacts

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

$requiredFiles = @(
  "docs/architecture/README.md",
  "docs/architecture/system-context.md",
  "docs/architecture/component-model.md",
  "docs/architecture/deployment-model.md",
  "docs/architecture/data-flow.md",
  "docs/architecture/repository-topology.md",
  "docs/architecture/api-and-event-contracts.md",
  "docs/architecture/tenant-isolation-model.md",
  "docs/architecture/transaction-and-concurrency-model.md",
  "docs/architecture/background-jobs-and-idempotency.md",
  "docs/architecture/data-lifecycle-and-retention.md",
  "docs/architecture/observability-and-operations.md",
  "docs/architecture/failure-mode-analysis.md",
  "docs/architecture/architecture-review-checklist.md",
  "docs/architecture/requirements-mapping.md",
  "docs/architecture/review-record.md",
  "docs/adr/README.md",
  "docs/adr/0000-adr-template.md",
  "docs/security/milestone-02-threat-model.md",
  "scripts/validate-milestone-02.ps1",
  "docs/project-status/milestone-reports/milestone-02-architecture-and-decision-records.md",
  "docs/project-status/CURRENT_STATUS.md",
  "README.md",
  "CHANGELOG.md"
)

$requiredHeadings = @{
  "docs/architecture/system-context.md" = @("## Scope","## Trust boundaries","## Tenant boundaries")
  "docs/architecture/component-model.md" = @("## Boundary model")
  "docs/architecture/deployment-model.md" = @("## Summary","## Environment definitions")
  "docs/architecture/data-flow.md" = @("## High-level API + event flow")
  "docs/architecture/repository-topology.md" = @("## Proposed repository layout")
  "docs/architecture/api-and-event-contracts.md" = @("## API split","## REST responsibilities","## WebSocket responsibilities")
  "docs/architecture/tenant-isolation-model.md" = @("## Core principle")
  "docs/architecture/background-jobs-and-idempotency.md" = @("## Operation split","## Idempotency-key contract")
  "docs/architecture/requirements-mapping.md" = @("## Mapping principle")
  "docs/adr/README.md" = @("## Status","## ADR index")
  "docs/security/milestone-02-threat-model.md" = @("## Purpose","## Threat scenarios")
}

$failCount = 0
function Fail([string]$message) {
  Write-Output "FAIL: $message"
  $script:failCount++
}

function Pass([string]$message) {
  Write-Output "PASS: $message"
}

Write-Output "== Milestone 02 validation =="

foreach ($file in $requiredFiles) {
  if (Test-Path $file) {
    Pass "required file exists: $file"
  } else {
    Fail "missing required file: $file"
  }
}

$adrFiles = Get-ChildItem -Path docs/adr -Filter "*.md" | Sort-Object Name
if (-not $adrFiles) { Fail "no ADR files found in docs/adr" }
if ($adrFiles.Count -lt 26) { Fail "expected at least 26 ADR files in docs/adr, found $($adrFiles.Count)" } else { Pass "ADR file count: $($adrFiles.Count)" }

$decisionAdrFiles = @()
foreach ($candidate in $adrFiles) {
  if ($candidate.Name -match '^\d{4}-.+\.md$' -and $candidate.Name -notlike "0000-*") {
    $decisionAdrFiles += $candidate
  }
}

if ($decisionAdrFiles.Count -lt 25) { Fail "expected at least 25 decision ADR files, found $($decisionAdrFiles.Count)" } else { Pass "Decision ADR count: $($decisionAdrFiles.Count)" }

$adrIds = @()
$adrMissingSection = @()
$adrInvalidStatus = @()
foreach ($adr in $decisionAdrFiles) {
  $text = Get-Content $adr.FullName -Raw
  if ($text -match 'ADR-(\d{4})') { $adrIds += $Matches[1] } else { $adrMissingSection += $adr.Name }
  if ($text -notmatch '(?m)^## Context' -or $text -notmatch '(?m)^## Decision' -or $text -notmatch '(?m)^## Alternatives considered' -or $text -notmatch '(?m)^## Rationale' -or $text -notmatch '(?m)^## Security implications' -or $text -notmatch '(?m)^## Approval state') {
    $adrMissingSection += $adr.Name
  }
  if ($text -notmatch '(?m)^- Status:\s*(ACCEPTED|PROPOSED|SUPERSEDED)$') {
    $adrInvalidStatus += $adr.Name
  }
}

if ($adrIds.Count -ne ($adrIds | Select-Object -Unique).Count) { Fail "ADR IDs are not unique" } else { Pass "ADR IDs are unique" }
if ($adrMissingSection.Count -gt 0) { Fail "ADR files missing required sections: $($adrMissingSection -join ', ')" } else { Pass "All ADR required sections present" }
if ($adrInvalidStatus.Count -gt 0) { Fail "ADR files with invalid status format: $($adrInvalidStatus -join ', ')" } else { Pass "ADR status format valid" }

foreach ($entry in $requiredHeadings.GetEnumerator()) {
  $path = $entry.Key
  if (-not (Test-Path $path)) { continue }
  $text = Get-Content $path -Raw
  foreach ($heading in $entry.Value) {
    if ($text -notmatch [regex]::Escape($heading)) {
      Fail "missing heading '$heading' in $path"
    } else {
      Pass "found heading '$heading' in $path"
    }
  }
}

foreach ($path in @("docs/architecture/system-context.md","docs/architecture/data-flow.md","docs/architecture/deployment-model.md")) {
  $text = Get-Content $path -Raw
  if ($text -notmatch '```mermaid') { Fail "missing mermaid diagram in $path" } else { Pass "mermaid diagram present in $path" }
}

$mapText = Get-Content "docs/architecture/requirements-mapping.md" -Raw
if ($mapText -notmatch 'PRD-[A-Z]+-\d{3}') { Fail "no PRD references found in requirements mapping" } else { Pass "PRD references present in requirements mapping" }

$failureRows = (Get-Content "docs/architecture/failure-mode-analysis.md" | Select-String '^\|\s*[0-9]+\s*\|' | Measure-Object).Count
if ($failureRows -lt 20) { Fail "failure-mode-analysis must contain at least 20 scenarios, found $failureRows" } else { Pass "failure-mode-analysis contains $failureRows scenarios" }

$checkText = Get-Content "docs/architecture/architecture-review-checklist.md" -Raw
$unexplainedFail = Select-String -Path "docs/architecture/architecture-review-checklist.md" -Pattern '\| *[^|]+ *\| *FAIL *\|' -AllMatches | Measure-Object
if ($unexplainedFail.Count -gt 0 -and $checkText -notmatch 'Reviewer note') { Fail "checklist has FAIL rows without notes" } else { Pass "checklist status rows are explained" }

$linkPattern = '\[[^\]]+\]\(([^)]+)\)'
$docsToScan = @(
  "docs/architecture/README.md",
  "docs/architecture/system-context.md",
  "docs/architecture/component-model.md",
  "docs/architecture/deployment-model.md",
  "docs/architecture/data-flow.md",
  "docs/architecture/repository-topology.md",
  "docs/architecture/api-and-event-contracts.md",
  "docs/architecture/tenant-isolation-model.md",
  "docs/architecture/transaction-and-concurrency-model.md",
  "docs/architecture/background-jobs-and-idempotency.md",
  "docs/architecture/data-lifecycle-and-retention.md",
  "docs/architecture/observability-and-operations.md",
  "docs/architecture/failure-mode-analysis.md",
  "docs/architecture/architecture-review-checklist.md",
  "docs/architecture/requirements-mapping.md",
  "docs/architecture/review-record.md",
  "docs/adr/README.md",
  "docs/security/milestone-02-threat-model.md",
  "docs/project-status/CURRENT_STATUS.md",
  "docs/project-status/milestone-reports/milestone-02-architecture-and-decision-records.md"
)

$brokenLinks = @()
foreach ($scan in $docsToScan) {
  if (-not (Test-Path $scan)) { continue }
  $base = Split-Path $scan
  foreach ($line in Get-Content $scan) {
    $matches = [regex]::Matches($line, $linkPattern)
    foreach ($m in $matches) {
      $target = $m.Groups[1].Value
      if ($target -match '^[a-zA-Z][a-zA-Z0-9+.-]*:' -or $target.StartsWith('#')) { continue }
      $candidate = Join-Path $base $target
      if (-not (Test-Path $candidate)) {
        $brokenLinks += "$scan -> $target"
      }
    }
  }
}
if ($brokenLinks.Count -gt 0) {
  Fail "broken relative links: $($brokenLinks -join '; ')"
} else {
  Pass "relative links validated"
}

$markerPattern = '\b(TODO|FIXME|TBD|PLACEHOLDER)\b'
$markerFiles = @()
foreach ($file in @("docs/architecture","docs/adr","docs/security","docs/project-status/milestone-reports") ) {
  if ($file -eq "docs/project-status/milestone-reports") { continue }
  foreach ($md in Get-ChildItem -Recurse -Path $file -Filter *.md) {
    if ((Get-Content $md.FullName -Raw) -cmatch $markerPattern) {
      $markerFiles += $md.FullName
    }
  }
}
if ($markerFiles.Count -gt 0) { Fail "unresolved placeholder markers in: $($markerFiles -join ', ')" } else { Pass "no unresolved markers detected" }

$secretPattern = '(?i)(secret|token|apikey|api[_-]?key|password)\s*[:=]\s*[`"]?[A-Za-z0-9_\-]{12,}'
$secretFiles = @()
foreach ($md in Get-ChildItem -Recurse -Path @("docs/architecture","docs/adr","docs/security","docs/project-status") -Filter *.md) {
  if ((Get-Content $md.FullName -Raw) -match $secretPattern) {
    $secretFiles += $md.FullName
  }
}
if ($secretFiles.Count -gt 0) { Fail "possible secret-like values in: $($secretFiles -join ', ')" } else { Pass "no obvious secret-like values found" }

$baseDiff = git diff --name-only -- project-plan/00_locked_product_baseline.md project-plan/01_product_specification_lock.md project-plan/ROADMAP.md
$baseDiffCount = ($baseDiff | Measure-Object).Count
if ($baseDiffCount -gt 0) {
  Fail "baseline files changed: $($baseDiff -join ', ')"
} else {
  Pass "baseline and roadmap files unchanged"
}

$forbiddenFiles = @(
  "package.json",
  "package-lock.json",
  "yarn.lock",
  "pnpm-lock.yaml",
  "gradlew",
  "gradlew.bat",
  "build.gradle",
  "build.gradle.kts",
  "settings.gradle",
  "settings.gradle.kts",
  "Dockerfile",
  "docker-compose.yml",
  "terraform.tfstate",
  "next.config.js",
  "next.config.ts"
)
$forbiddenHits = @()
foreach ($path in $forbiddenFiles) {
  $matches = Get-ChildItem -Recurse -Path . -Filter $path -ErrorAction SilentlyContinue
  foreach ($m in $matches) {
    if ($m.FullName -notlike "*node_modules*") {
      $forbiddenHits += $m.FullName
    }
  }
}
if ($forbiddenHits.Count -gt 0) {
  Fail "forbidden implementation artifacts detected: $($forbiddenHits -join ', ')"
} else { Pass "no forbidden implementation artifact references detected" }

if ($failCount -eq 0) {
  Write-Output "RESULT: PASS"
  exit 0
}

Write-Output "RESULT: FAIL ($failCount)"
exit 1
