# Yimaru: backup and Android release handover

Production paths checked read-only on **22 October 2026**. Recheck them before use. This guide does not authorize a production restore or service shutdown.

| Item | Current production setup |
| --- | --- |
| SSH | `yimaru@195.35.29.82`, port `22`; local alias `yimaru_serv` |
| VPS hostname | `srv1247499` |
| PostgreSQL | Native PostgreSQL **16**, database **`gh`**, port **`5433`**; not the development Docker database |
| Backend | `/home/yimaru/Yimaru-BackEnd/bin/web`; systemd unit `yimaru_backend.service` |
| MinIO | Container `minio`; `/srv/minio/data` mounted at `/data`; bucket `audio-prompts` |
| MinIO URLs | S3 API: `https://s3.yimaruacademy.com`; console: `https://min.yimaruacademy.com` |
| Android app | Existing Play Console app, package `com.yimaru.lms.app` |

Obtain Hostinger, Play Console, repository, and secrets-vault access from the owner. Keep backups, `.env`, SSH private keys, signing keys/passwords, and MinIO credentials **outside Git**, encrypted and access-restricted. Keep an off-VPS copy; a backup on the same server is not sufficient.

## 1. SSH access and PostgreSQL backup

### Set up your own SSH key — on your laptop

```bash
mkdir -p "$HOME/.ssh"
chmod 700 "$HOME/.ssh"
ssh-keygen -t ed25519 -a 100 -C "your-work-email" -f "$HOME/.ssh/yimaru_vps"
```

Choose a passphrase. Do not overwrite an existing key. Give **only** `yimaru_vps.pub` to the existing administrator, who must append it to `/home/yimaru/.ssh/authorized_keys`, without replacing existing keys. A Hostinger root SSH key does not automatically authorize the `yimaru` account. Never share the private key or put it in the project directory.

Add this entry to your laptop's `~/.ssh/config` (merge with existing entries):

```sshconfig
Host yimaru_serv
    HostName 195.35.29.82
    User yimaru
    Port 22
    IdentityFile ~/.ssh/yimaru_vps
    IdentitiesOnly yes
```

