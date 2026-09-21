$ErrorActionPreference = 'Stop'

$packageRoot = Split-Path -Parent $PSScriptRoot
$workflowPath = Join-Path $packageRoot 'workflow\google-review-request-sms.json'
$raw = Get-Content -Raw -LiteralPath $workflowPath
$workflow = $raw | ConvertFrom-Json

$errors = [System.Collections.Generic.List[string]]::new()

if ($workflow.name -ne 'Template: Google review request by SMS, once per customer') {
    $errors.Add('Unexpected workflow name.')
}

$requiredNodes = @(
    'Job done',
    'Your settings',
    'Prepare the ask',
    'Wait until send time',
    'Texts you sent them',
    'Asked before?',
    'Send the review ask',
    'Tell the owner it went out',
    'Tell the owner it was skipped',
    'Tell the owner it failed'
)

$nodeNames = @($workflow.nodes | ForEach-Object { $_.name })
foreach ($nodeName in $requiredNodes) {
    if ($nodeName -notin $nodeNames) {
        $errors.Add("Missing required node: $nodeName")
    }
}

if ($workflow.PSObject.Properties.Name -contains 'credentials') {
    $errors.Add('Workflow-level credentials block must not be present.')
}

foreach ($node in @($workflow.nodes)) {
    if ($node.PSObject.Properties.Name -contains 'credentials') {
        $errors.Add("Credential reference remains on node: $($node.name)")
    }
}

$requiredPlaceholders = @(
    'Your Business',
    '+15555550100',
    '+15555550199',
    'YOUR-REVIEW-LINK'
)

foreach ($placeholder in $requiredPlaceholders) {
    if (-not $raw.Contains($placeholder)) {
        $errors.Add("Missing sanitized placeholder: $placeholder")
    }
}

$forbiddenPatterns = @(
    '(?i)api[_-]?key\s*[:=]\s*[A-Za-z0-9_-]{16,}',
    '(?i)auth[_-]?token\s*[:=]\s*[A-Za-z0-9_-]{16,}',
    '(?i)AC[a-f0-9]{32}',
    '(?i)https://matthewsautomation\.app\.n8n\.cloud/webhook/',
    '(?i)portal\.matthewsautomation\.net/api/'
)

foreach ($pattern in $forbiddenPatterns) {
    if ($raw -match $pattern) {
        $errors.Add("Possible secret or production identifier matched: $pattern")
    }
}

$connections = @($workflow.connections.PSObject.Properties.Name)
foreach ($source in $connections) {
    if ($source -notin $nodeNames) {
        $errors.Add("Connection source does not exist: $source")
    }
}

if ($errors.Count -gt 0) {
    $errors | ForEach-Object { Write-Error $_ }
    exit 1
}

Write-Output "PASS: $($workflow.nodes.Count) nodes, required paths present, placeholders intact, no credential references or obvious production identifiers found."
