# 🚀 Georgia n8n Automation - Standalone Deployment Guide (Render)

This repository contains everything needed to deploy and run **n8n** as a 100% independent, cloud automation service on **Render.com**.

---

## 📁 Repository Structure

```text
georgia_n8n_automation/
├── Dockerfile                   # Official n8n Docker image configured for Render
├── render.yaml                  # Render Infrastructure Blueprint
├── .env.example                 # Environment variables reference
├── RENDER_DEPLOY_GUIDE.md       # This step-by-step guide
└── workflows/
    ├── 1_live_crash_monitor_and_ingestion.json   # Incident ingestion & severity filter
    └── 2_multi_channel_ads_automation.json       # Google, Meta, Snapchat ads dispatcher
```

---

## 🛠️ Step 1: Push This Folder to a New GitHub Repository

1. Create a new repository on [GitHub](https://github.com/new) named `georgia_n8n_automation`.
2. In your terminal inside this folder, run:
```powershell
git init
git add .
git commit -m "Initial commit: standalone n8n automation for Georgia Crash Platform"
git branch -M main
git remote add origin https://github.com/<YOUR_GITHUB_USERNAME>/georgia_n8n_automation.git
git push -u origin main
```

---

## 🌐 Step 2: Deploy to Render (Takes ~3 Minutes)

1. Go to **[https://dashboard.render.com/](https://dashboard.render.com/)** and log in.
2. Click **"New +"** (top right) $\rightarrow$ select **"Web Service"**.
3. Choose **"Build and deploy from a Git repository"** and select your `georgia_n8n_automation` repository.
4. Configure the Web Service:
   - **Name:** `n8n-georgia-automation`
   - **Language / Runtime:** **Docker**
   - **Branch:** `main`
   - **Region:** Any (e.g. *Oregon (US West)* or *Ohio (US East)*)
   - **Instance Type:**
     - **Free Plan:** Free ($0/mo) — great for testing. *(Note: Free instances sleep after 15 min of inactivity and don't support persistent disks)*.
     - **Starter Plan ($7/mo):** Recommended for 24/7 background cron jobs & persistent disk storage.

---

## 🔑 Step 3: Add Environment Variables in Render

In Render, under the **Environment Variables** section:

| Key | Value | Description |
| :--- | :--- | :--- |
| `N8N_PORT` | `5678` | Internal n8n listening port |
| `PORT` | `5678` | Render public routing port |
| `N8N_PROTOCOL` | `https` | Enables HTTPS webhook routing |
| `WEBHOOK_URL` | `https://n8n-georgia-automation.onrender.com/` | Replace with your exact Render assigned URL |
| `N8N_ENCRYPTION_KEY` | *(Click "Generate" or provide 32 random chars)* | Encrypts workflow credentials |
| `GENERIC_TIMEZONE` | `America/New_York` | Georgia timezone |
| `DJANGO_BACKEND_URL` | `https://your-django-backend.vercel.app` | Your Django API endpoint |

*(Optional if using Starter Plan)*: Under **Advanced** $\rightarrow$ **Disks**, add a disk named `n8n-data`, mount path `/home/node/.n8n`, size `1 GB`.

5. Click **"Create Web Service"**. Render will build and launch your container.

---

## 📥 Step 4: Import Workflows into n8n

1. Open your live URL (e.g. `https://n8n-georgia-automation.onrender.com`).
2. Create your admin account (email & password).
3. In the n8n sidebar, go to **Workflows** $\rightarrow$ Click **"Add workflow"** $\rightarrow$ Click the **3 dots (...)** in the top right $\rightarrow$ **"Import from File"**.
4. Import both JSON files from the `workflows/` folder:
   - `1_live_crash_monitor_and_ingestion.json`
   - `2_multi_channel_ads_automation.json`
5. Click **"Publish / Activate"** toggle on both workflows.

---

## 🎯 Step 5: Test Webhook Endpoints

Your live webhook URLs are ready to receive data:
- **Incident Ingestion Webhook:**
  `POST https://n8n-georgia-automation.onrender.com/webhook/ingest-live-crash`
- **Ads Dispatcher Webhook:**
  `POST https://n8n-georgia-automation.onrender.com/webhook/trigger-crash-ads`
