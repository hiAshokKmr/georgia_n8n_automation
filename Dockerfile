FROM n8nio/n8n:latest

# Set timezone for Georgia / Eastern Standard Time
ENV GENERIC_TIMEZONE=America/New_York
ENV TZ=America/New_York

USER node
WORKDIR /home/node

EXPOSE 5678
CMD ["n8n", "start"]
