Import-Module CloudEvents.Sdk

function Process-Init {

}

function Process-Handler{
    param(
        [Parameter()]
        $CloudEvent)

    Write-Host $CloudEvent.Source

    # Event Processing Delay
    Start-Sleep -Seconds 5
}