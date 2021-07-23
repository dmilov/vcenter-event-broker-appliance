
# Send sequence of events
1..3 | ForEach-Object {
    $PORT = 52673
    $serverUrl = "http://localhost:$PORT/"
    $cloudEvent = New-CloudEvent -Type 'test' -Source "test-source$($_)" -Id $_
    $wrData = $cloudEvent | ConvertTo-HttpMessage -ContentMode Structured
    Invoke-WebRequest -Uri $serverUrl -Headers $wrData.Headers -Body $wrData.Body
}

# Send events in parallel
4..6 | ForEach-Object -Parallel {
    $PORT = 52673
    $serverUrl = "http://localhost:$PORT/"
    $cloudEvent = New-CloudEvent -Type 'test' -Source "test-source$($_)" -Id $_
    $wrData = $cloudEvent | ConvertTo-HttpMessage -ContentMode Structured
    Invoke-WebRequest -Uri $serverUrl -Headers $wrData.Headers -Body $wrData.Body
}
