# configure-mau-autoupdate

A small Bash script for macOS that sets **Microsoft AutoUpdate (MAU)** to automatically download and install Microsoft 365 (Office) updates for the logged-in user.

## What it does

1. Finds the user currently logged in at the console.
2. Exits quietly if no one is logged in (for example, at the login window).
3. Runs the following as that user:

   ```bash
   defaults write com.microsoft.autoupdate2 HowToCheck -string "AutomaticDownload"
   ```

   `AutomaticDownload` tells MAU to download and install updates on its own, without prompting the user.

The setting is written in the user's context because MAU reads `HowToCheck` from the user's preferences.

## Requirements

- macOS with Microsoft AutoUpdate installed (it ships with Microsoft 365 apps)
- Run as root, so the script can act as the logged-in user

## Usage

### Jamf Pro

1. Add `configure-mau-autoupdate.sh` under **Settings > Computer Management > Scripts**.
2. Create a policy that runs the script. A monthly recurring check-in works well, so the setting is reapplied if a user changes it.
3. Scope the policy to the Macs you want managed.

No script parameters are needed.

### Manually

```bash
sudo ./configure-mau-autoupdate.sh
```

### Verify

As the logged-in user:

```bash
defaults read com.microsoft.autoupdate2 HowToCheck
```

Expected output: `AutomaticDownload`

## Notes

- A configuration profile that manages `com.microsoft.autoupdate2` takes precedence over this setting.
- The script passes [ShellCheck](https://www.shellcheck.net/) with no warnings.

## Disclaimer

This script is provided as is, without warranty of any kind. Test it on a non-production Mac before deploying it, and use it at your own risk. The author is not responsible for any damage, data loss, or disruption caused by its use.

## AI assistance

This script and its documentation were written with AI assistance and reviewed by the author.

## License

Released under the [MIT License](../../LICENSE).