Verify the server host-key fingerprint with the owner/Hostinger console before accepting it, then test `ssh yimaru_serv`. Confirm the new access works before any old access is revoked. Obtain sudo permission for the following backup commands; do not embed server passwords in scripts. [Hostinger SSH-key guide](https://www.hostinger.com/support/4792364-how-to-use-ssh-keys-at-hostinger-vps/).

### Download a full database backup — from your laptop

Open a **Bash** session first (run `bash`), with PostgreSQL 16 client tools (`pg_restore`) installed. Keep this terminal open for the MinIO steps. These commands write locally and only read production; they set private permissions but do not encrypt the files. Use encrypted storage for the backup directory.

```bash
set -e
umask 077
backup_dir="$HOME/Yimaru-backups/$(date -u +%Y%m%dT%H%M%SZ)"
mkdir -p "$backup_dir"

ssh -T yimaru_serv 'sudo -n -u postgres pg_dump -p 5433 -d gh -Fc' \
  > "$backup_dir/gh.dump.partial"
mv "$backup_dir/gh.dump.partial" "$backup_dir/gh.dump"

ssh -T yimaru_serv 'sudo -n -u postgres pg_dumpall -p 5433 --globals-only' \
  > "$backup_dir/roles.sql.partial"
mv "$backup_dir/roles.sql.partial" "$backup_dir/roles.sql"

pg_restore --list "$backup_dir/gh.dump" > "$backup_dir/gh.contents.txt"
shasum -a 256 "$backup_dir/gh.dump" "$backup_dir/roles.sql" \
  > "$backup_dir/SHA256SUMS"
```

Stop if anything fails; `.partial` files are not completed backups. **Do not add `ssh -t`**: a terminal can corrupt binary dump output. This custom-format dump includes schema and data; `roles.sql` contains sensitive role/password metadata. The backend's existing `make backup` is data-only and assumes development Docker names, so do not use it as this production backup procedure.

`pg_restore --list` checks readability, not successful recovery. Before relying on a backup, restore it into an **isolated disposable PostgreSQL 16 instance**, then check users, subscriptions, progress and media references. Never run a trial restore against production. PostgreSQL provides a consistent database snapshot, but not a coordinated snapshot with MinIO. [PostgreSQL backup reference](https://www.postgresql.org/docs/16/app-pgdump.html).

## 2. Create a Hostinger VPS snapshot

1. Sign in to **Hostinger hPanel → VPS → Manage** for `195.35.29.82` / `srv1247499`.
2. Open **Backups & Monitoring → Snapshots & Backups → Create Snapshot**.
3. Wait until it finishes; record its creation/expiry time before making server changes. Schedule for low traffic because availability/performance may be affected.
4. Check scheduled VPS backups are also enabled. A snapshot is a short-term rollback checkpoint, not a substitute for the downloaded database/media backups.

Hostinger currently permits one snapshot; creating another replaces it, and snapshots expire after **one day**. Confirm the retention shown in hPanel. **Restore overwrites the entire VPS**, including newer customer data: obtain explicit approval and fresh backups first. [Hostinger snapshot/backup guide](https://www.hostinger.com/support/1583232-how-to-back-up-or-restore-a-vps-at-hostinger/).

## 3. Back up MinIO data

Install the official [MinIO client (`mc`)](https://minio.github.io/mc/) on your laptop. Get a key allowed to list/read all objects in `audio-prompts` from the owner; do not assume the development credentials work in production.

In a **second terminal**, open this SSH tunnel and leave it running:

```bash
ssh -N -o ExitOnForwardFailure=yes \
  -L 127.0.0.1:19000:127.0.0.1:9000 yimaru_serv
```

Back in the original Bash backup terminal (`backup_dir` is still set):

```bash
read -r -p "MinIO access key: " minio_access_key
read -r -s -p "MinIO secret key: " minio_secret_key
printf '\n'
mc alias set yimaru_backup http://127.0.0.1:19000 \
  "$minio_access_key" "$minio_secret_key"
unset minio_access_key minio_secret_key

mc ls yimaru_backup
mkdir -p "$backup_dir/minio/audio-prompts"
mc mirror yimaru_backup/audio-prompts "$backup_dir/minio/audio-prompts"
find "$backup_dir/minio/audio-prompts" -type f -exec shasum -a 256 {} + \
  > "$backup_dir/minio/SHA256SUMS"
```

The credentials are stored in your local `mc` configuration: protect it and never commit it. Repeat the mirror for any additional buckets listed by `mc ls`. Use a new dated directory per backup; **never reverse source/destination or add `--remove`**. Check the mirror exits successfully and open sample downloaded images/audio/files. Close the tunnel with Ctrl+C afterward.

This is a **current-object data copy**, not a full version-history/metadata backup. With an administrator-configured alias, also export settings into the backup directory using `mc admin cluster bucket export yimaru_backup` and `mc admin cluster iam export yimaru_backup` (run from that directory; confirm support in your server/client version). Keep MinIO credentials/container configuration in the vault and retain a VPS snapshot. Do not archive `/srv/minio/data` live and assume it is consistent. Full storage-level backups require an approved maintenance/consistency plan. Coordinate database/media backups during a quiet write window if a matching recovery point is required. [Mirror limitations](https://docs.min.io/aistor/reference/cli/mc-mirror/).

## 4. Build a signed Android App Bundle

Install the project's Flutter SDK, Android SDK and JDK 17. Obtain the **existing** upload keystore and its passwords securely; do not generate a replacement signing key.

- Default Makefile path: `/Users/kerod/keystores/yimaru-upload-keystore.jks`.
- On another developer's Mac, put it outside the repository, for example `~/keystores/yimaru-upload-keystore.jks`, and pass `UPLOAD_KEYSTORE` as below.
- Create the ignored `android/key.properties` locally:

```properties
keyAlias=upload
keyPassword=RETRIEVE_FROM_VAULT
storePassword=RETRIEVE_FROM_VAULT
storeFile=/absolute/path/to/yimaru-upload-keystore.jks
```

From `Yimaru-Mobile`:

```bash
flutter pub get
make bump-version
flutter analyze
flutter test
make appbundle UPLOAD_KEYSTORE="$HOME/keystores/yimaru-upload-keystore.jks"
```

If the version has already been bumped for this release, skip `make bump-version`. `pubspec.yaml` is `version-name+version-code`; use a code higher than every previously uploaded build. Commit the release's code/version changes. `make appbundle` selects the external keystore and builds only; it does not increment versions or upload anything.

Output: **`build/app/outputs/bundle/release/app-release.aab`**. Keep the exact tested bundle and its checksum (`shasum -a 256 build/app/outputs/bundle/release/app-release.aab`). See [README.md](README.md#android-releases) for signing details.

## 5. Closed testing first, then production

1. Open [Google Play Console](https://play.google.com/console), select the **existing Yimaru app** (`com.yimaru.lms.app`), then **Test and release → Testing → Closed testing → Manage track**.
2. Configure the **Testers** email list/Google Group. Create a release, upload the `.aab` above, add release notes, resolve validation errors, and submit/start the closed-track rollout. Complete review/publishing steps shown in **Publishing overview**; saving a draft is not a release.
3. Share the opt-in link. Testers must join with an allowed Google account and install/update **through Google Play**, not a sideloaded build. Verify the installed version/code. Check tester-country availability; internal-track enrollment can prevent receiving the closed-track build. [Closed-testing setup](https://support.google.com/googleplay/android-developer/answer/9845334?hl=en).
4. Test login/refresh, existing-user upgrade, lesson/practice progression, subscriptions/payments with approved tester procedures, media playback, notifications and English/Amharic. Record results and check crashes/ANRs. Do not promote a failing build; fixes require a new version code and another closed test.
5. After sign-off, promote the **same tested bundle** to Production if offered, or open **Test and release → Production → Create new release → Add from library** and select its exact version code. Do not rebuild or upload a different artifact under that code.
6. Add production release notes, complete review, then use a staged rollout where available. Monitor crashes, login, payments and progression before expanding. Halt the rollout if problems appear; it does not downgrade installed apps, so a fix needs a higher version code. [Release procedure](https://support.google.com/googleplay/android-developer/answer/9859348?hl=en).

Before enabling a forced update in Admin, confirm the required build is actually available to **all affected production users**, not just closed testers or a partial rollout.
