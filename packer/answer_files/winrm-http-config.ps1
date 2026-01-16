# Change network category to Private (fix for Enable-PSRemoting issue)
$networks = Get-NetConnectionProfile
foreach ($net in $networks) {
    if ($net.NetworkCategory -eq "Public") {
        Set-NetConnectionProfile -InterfaceIndex $net.InterfaceIndex -NetworkCategory Private
    }
}

# Enable WinRM
Enable-PSRemoting -Force

# Allow unencrypted communication
Set-Item -Path WSMan:\localhost\Service\AllowUnencrypted -Value $true

# Enable Basic authentication
Set-Item -Path WSMan:\localhost\Service\Auth\Basic -Value $true

# Disable Windows Firewall to ensure WinRM works
Set-NetFirewallProfile -Profile Domain,Private,Public -Enabled False