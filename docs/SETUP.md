# LogicNest — Full Astro Site + Decap CMS + OAuth (Port 4081) + CI Deploy

## 1) Clone and install
```bash
npm i
npm run dev
```

## 2) OAuth (port 4081)
- Create a GitHub OAuth App:
  - Homepage: https://YOUR_DOMAIN
  - Callback: https://cms-auth.YOUR_DOMAIN:4081/callback
- Put Client ID/Secret into `oauth/docker-compose.yml`.
- Start the bridge:
  ```bash
  docker compose -f oauth/docker-compose.yml up -d
  ```
- Add `oauth/nginx-vhost-4081.conf` to Nginx and reload.
- In Cloudflare: set DNS for `cms-auth.YOUR_DOMAIN` to **DNS only** (gray cloud).

## 3) Admin config
`public/admin/config.yml` already points to:
```yaml
base_url: "https://cms-auth.YOUR_DOMAIN:4081"
auth_endpoint: "auth"
repo: LogicNest-Development/astrosite
branch: main
```

## 4) CI Deploy
- Edit `.github/workflows/deploy.yml` with your CloudPanel docroot/host/user.
- Create SSH key and add to server (`authorized_keys`) and add private key as GitHub Action secret `DEPLOY_SSH_KEY`.

## 5) Use it
- Visit `/admin` → Login with GitHub.
- Create Product Groups and Products. Set `showInNav` to place groups in the header.
- Publish → CI builds `dist/` and deploys to your docroot.

## 6) Existing static HTML on CloudPanel
No need to remove the site. The deploy overwrites docroot with `dist/`. Backup if you want; `--delete` keeps the docroot clean.
