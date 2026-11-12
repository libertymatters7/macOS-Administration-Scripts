# create-crashplan-deploy-properties

A small Bash script for macOS that creates the CrashPlan `deploy.properties` file so the client registers automatically on install.

## What it does

1. Runs as root, and exits if it is not.
2. Creates `/Library/Application Support/CrashPlan/deploy.properties` before the CrashPlan client is installed.
3. Writes these settings into that file:

   - `DEPLOYMENT_URL`
   - `DEPLOYMENT_POLICY_TOKEN`
   - `CP_SILENT`
   - `DEVICE_CLOAKED`

`DEPLOYMENT_URL` and `DEPLOYMENT_POLICY_TOKEN` at the top of the script are placeholders. Fill in your console URL and policy token before you deploy the script.

`CP_SILENT=true` keeps the CrashPlan app from opening after install. If `CP_SILENT` is omitted, the app opens after install.

`DEVICE_CLOAKED` should match the org Client Visibility setting in the CrashPlan console: `false` is Visible and `true` is Hidden. It only applies at initial deployment. Later, the console setting is pushed.

## Requirements

- macOS
- Run as root, before the CrashPlan client is installed

## Usage

### Jamf Pro

1. Add `create-crashplan-deploy-properties.sh` under **Settings > Computer Management > Scripts**.
2. Run the script in a policy before the CrashPlan installer package, either in the same policy or in a prior policy.

No script parameters are needed.

### Manually

```bash
sudo ./create-crashplan-deploy-properties.sh
```

### Verify

```bash
cat "/Library/Application Support/CrashPlan/deploy.properties"
```

The file should contain `DEPLOYMENT_URL`, `DEPLOYMENT_POLICY_TOKEN`, `CP_SILENT`, and `DEVICE_CLOAKED` with the values set in the script.

## Notes

- CrashPlan documents these properties in the [Deployment script and command reference](https://support.crashplan.com/hc/en-us/articles/8653225861901-Deployment-script-and-command-reference), [Show or hide CrashPlan app visibility on user devices](https://support.crashplan.com/hc/en-us/articles/8720305386125-Show-or-hide-CrashPlan-app-visibility-on-user-devices), and [Deploy CrashPlan apps](https://support.crashplan.com/hc/en-us/articles/8656896056205-Deploy-CrashPlan-apps).
- The script passes [ShellCheck](https://www.shellcheck.net/) with no warnings.

## Disclaimer

This script is provided as is, without warranty of any kind. Test it on a non-production Mac before deploying it, and use it at your own risk. The author is not responsible for any damage, data loss, or disruption caused by its use.

## AI assistance

This script and its documentation were written with AI assistance and reviewed by the author.

## License

Released under the [MIT License](../../LICENSE).
