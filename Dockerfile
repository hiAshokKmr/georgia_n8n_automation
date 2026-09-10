FROM n8nio/n8n:latest

# Set timezone for Georgia / Eastern Standard Time
ENV GENERIC_TIMEZONE=America/New_York
ENV TZ=America/New_York

# Optimize Node memory for 512MB Render free tier
ENV NODE_OPTIONS="--max-old-space-size=400"
ENV N8N_METRICS=false
ENV N8N_HIRING_BANNER=false
ENV N8N_VERSION_NOTIFICATIONS_ENABLED=false
